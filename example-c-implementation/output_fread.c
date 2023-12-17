#include <stdio.h>

int main(int argc, char *argv[]) {
    // Check if the correct number of command-line arguments is provided
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <filename>\n", argv[0]);
        return 1; // Return an error code
    }

    FILE *file;
    int number;

    // Open the file for reading
    file = fopen(argv[1], "r");

    // Check if the file opened successfully
    if (file == NULL) {
        fprintf(stderr, "Unable to open the file '%s' for reading.\n", argv[1]);
        return 1; // Return an error code
    }

    // Read integers from the file until the end is reached
    while (fscanf(file, "%d", &number) == 1) {
        // Process the integer (you can perform any operation here)
        printf("Read integer: %d\n", number);
    }

    // Close the file
    fclose(file);

    return 0;
}
