#include <stdio.h>

int if_t0(int t0) {
  int t1;
  if (t0 == 0) {
      t1 = 1;
  } else if (t0 < 0) {
      t1 = 2;
  } else if (t0 > 10) {
      t1 = 3;
  } else {
      t1 = 4;
  }
  return t1;
}

int main() {
  printf("0: %d\n", if_t0(0));
  printf("-1: %d\n", if_t0(-1));
  printf("5: %d\n", if_t0(9));
  printf("9: %d\n", if_t0(9));
  printf("10: %d\n", if_t0(10));
  printf("11: %d\n", if_t0(11));
  printf("100: %d\n", if_t0(100));
}
