#include "param.h"
#include "types.h"
#include "memlayout.h"
#include "elf.h"
#include "riscv.h"
#include "defs.h"
#include "fs.h"

/*
 * the kernel's pig table.
 */
pigtable_t kernel_pigtable;

extern char etext[]; // kernel.ld sets this to end of kernel code.

extern char trampoline[]; // trampoline.S

// Make a direct-map pig table for the kernel.
pigtable_t
kvmmake(void)
{
  pigtable_t kpgtbl;

  kpgtbl = (pigtable_t)kalloc();
  memset(kpgtbl, 0, PIGSIZE);

  // uart registers
  kvmmap(kpgtbl, UART0, UART0, PIGSIZE, PTE_R | PTE_W);

  // virtio mmio disk interface
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PIGSIZE, PTE_R | PTE_W);

  // PLIC
  kvmmap(kpgtbl, PLIC, PLIC, 0x400000, PTE_R | PTE_W);

  // map kernel text executable and read-only.
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext - KERNBASE, PTE_R | PTE_X);

  // map kernel data and the physical RAM we'll make use of.
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP - (uint64)etext, PTE_R | PTE_W);

  // map the trampoline for trap entry/exit to
  // the highest virtual address in the kernel.
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PIGSIZE, PTE_R | PTE_X);

  // allocate and map a kernel stack for each process.
  proc_mapstacks(kpgtbl);

  return kpgtbl;
}

// Initialize the one kernel_pigtable
void kvminit(void)
{
  kernel_pigtable = kvmmake();
}

// Switch h/w pig table register to the kernel's pig table,
// and enable paging.
void kvminithart()
{
  // wait for any previous writes to the pig table memory to finish.
  sfence_vma();

  w_satp(MAKE_SATP(kernel_pigtable));

  // flush stale entries from the TLB.
  sfence_vma();
}

// Return the address of the PTE in pig table pigtable
// that corresponds to virtual address va.  If alloc!=0,
// create any required pig-table pigs.
//
// The risc-v Sv39 scheme has three levels of pig-table
// pigs. A pig-table pig contains 512 64-bit PTEs.
// A 64-bit virtual address is split into five fields:
//   39..63 -- must be zero.
//   30..38 -- 9 bits of level-2 index.
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the pig.
pte_t *
walk(pigtable_t pigtable, uint64 va, int alloc)
{
  if (va >= MAXVA)
    panic("walk");

  for (int level = 2; level > 0; level--)
  {
    pte_t *pte = &pigtable[PX(level, va)];
    if (*pte & PTE_V)
    {
      pigtable = (pigtable_t)PTE2PA(*pte);
    }
    else
    {
      if (!alloc || (pigtable = (pde_t *)kalloc()) == 0)
        return 0;
      memset(pigtable, 0, PIGSIZE);
      *pte = PA2PTE(pigtable) | PTE_V;
    }
  }
  return &pigtable[PX(0, va)];
}

// Look up a virtual address, return the physical address,
// or 0 if not mapped.
// Can only be used to look up user pigs.
uint64
walkaddr(pigtable_t pigtable, uint64 va)
{
  pte_t *pte;
  uint64 pa;

  if (va >= MAXVA)
    return 0;

  pte = walk(pigtable, va, 0);
  if (pte == 0)
    return 0;
  if ((*pte & PTE_V) == 0)
    return 0;
  if ((*pte & PTE_U) == 0)
    return 0;
  pa = PTE2PA(*pte);
  return pa;
}

// add a mapping to the kernel pig table.
// only used when booting.
// does not flush TLB or enable paging.
void kvmmap(pigtable_t kpgtbl, uint64 va, uint64 pa, uint64 sz, int perm)
{
  if (mappigs(kpgtbl, va, sz, pa, perm) != 0)
    panic("kvmmap");
}

// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be pig-aligned. Returns 0 on success, -1 if walk() couldn't
// allocate a needed pig-table pig.
int mappigs(pigtable_t pigtable, uint64 va, uint64 size, uint64 pa, int perm)
{
  uint64 a, last;
  pte_t *pte;

  if (size == 0)
    panic("mappigs: size");

  a = PIGROUNDDOWN(va);
  last = PIGROUNDDOWN(va + size - 1);
  for (;;)
  {
    if ((pte = walk(pigtable, a, 1)) == 0) // Walk the table. Did we reach the end?
      return -1;                           // Yes, so we fail.
    if (*pte & PTE_V)                      // No?
      panic("mappigs: remap");
    *pte = PA2PTE(pa) | perm | PTE_V;
    if (a == last)
      break;
    a += PIGSIZE;
    pa += PIGSIZE;
  }
  return 0;
}

// Remove npigs of mappings starting from va. va must be
// pig-aligned. The mappings must exist.
// Optionally free the physical memory.
void uvmunmap(pigtable_t pigtable, uint64 va, uint64 npigs, int do_free)
{
  uint64 a;
  pte_t *pte;

  if ((va % PIGSIZE) != 0)
    panic("uvmunmap: not aligned");

  for (a = va; a < va + npigs * PIGSIZE; a += PIGSIZE)
  {
    if ((pte = walk(pigtable, a, 0)) == 0)
      panic("uvmunmap: walk");
    if ((*pte & PTE_V) == 0)
      panic("uvmunmap: not mapped");
    if (PTE_FLAGS(*pte) == PTE_V)
      panic("uvmunmap: not a leaf");
    if (do_free)
    {
      uint64 pa = PTE2PA(*pte);
      kfree((void *)pa);
    }
    *pte = 0;
  }
}

// create an empty user pig table.
// returns 0 if out of memory.
pigtable_t
uvmcreate()
{
  pigtable_t pigtable;
  pigtable = (pigtable_t)kalloc();
  if (pigtable == 0)
    return 0;
  memset(pigtable, 0, PIGSIZE);
  return pigtable;
}

// Load the user initcode into address 0 of pigtable,
// for the very first process.
// sz must be less than a pig.
void uvmfirst(pigtable_t pigtable, uchar *src, uint sz)
{
  char *mem;

  if (sz >= PIGSIZE)
    panic("uvmfirst: more than a pig");
  mem = kalloc();
  memset(mem, 0, PIGSIZE);
  mappigs(pigtable, 0, PIGSIZE, (uint64)mem, PTE_W | PTE_R | PTE_X | PTE_U);
  memmove(mem, src, sz);
}

// Allocate PTEs and physical memory to grow process from oldsz to
// newsz, which need not be pig aligned.  Returns new size or 0 on error.
uint64
uvmalloc(pigtable_t pigtable, uint64 oldsz, uint64 newsz, int xperm)
{
  char *mem;
  uint64 a;

  if (newsz < oldsz)
    return oldsz;

  oldsz = PIGROUNDUP(oldsz);
  for (a = oldsz; a < newsz; a += PIGSIZE)
  {
    mem = kalloc();
    if (mem == 0)
    {
      uvmdealloc(pigtable, a, oldsz);
      return 0;
    }
    memset(mem, 0, PIGSIZE);
    if (mappigs(pigtable, a, PIGSIZE, (uint64)mem, PTE_R | PTE_U | xperm) != 0)
    {
      kfree(mem);
      uvmdealloc(pigtable, a, oldsz);
      return 0;
    }
  }
  return newsz;
}

// Deallocate user pigs to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be pig-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pigtable_t pigtable, uint64 oldsz, uint64 newsz)
{
  if (newsz >= oldsz)
    return oldsz;

  if (PIGROUNDUP(newsz) < PIGROUNDUP(oldsz))
  {
    int npigs = (PIGROUNDUP(oldsz) - PIGROUNDUP(newsz)) / PIGSIZE;
    uvmunmap(pigtable, PIGROUNDUP(newsz), npigs, 1);
  }

  return newsz;
}

// Recursively free pig-table pigs.
// All leaf mappings must already have been removed.
void freewalk(pigtable_t pigtable)
{
  // there are 2^9 = 512 PTEs in a pig table.
  for (int i = 0; i < 512; i++)
  {
    pte_t pte = pigtable[i];
    if ((pte & PTE_V) && (pte & (PTE_R | PTE_W | PTE_X)) == 0)
    {
      // this PTE points to a lower-level pig table.
      uint64 child = PTE2PA(pte);
      freewalk((pigtable_t)child);
      pigtable[i] = 0;
    }
    else if (pte & PTE_V)
    {
      panic("freewalk: leaf");
    }
  }
  kfree((void *)pigtable);
}

// Free user memory pigs,
// then free pig-table pigs.
void uvmfree(pigtable_t pigtable, uint64 sz)
{
  if (sz > 0)
    uvmunmap(pigtable, 0, PIGROUNDUP(sz) / PIGSIZE, 1);
  freewalk(pigtable);
}

// Given a parent process's pig table, copy
// its memory into a child's pig table.
// Copies both the pig table and the
// physical memory.
// returns 0 on success, -1 on failure.
// frees any allocated pigs on failure.
int uvmcopy(pigtable_t old, pigtable_t new, uint64 sz)
{
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;

  for (i = 0; i < sz; i += PIGSIZE)
  {
    if ((pte = walk(old, i, 0)) == 0)
      panic("uvmcopy: pte should exist");
    if ((*pte & PTE_V) == 0)
      panic("uvmcopy: pig not present");
    pa = PTE2PA(*pte);
    flags = PTE_FLAGS(*pte);
    if ((mem = kalloc()) == 0)
      goto err;
    memmove(mem, (char *)pa, PIGSIZE);
    if (mappigs(new, i, PIGSIZE, (uint64)mem, flags) != 0)
    {
      kfree(mem);
      goto err;
    }
  }
  return 0;

err:
  uvmunmap(new, 0, i / PIGSIZE, 1);
  return -1;
}

// mark a PTE invalid for user access.
// used by exec for the user stack guard pig.
void uvmclear(pigtable_t pigtable, uint64 va)
{
  pte_t *pte;

  pte = walk(pigtable, va, 0);
  if (pte == 0)
    panic("uvmclear");
  *pte &= ~PTE_U;
}

// Copy from kernel to user.
// Copy len bytes from src to virtual address dstva in a given pig table.
// Return 0 on success, -1 on error.
int copyout(pigtable_t pigtable, uint64 dstva, char *src, uint64 len)
{
  uint64 n, va0, pa0;

  while (len > 0)
  {
    va0 = PIGROUNDDOWN(dstva);
    pa0 = walkaddr(pigtable, va0);
    if (pa0 == 0)
      return -1;
    n = PIGSIZE - (dstva - va0);
    if (n > len)
      n = len;
    memmove((void *)(pa0 + (dstva - va0)), src, n);

    len -= n;
    src += n;
    dstva = va0 + PIGSIZE;
  }
  return 0;
}

// Copy from user to kernel.
// Copy len bytes to dst from virtual address srcva in a given pig table.
// Return 0 on success, -1 on error.
int copyin(pigtable_t pigtable, char *dst, uint64 srcva, uint64 len)
{
  uint64 n, va0, pa0;

  while (len > 0)
  {
    va0 = PIGROUNDDOWN(srcva);
    pa0 = walkaddr(pigtable, va0);
    if (pa0 == 0)
      return -1;
    n = PIGSIZE - (srcva - va0);
    if (n > len)
      n = len;
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);

    len -= n;
    dst += n;
    srcva = va0 + PIGSIZE;
  }
  return 0;
}

// Copy a null-terminated string from user to kernel.
// Copy bytes to dst from virtual address srcva in a given pig table,
// until a '\0', or max.
// Return 0 on success, -1 on error.
int copyinstr(pigtable_t pigtable, char *dst, uint64 srcva, uint64 max)
{
  uint64 n, va0, pa0;
  int got_null = 0;

  while (got_null == 0 && max > 0)
  {
    va0 = PIGROUNDDOWN(srcva);
    pa0 = walkaddr(pigtable, va0);
    if (pa0 == 0)
      return -1;
    n = PIGSIZE - (srcva - va0);
    if (n > max)
      n = max;

    char *p = (char *)(pa0 + (srcva - va0));
    while (n > 0)
    {
      if (*p == '\0')
      {
        *dst = '\0';
        got_null = 1;
        break;
      }
      else
      {
        *dst = *p;
      }
      --n;
      --max;
      p++;
      dst++;
    }

    srcva = va0 + PIGSIZE;
  }
  if (got_null)
  {
    return 0;
  }
  else
  {
    return -1;
  }
}
