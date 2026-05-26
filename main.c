#include <stdio.h>
#include <stdlib.h>
#include "factorial.h"

int main(int argc, char *argv[]) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <number>\n", argv[0]);
        return 1;
    }
    int n = atoi(argv[1]);
    if (n < 0) {
        fprintf(stderr, "Error: negative number\n");
        return 1;
    }
    unsigned long long result = factorial(n);
    printf("Factorial of %d = %llu\n", n, result);
    return 0;
}
