#!/bin/bash

BINARY="./program/a.out"
SOURCE_FILE="program/main.cpp"

INPUT_FILE="samples/c_in.txt"
OUTPUT_FILE="samples/c_out.txt"

if [ ! -f "$BINARY" ]; then
    echo "Бинарник $BINARY не найден. Компиляция исходного кода..."

    if [ ! -f "$SOURCE_FILE" ]; then
        echo "Ошибка: исходный файл $SOURCE_FILE не найден!"
        exit 1
    fi

    g++ "$SOURCE_FILE" -o "$BINARY" -lpthread --std=c++17
    if [ $? -ne 0 ]; then
        echo "Ошибка: компиляция завершилась неудачно!"
        exit 1
    fi

    echo "Компиляция завершена успешно. Бинарник создан: $BINARY"
fi

echo "Запуск программы $BINARY с параметрами..."
"$BINARY" -f "$INPUT_FILE" -o "$OUTPUT_FILE"

if [ $? -eq 0 ]; then
    echo "Программа выполнена успешно!"
else
    echo "Ошибка выполнения программы."
fi
