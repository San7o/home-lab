#include <unistd.h>
#include <stdio.h>

int main(void)
{
  FILE *f = NULL;

  while(1)
  {
    f = fopen("/var/log/messages", "w");
    sleep(5);
    fclose(f);
  }

  return 0;
}
