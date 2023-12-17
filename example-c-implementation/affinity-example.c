#include <stdio.h>
#include <stdlib.h>
#include <windows.h>

#define NUM_THREADS 4

void *threadFunction(void *arg) {
    int threadId = *((int *)arg);
    printf("Thread %d is running on CPU %d\n", threadId, GetCurrentProcessorNumber());

    //sleep for 1 second
    Sleep(1000);

    // Your thread's work here
    while(1) {
        printf("Hello from thread %d\n", threadId);
    }

    return NULL;
}

int main() {
    HANDLE threads[NUM_THREADS];
    int threadIds[NUM_THREADS];

    // Create and run threads
    for (int i = 0; i < NUM_THREADS; ++i) {
        threadIds[i] = i;
        threads[i] = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)threadFunction, (LPVOID)&threadIds[i], 0, NULL);
        if (threads[i] == NULL) {
            fprintf(stderr, "Error creating thread %d\n", i);
            exit(EXIT_FAILURE);
        }
    }

    // Set affinity for each thread using SetThreadAffinityMask
    for (int i = 0; i < NUM_THREADS; ++i) {
        DWORD_PTR affinityMask = 1ULL << i; // Set affinity to a different CPU for each thread
        if (SetThreadAffinityMask(threads[i], affinityMask) == 0) {
            fprintf(stderr, "Error setting affinity for thread %d\n", i);
            exit(EXIT_FAILURE);
        }
    }

    // Wait for threads to finish
    WaitForMultipleObjects(NUM_THREADS, threads, TRUE, INFINITE);

    // Close thread handles
    for (int i = 0; i < NUM_THREADS; ++i) {
        CloseHandle(threads[i]);
    }

    return 0;
}
