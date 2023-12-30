/* Code generated by the ForSyDe compiler */
#include "c-skeletons-for-SY.c"

/* Function f */
int f(int a){
	int res;
	res = a;
	for (int i = 0; i < 100000000; i++) {
		res *= (-1);
	}
	return res;
}

FILE *file;
Signal **s_in;
Signal **s_out1;
Signal **s_out2;
Signal **s_out3;
Signal **s_out4;

void *loop0(void* arg)
{
	int input;
	int output;

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

	/* Vertex p_1 */
	mapSY(f, *s_in, s_out1);

	/* Vertex p_2 */
	mapSY(f, *s_in, s_out2);

	/* Vertex p_3 */
	mapSY(f, *s_in, s_out3);

	/* Vertex p_4 */
	mapSY(f, *s_in, s_out4);

struct Signal* current = NULL;
	printf("Output s_out1:");
	current = *s_out1;
	while (current != NULL)
	{
		printf("%d\n", current->data);
		current = current->next;
	}

	printf("Output s_out2:");
	current = *s_out2;
	while (current != NULL)
	{
		printf("%d\n", current->data);
		current = current->next;
	}

	printf("Output s_out3:");
	current = *s_out3;
	while (current != NULL)
	{
		printf("%d\n", current->data);
		current = current->next;
	}

	printf("Output s_out4:");
	current = *s_out4;
	while (current != NULL)
	{
		printf("%d\n", current->data);
		current = current->next;
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
	
	// Allocate memory for Signal structures

	s_in = (struct Signal **)malloc(sizeof(struct Signal *));
	*s_in = NULL;
	
	s_out1 = (struct Signal **)malloc(sizeof(struct Signal *));
	*s_out1 = NULL;
	
	s_out2 = (struct Signal **)malloc(sizeof(struct Signal *));
	*s_out2 = NULL;
	
	s_out3 = (struct Signal **)malloc(sizeof(struct Signal *));
	*s_out3 = NULL;
	
	s_out4 = (struct Signal **)malloc(sizeof(struct Signal *));
	*s_out4 = NULL;
	
	loop0(NULL);

	return 0;
}