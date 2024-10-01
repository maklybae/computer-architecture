#include <stdio.h>

int array[16];
int n;

int main()
{
in:
  printf("n = ? ");
  scanf("%d", &n);
  if(n > 16 || n < 1) {
    printf("n = %d is incorrect!\n", n);
    return 1;
  }
fill:
  for(int i = 0; i < n; ++i) {
    array[i] = i;
  }
  printf("--------\n");
out:
  for(int i = 0; i < n; ++i) {
    printf("%d\n", array[i]);
  }
  return 0;
}
