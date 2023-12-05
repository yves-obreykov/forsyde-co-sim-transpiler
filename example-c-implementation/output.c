/* Code generated by the ForSyDe compiler */
#include <pthread.h>
#include "c-skeletons-for-SDF.c"


/* Function p1 */
void f_p1(token* in1, token* out1){
	int temp = in1[0]; for (int i = 0; i < 100000000; i++) { temp *= (-1); } out1[0] = temp;
}

/* Function p2 */
void f_p2(token* in1, token* out1){
	int temp = in1[0]; for (int i = 0; i < 100000000; i++) { temp *= (-1); } out1[0] = temp;
}

/* Function p3 */
void f_p3(token* in1, token* out1){
	int temp = in1[0]; for (int i = 0; i < 100000000; i++) { temp *= (-1); } out1[0] = temp;
}

/* Function p4 */
void f_p4(token* in1, token* out1){
	int temp = in1[0]; for (int i = 0; i < 100000000; i++) { temp *= (-1); } out1[0] = temp;
}

FILE *file;

token* buffer_sip;
channel sip;

token* buffer_s1;
channel s1;

token* buffer_s2;
channel s2;

token* buffer_s3;
channel s3;

token* buffer_sout;
channel sout;

void *loop0(void* arg)
{
	token input;
	token output;

	while(1){
		
	for(int j = 0; j <1; j++) {
		if(fscanf(file, "%d", &input) == 1) {
			printf("Read 1 input tokens: ");
			printf("%d\n", input);
			writeToken(sip, input);
		}
	else {
			printf("End of file reached.\n");
			fclose(file);
			exit(0);
		}
	}

	/* Actor p1 */
	actor11SDF(1, 1, &sip, &s1, f_p1);

	}
}

void *loop1(void* arg)
{
	token input;
	token output;

	while(1){
		

	/* Actor p2 */
	actor11SDF(1, 1, &s1, &s2, f_p2);

	}
}

void *loop2(void* arg)
{
	token input;
	token output;

	while(1){
		

	/* Actor p3 */
	actor11SDF(1, 1, &s2, &s3, f_p3);

	}
}

void *loop3(void* arg)
{
	token input;
	token output;

	while(1){
		

	/* Actor p4 */
	actor11SDF(1, 1, &s3, &sout, f_p4);

	printf("Output:");
	for(int j = 0; j <1; j++) {
		readToken(sout, &output);
		printf("%d\n", output);
	}
	}
}

int main(int argc, char *argv[]) {
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
	
	
	buffer_sip = malloc(1 * sizeof(token));
	sip = createFIFO(buffer_sip, 1);

	buffer_s1 = malloc(1 * sizeof(token));
	s1 = createFIFO(buffer_s1, 1);

	buffer_s2 = malloc(1 * sizeof(token));
	s2 = createFIFO(buffer_s2, 1);

	buffer_s3 = malloc(1 * sizeof(token));
	s3 = createFIFO(buffer_s3, 1);

	buffer_sout = malloc(1 * sizeof(token));
	sout = createFIFO(buffer_sout, 1);

	pthread_t thread0;
	pthread_create(&thread0, NULL, loop0, NULL);
	
	pthread_t thread1;
	pthread_create(&thread1, NULL, loop1, NULL);
	
	pthread_t thread2;
	pthread_create(&thread2, NULL, loop2, NULL);
	
	pthread_t thread3;
	pthread_create(&thread3, NULL, loop3, NULL);
	
	pthread_join(thread0, NULL);

	
	pthread_join(thread1, NULL);

	
	pthread_join(thread2, NULL);

	
	pthread_join(thread3, NULL);

		return 0;
}