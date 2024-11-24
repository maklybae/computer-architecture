// Моделирование функции strlen(asciiz_string, max_size) на C
#include <stdio.h>

int const BUF_SIZE = 10;

int strn_len(char* asciiz_string, int max_size) {
  int i = 0;
  for(i = 0; asciiz_string[i] != '\0'; ++i) {
    if(i >= max_size) return -1;
  }
  return i;
}

int main()
{
  char buf[BUF_SIZE];
  printf("Input string: ");
  // scanf("%s", buf);
  fgets(buf, BUF_SIZE, stdin);
  printf("String  = %s\n", buf);
  int count = strn_len(buf, BUF_SIZE);
  printf("String length = %d\n", count);
  count = strn_len(buf, -1);
  printf("String length = %d\n", count);
  count = strn_len("Hello", BUF_SIZE);
  printf("String length = %d\n", count);
  count = strn_len("Hello! Ii is so long string", BUF_SIZE);
  printf("String length = %d\n", count);
  return count;
}
