#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include "factorial.h"

// Структура для передачи данных в поток
typedef struct {
    int n;
    unsigned long long result;
} thread_data_t;

// Функция, которую будет выполнять поток
void* compute_factorial(void* arg) {
    thread_data_t* data = (thread_data_t*)arg;
    data->result = factorial(data->n);
    printf("[Thread] factorial(%d) = %llu\n", data->n, data->result);
    return NULL;
}

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
    
    pthread_t thread;
    thread_data_t data;
    data.n = n;
    data.result = 0;
    
    printf("[Parent] PID=%d: creating thread\n", getpid());
    
    // Создаём поток
    if (pthread_create(&thread, NULL, compute_factorial, &data) != 0) {
        perror("pthread_create");
        return 1;
    }
    
    // Ждём завершения потока
    pthread_join(thread, NULL);
    
    printf("[Parent] Thread finished, result = %llu\n", data.result);
    
    return 0;
}
