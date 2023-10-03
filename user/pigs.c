#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main(int argc, char **argv)
{
  int i;

  if (argc < 2)
  {
    fprintf(2, "usage: pigs pid...\n");
    exit(1);
  }
  for (i = 1; i < argc; i++)
    pigs(atoi(argv[i]));
  exit(0);
}
