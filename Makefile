# Makefile для лабораторной работы (MSYS2 UCRT64)

CC = gcc
CFLAGS = -Wall -Wextra -O2
TARGET_SEQ = factorial
TARGET_PAR = parallel
OBJS_SEQ = main.o factorial.o
OBJS_PAR = parallel.o factorial.o

# Цель по умолчанию: собрать обе программы
all: $(TARGET_SEQ) $(TARGET_PAR)

# Последовательная версия
$(TARGET_SEQ): $(OBJS_SEQ)
	$(CC) $(CFLAGS) -o $@ $^

# Параллельная версия
$(TARGET_PAR): $(OBJS_PAR)
	$(CC) $(CFLAGS) -o $@ $^

# Компиляция объектных файлов
%.o: %.c factorial.h
	$(CC) $(CFLAGS) -c $< -o $@

# Генерация всех ассемблерных листингов
asm: factorial_O0.s factorial_O1.s factorial_O2.s factorial_O3.s factorial_Os.s factorial_g.s factorial_O2_intel.s

factorial_O0.s: factorial.c
	$(CC) -S -O0 -masm=intel factorial.c -o $@

factorial_O1.s: factorial.c
	$(CC) -S -O1 -masm=intel factorial.c -o $@

factorial_O2.s: factorial.c
	$(CC) -S -O2 -masm=intel factorial.c -o $@

factorial_O3.s: factorial.c
	$(CC) -S -O3 -masm=intel factorial.c -o $@

factorial_Os.s: factorial.c
	$(CC) -S -Os -masm=intel factorial.c -o $@

factorial_g.s: factorial.c
	$(CC) -S -g -masm=intel factorial.c -o $@

factorial_O2_intel.s: factorial.c
	$(CC) -S -O2 -masm=intel factorial.c -o $@

# Очистка
clean:
	rm -f $(OBJS_SEQ) $(OBJS_PAR) $(TARGET_SEQ).exe $(TARGET_PAR).exe *.s

.PHONY: all clean asm
