#include <pthread.h>
#include <stdio.h>

void *computation(void *add)
{
    long sum = 0;
    long *add_num = (long *)add;

    for (int i = 0; i < 1000000000; i++)
    {
        sum += *add_num;
    }

    return NULL;
}

int main()
{
    pthread_t thread1, thread2;
    long a = 1, b = 2;

    pthread_create(&thread1, NULL, computation, (void *)&a);

    pthread_create(&thread2, NULL, computation, (void *)&b);
    pthread_join(thread1, NULL);
    pthread_join(thread2, NULL);

    return 0;
}