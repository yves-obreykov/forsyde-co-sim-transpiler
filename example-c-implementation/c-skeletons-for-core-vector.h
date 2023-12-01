#ifndef C_SKELETONS_FOR_CORE_VECTOR_H
#define C_SKELETONS_FOR_CORE_VECTOR_H

#include <stdbool.h>

// Define a vector structure
struct Vector {
    int data;
    struct Vector* next;
};

// Define a vector (signal a) structure
struct VectorSignal {
    struct Signal* signal;
    struct VectorSignal* next;
};

// define a signal (vector a) structure
struct SignalVector {
    struct Vector* vector;
    struct SignalVector* next;
};

bool nullV(struct Vector* vector);
int lengthV(struct Vector* vector);


void mapV(int (*function)(int), struct Vector *vector, struct Vector **result);

void reduceV(int (*function)(int, int), struct Vector * vector, int **result);

#endif  // C_SKELETONS_FOR_CORP_VECTOR_H