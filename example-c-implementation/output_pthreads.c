#include <pthread.h>
#include "c-skeletons-for-SDF.c"

/* Function p1 */
void f_p1(token* in1, token* in2, token* out1){
	out1[0] = in1[0] + in1[1] + in2[0];
}

/* Function p2 */
void f_p2(token* in1, token* out1, token* out2){
	out1[0] = in1[0]; out2[0] = in1[0] + 1;
}

/* Function p4 */
void f_p4(token* in1, token* out1, token* out2){
	out2[0] = in1[0]; out2[1] = in1[0] + 1; out2[2] = in1[0] + 2; out1[0] = in1[0];
}

/* Function p5 */
void f_p5(token* in1, token* out1){
	out1[0] = in1[0] + 1;
}

/* Function p3 */
void f_p3(token* in1, token* in2, token* out1){
	out1[0] = in1[0] + in1[1]; out1[1] = in2[0] + in2[1];
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

token* buffer_s4;
channel s4;

token* buffer_s5;
channel s5;

token* buffer_s6;
channel s6;

token* buffer_sout;
channel sout;


void *loop0(void* arg)
{
    token input;
    token output;

	while(1){

	printf("Read 2 input tokens: ");
	for(int j = 0; j <2; j++) {
		if(fscanf(file, "%d", &input) == 1) {
			writeToken(sip, input);
		}
	else {
			printf("End of file reached.\n");
			fclose(file);
			return 0;
		}
	}

	/* Actor p1 */
	actor21SDF(2,1, 1, &sip, &s6, &s1, f_p1);

	/* Actor p2 */
	actor12SDF(1, 1,1, &s1, &s2, &s3, f_p2);

	/* Actor p4 */
	actor12SDF(1, 1,3, &s2, &s4, &sout, f_p4);

	printf("Output:");
	for(int j = 0; j <3; j++) {
		readToken(sout, &output);
		printf("%d\n", output);
	}

	/* Actor p5 */
	actor11SDF(1, 1, &s4, &s5, f_p5);

	printf("Read 2 input tokens: ");
	for(int j = 0; j <2; j++) {
		if(fscanf(file, "%d", &input) == 1) {
			writeToken(sip, input);
		}
	else {
			printf("End of file reached.\n");
			fclose(file);
			return 0;
		}
	}

	/* Actor p1 */
	actor21SDF(2,1, 1, &sip, &s6, &s1, f_p1);

	/* Actor p2 */
	actor12SDF(1, 1,1, &s1, &s2, &s3, f_p2);

	/* Actor p4 */
	actor12SDF(1, 1,3, &s2, &s4, &sout, f_p4);

	printf("Output:");
	for(int j = 0; j <3; j++) {
		readToken(sout, &output);
		printf("%d\n", output);
	}

	/* Actor p5 */
	actor11SDF(1, 1, &s4, &s5, f_p5);

	/* Actor p3 */
	actor21SDF(2,2, 2, &s3, &s5, &s6, f_p3);
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
	
	buffer_sip = malloc(2 * sizeof(token));
	sip = createFIFO(buffer_sip, 2);

	buffer_s1 = malloc(1 * sizeof(token));
	s1 = createFIFO(buffer_s1, 1);

    buffer_s2 = malloc(1 * sizeof(token));
	s2 = createFIFO(buffer_s2, 1);

	buffer_s3 = malloc(2 * sizeof(token));
	s3 = createFIFO(buffer_s3, 2);

	buffer_s4 = malloc(1 * sizeof(token));
	s4 = createFIFO(buffer_s4, 1);

	buffer_s5 = malloc(2 * sizeof(token));
	s5 = createFIFO(buffer_s5, 2);

	buffer_s6 = malloc(2 * sizeof(token));
	s6 = createFIFO(buffer_s6, 2);
	/*Initial tokens for s6*/
	writeToken(s6, 0);
	writeToken(s6, 0);

	buffer_sout = malloc(3 * sizeof(token));
	sout = createFIFO(buffer_sout, 3);

    pthread_t thread0;
    pthread_create(&thread0, NULL, loop0, NULL);
    pthread_join(thread0, NULL);

	return 0;
}
