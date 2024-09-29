# Отчет по ДЗ #2

## Программа вычисления частного и остатка от деления

Было принято решение для каждой комбинации знаков числителя и знаменателя сделать отдельный случай (`label`) и отдельный цикл. Отдельно написаны подпрограммы вывода ошибки, результата и завершения работы программы.

main и вывод ошибки:

![main and error](static/image.png)

Обработка положительного числителя:

![pos_num](static/image1.png)

Обработка отрицательного числителя:

![neg_num](static/image2.png)

Вывод результата и останов:

![finish](static/image3.png)

[Здесь расположен полный код программы](div.asm)

## Тестирование программы вручную

![error](static/image12.png)

![zero numerator](static/image13.png)

| b\a | 8                          | -8                          |
| --- | -------------------------- | --------------------------- |
| 3   | ![8 3](static/image4.png)  | ![-8 3](static/image6.png)  |
| -3  | ![8 -3](static/image5.png) | ![-8 -3](static/image7.png) |


| b\a | 3                          | -3                           |
| --- | -------------------------- | ---------------------------- |
| 8   | ![3 8](static/image8.png)  | ![-3 8](static/image10.png)  |
| -8  | ![3 -8](static/image9.png) | ![-3 -8](static/image11.png) |

## Программа для автоматического тестирования

Подпрограмма выводящая исходные данные:

![show input](static/image14.png)

Подпрограмма, запускающая тест:

![run test](static/image15.png)

Сами тесты в main:

![tests](static/image16.png)

[Здесь расположен полный код тестирующей программы](div_test.asm)

Также прикладываю вывод тестирующей программы:

```console
Input 1st number: 12
Input 2nd number: 0
Error: Division by zero

Input 1st number: 0
Input 2nd number: 12
a / b = 0 excpected 0
a % b = 0 excpected 0

Input 1st number: 8
Input 2nd number: 3
a / b = 2 excpected 2
a % b = 2 excpected 2

Input 1st number: 8
Input 2nd number: -3
a / b = -2 excpected -2
a % b = 2 excpected 2

Input 1st number: -8
Input 2nd number: 3
a / b = -2 excpected -2
a % b = -2 excpected -2

Input 1st number: -8
Input 2nd number: -3
a / b = 2 excpected 2
a % b = -2 excpected -2

Input 1st number: 3
Input 2nd number: 8
a / b = 0 excpected 0
a % b = 3 excpected 3

Input 1st number: 3
Input 2nd number: -8
a / b = 0 excpected 0
a % b = 3 excpected 3

Input 1st number: -3
Input 2nd number: 8
a / b = 0 excpected 0
a % b = -3 excpected -3

Input 1st number: -3
Input 2nd number: -8
a / b = 0 excpected 0
a % b = -3 excpected -3
```
