#include <stdio.h>
#include <stdlib.h>
#include <windows.h>
#include "c-skeletons-for-SY.c"

/* Function f */
int f(int a) {
    int res = a;
    for (int i = 0; i < 100000000; i++) {
        res *= (-1);
    }
    return res;
}

FILE* file;
Signal** s_in;
Signal** s_1;
Signal** s_2;
Signal** s_3;
Signal** s_out;
HANDLE mutex_s_in;
HANDLE mutex_s_1;
HANDLE mutex_s_2;
HANDLE mutex_s_3;
HANDLE mutex_s_out;

void *loop0(void* arg)
{
    int threadId = *((int *)arg);

	// aquire mutex for both input and output signals
	WaitForSingleObject(mutex_s_in, INFINITE);
	WaitForSingleObject(mutex_s_1, INFINITE);

    printf("Thread %d is running on CPU %d\n", threadId, GetCurrentProcessorNumber());

	/* Vertex p_1 */
	mapSY(f, *s_in, s_1);

	printf("Thread %d is finished\n", threadId);

	// release mutex for both input and output signals
	ReleaseMutex(mutex_s_1);
	ReleaseMutex(mutex_s_in);
}	


void *loop1(void* arg)
{
    int threadId = *((int *)arg);

	// aquire mutex for both input and output signals
	WaitForSingleObject(mutex_s_2, INFINITE);
	WaitForSingleObject(mutex_s_1, INFINITE);

    printf("Thread %d is running on CPU %d\n", threadId, GetCurrentProcessorNumber());
		
    /* Vertex p_2 */
	mapSY(f, *s_1, s_2);

	printf("Thread %d is finished\n", threadId);

	// release mutex for both input and output signals
	ReleaseMutex(mutex_s_1);
	ReleaseMutex(mutex_s_2);
}

void *loop2(void* arg)
{
    int threadId = *((int *)arg);

	// aquire mutex for both input and output signals
	WaitForSingleObject(mutex_s_3, INFINITE);
	WaitForSingleObject(mutex_s_2, INFINITE);

    printf("Thread %d is running on CPU %d\n", threadId, GetCurrentProcessorNumber());
	
	/* Vertex p_3 */
	mapSY(f, *s_2, s_3);

	printf("Thread %d is finished\n", threadId);

	// release mutex for both input and output signals
	ReleaseMutex(mutex_s_2);
	ReleaseMutex(mutex_s_3);
}

void *loop3(void* arg)
{
    int threadId = *((int *)arg);

	// aquire mutex for both input and output signals
	WaitForSingleObject(mutex_s_out, INFINITE);
	WaitForSingleObject(mutex_s_3, INFINITE);

    printf("Thread %d is running on CPU %d\n", threadId, GetCurrentProcessorNumber());
		
	/* Vertex p_4 */
	mapSY(f, *s_3, s_out);

	printf("Thread %d is finished\n", threadId);

	// release mutex for both input and output signals
	ReleaseMutex(mutex_s_3);
	ReleaseMutex(mutex_s_out);
}

int main(int argc, char *argv[]) {
	int input;
	int output;

	// Check if the correct number of command-line arguments is provided
	if (argc != 2) {
		fprintf(stderr, "Usage: %s <filename>\n", argv[0]);
		return 1; // Return an error code
	}
	
	// Open the file for reading
	file = fopen(argv[1], "r");

	// Check if the file opened successfully
	if (file == NULL) {
		fprintf(stderr, "Unable to open the file '%s' for reading.\n", argv[1]);
		return 1; // Return an error code
	}

	// Allocate memory for Signal structures

	s_in = (struct Signal **)malloc(sizeof(struct Signal *));
	*s_in = NULL;

	s_1 = (struct Signal **)malloc(sizeof(struct Signal *));
	*s_1 = NULL;

	s_2 = (struct Signal **)malloc(sizeof(struct Signal *));
	*s_2 = NULL;

	s_3 = (struct Signal **)malloc(sizeof(struct Signal *));
	*s_3 = NULL;

	s_out = (struct Signal **)malloc(sizeof(struct Signal *));
	*s_out = NULL;

	// make mutexes for each signal
	mutex_s_in = CreateMutex(NULL, TRUE, NULL);
	mutex_s_1 = CreateMutex(NULL, TRUE, NULL);
	mutex_s_2 = CreateMutex(NULL, TRUE, NULL);
	mutex_s_3 = CreateMutex(NULL, TRUE, NULL);
	mutex_s_out = CreateMutex(NULL, TRUE, NULL);

	while(1)
	{		
		if(fscanf(file, "%d", &input) == 1) 
		{
			printf("Read 1 input tokens: ");
			printf("%d\n", input);
			
			// Allocate memory for Signal structure
            if(*s_in == NULL)
			{
				*s_in = (struct Signal *)malloc(sizeof(struct Signal));
				(*s_in)->data = input;
				(*s_in)->next = NULL;
			}
			else
			{
				struct Signal *current = *s_in;
				while (current->next != NULL)
				{
					current = current->next;
				}
				current->next = (struct Signal *)malloc(sizeof(struct Signal));
				current->next->data = input;
				current->next->next = NULL;
			}
		}
	else {
			printf("End of file reached.\n");
			fclose(file);
			break;
		}
	}

	int num_threads = 4;
    HANDLE threads[num_threads];
    int threadIds[num_threads];

    // Create and run threads
	threadIds[0] = 0;
	threads[0] = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)loop0, (LPVOID)&threadIds[0], 0, NULL);
	if (threads[0] == NULL) {
		fprintf(stderr, "Error creating thread %d\n", 0);
		exit(EXIT_FAILURE);
	}

	threadIds[1] = 1;
	threads[1] = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)loop1, (LPVOID)&threadIds[1], 0, NULL);
	if (threads[1] == NULL) {
		fprintf(stderr, "Error creating thread %d\n", 1);
		exit(EXIT_FAILURE);
	}

	threadIds[2] = 2;
	threads[2] = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)loop2, (LPVOID)&threadIds[2], 0, NULL);
	if (threads[2] == NULL) {
		fprintf(stderr, "Error creating thread %d\n", 2);
		exit(EXIT_FAILURE);
	}

	threadIds[3] = 3;
	threads[3] = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)loop3, (LPVOID)&threadIds[3], 0, NULL);
	if (threads[3] == NULL) {
		fprintf(stderr, "Error creating thread %d\n", 3);
		exit(EXIT_FAILURE);
	}

	// Set affinity for each thread using SetThreadAffinityMask
	for (int i = 0; i < num_threads; ++i) {
		DWORD_PTR affinityMask = 1ULL << 0; // Set affinity always to CPU0
		if (SetThreadAffinityMask(threads[i], affinityMask) == 0) {
			fprintf(stderr, "Error setting affinity for thread %d\n", i);
			exit(EXIT_FAILURE);
		}
	}

	// release mutexes
	ReleaseMutex(mutex_s_in);
	ReleaseMutex(mutex_s_1);
	Sleep(1000);
	ReleaseMutex(mutex_s_2);
	ReleaseMutex(mutex_s_3);
	ReleaseMutex(mutex_s_out);

	// Wait for threads to finish
	WaitForMultipleObjects(num_threads, threads, TRUE, INFINITE);

	// Close thread handles
	for (int i = 0; i < num_threads; ++i) {
		CloseHandle(threads[i]);
	}

	printf("Output:");
	struct Signal *current = *s_out;
	while (current != NULL)
	{
		printf("%d\n", current->data);
		current = current->next;
	}

	return 0;
}
