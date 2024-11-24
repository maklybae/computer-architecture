// Моделирование функции strlen(asciiz_string) на C
#include <stdio.h>

int const BUF_SIZE = 10;

int str_len(char* asciiz_string) {
  int i = 0;
  for(i = 0; asciiz_string[i] != '\0'; ++i);
  return i;
}

int main() {
  char buf[BUF_SIZE];
  printf("Input string: ");
  // scanf("%s", buf);
  fgets(buf, BUF_SIZE, stdin);
  printf("String  = %s\n", buf);
  int count = str_len(buf);
  printf("String length = %d\n", count);
  count = str_len("Hello");
  printf("String length = %d\n", count);
  count = str_len("Hello! Ii is so long string");
  printf("String length = %d\n", count);
  return count;
}
