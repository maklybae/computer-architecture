#include <stdio.h>

int array[16];

int main()
{
fill:
  for(int i = 0; i < 16; ++i) {
    array[i] = i+1;
  }
  printf("--------\n");
out:
  for(int i = 0; i < 16; ++i) {
    printf("%d\n", array[i]);
  }
  return 0;
}
