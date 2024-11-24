// Моделирование функции strcmp(char* string1, char* string2) на C
#include <stdio.h>

int const BUF_SIZE = 10;

int str_cmp(char* string1, char* string2) {
  int i = 0;
  for(i = 0; (string1[i] != '\0')||(string1[i] != '\0'); ++i) {
    if(string1[i] != string2[i]) break;
  }
  return string1[i]-string2[i];
}

int main()
{
  char buf1[BUF_SIZE];
  char buf2[BUF_SIZE];
  printf("Input string 1: ");
  // scanf("%s", buf1);
  fgets(buf1, BUF_SIZE, stdin);
  printf("buf1 = %s\n", buf1);
  printf("Input string 2: ");
  // scanf("%s", buf2);
  fgets(buf2, BUF_SIZE, stdin);
  printf("buf2 = %s\n", buf2);
  int result = str_cmp(buf1, buf2);
  printf("Result buf1, buf2 = %d\n", result);
  result = str_cmp("Hello", "Hi");
  printf("Result = %d\n", result);
  result = str_cmp("Hello! Ii is so long string", "Hello");
  printf("Result = %d\n", result);
  return result;
}
