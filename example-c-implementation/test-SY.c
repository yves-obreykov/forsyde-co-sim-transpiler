#include <stdio.h>
#include <stdlib.h>
#include "c-skeletons-for-SY.h"
#include "c-skeletons-for-core-vector.h"

int incr(int y){
    return 1 + y;
}

int dubblera(int x) {
    return x * 2;
}

int mult(int x, int y) {
    return x * y;
}
 
int add(int x, int y){
    return x + y;
}

int add3(int x, int y, int z) {
    return x + y + z;
}

int add4(int x, int y, int z, int w) {
    return x + y + z + w;
}

void append_to_signal(struct Signal * signal, int appendValue){
    // create new node
    struct Signal *new = (struct Signal *)malloc(sizeof(struct Signal));
    new->data = appendValue;
    new->next = NULL;
    // find end of signal
    while (signal->next != NULL)
    {
        signal = signal->next;
    }
    // append new node to end of signal
    signal->next = new;
}

void printSignal(struct Signal *signal)
{
    printf("{");
    while (signal != NULL)
    {
        if (signal->next != NULL)
        {
            printf("%d, ", signal->data);
        } else {
            printf("%d", signal->data);
        }
        signal = signal->next;
    }
    printf("}");
}

void printSignalTuple(struct SignalTuple *signal) 
{
    printf("{");
    while (signal != NULL)
    {
        if (signal->next != NULL)
        {
            printf("(%d,%d), ", signal->data1, signal->data2);
        } else {
            printf("(%d,%d)", signal->data1, signal->data2);
        }
        signal = signal->next;
    }
    printf("}");
}
void freeSignalTuple(struct SignalTuple *signal)
{
    struct SignalTuple * temp = signal;
    while (signal != NULL)
    {
        signal = signal->next;
        free(temp);
        temp = signal;
    }
}

void append_signal_to_vector(struct VectorSignal **vector, struct Signal * signal)
{
    struct VectorSignal *newVectorNode = (struct VectorSignal *)malloc(sizeof(struct VectorSignal));
    newVectorNode->signal = signal;
    newVectorNode->next = NULL;
    if ((*vector) == NULL)
    {
        (*vector)=newVectorNode;
    } else 
    { 
        struct VectorSignal * temp = *vector;
        while (temp->next != NULL)
        {
            temp = temp->next;
        }
        temp->next = newVectorNode;
    }
}

void printVectorSignal(struct VectorSignal * vector) 
{
    printf("<");
    while (vector != NULL)
    {
        printSignal(vector->signal);
        if (vector->next != NULL)
        {
            printf(", ");
        }
        vector = vector->next;
    }
    printf(">");
}

void printVector(struct Vector * vector)
{
    printf("<");
    while (vector != NULL)
    {
        if (vector->next != NULL)
        {
            printf("%d, ", vector->data);
        } else {
            printf("%d", vector->data);
        }
        vector = vector->next;
    }
    printf(">");
}

void printSignalVector(struct SignalVector * signalVector)
{
    printf("{");
    while (signalVector != NULL)
    {
        printVector(signalVector->vector);
        if (signalVector->next != NULL)
        {
            printf(", ");
        }
        signalVector = signalVector->next;
    }
    printf("}");
}


void createVector(int intArray[], int arrayLen, struct Vector **vector){
    struct Vector *prev = NULL;
    for (int i = 0; i < arrayLen; i++)
    {
        struct Vector * temp = (struct Vector *) malloc(sizeof(struct Vector));
        temp->data = intArray[i];
        temp->next = NULL;

        if (*vector == NULL)
        {
            *vector = temp;
            prev = temp;
        } else
        {
            prev->next = temp;
            prev = temp;
        }
    }
}

int main () {
    struct Signal *mySig = (struct Signal *)malloc(sizeof(struct Signal));
    mySig->next = NULL;
    mySig->data = 1;

    struct Signal *mySig2 = (struct Signal *)malloc(sizeof(struct Signal));
    mySig2->next = NULL;
    mySig2->data = -1;
    append_to_signal(mySig2, -2);
    append_to_signal(mySig2, -3);

    struct Signal *mySig3 = (struct Signal *)malloc(sizeof(struct Signal));
    mySig3->next = NULL;
    mySig3->data = 5;

    for (int i = 2; i < 6; i++)
    {
        append_to_signal(mySig, i);
        append_to_signal(mySig2, -(i+2));
        append_to_signal(mySig3, i+4);
    }

    struct VectorSignal *myVec = NULL;
    append_signal_to_vector(&myVec, mySig2);
    append_signal_to_vector(&myVec, mySig);
    append_signal_to_vector(&myVec, mySig3);

    // printVectorSignal(myVec);
    // printf("\n");


    struct SignalVector *vecOut = NULL;
    zipxSY(myVec, &vecOut);

    // printSignalVector(vecOut);
    // // sourceSY(incr, 0, &out1);
    // printf("\n");

    struct VectorSignal *sigvecout = NULL;
    unzipxSY(vecOut, &sigvecout);
    // printVectorSignal(sigvecout);
    freeVectorSignal(sigvecout);
    freeSignalVector(vecOut);
    // printf("\n");

    struct Signal * current = mySig;
    // printSignal(mySig);
    freeSignal(mySig);
    // printf("\n");

    // printSignal(mySig2);
    freeSignal(mySig2);
    // printf("\n");
    
    // printSignal(mySig3);
    freeSignal(mySig3);
    // printf("\n");

    int arr[5] = {0,1,2,3,4};
    int arrayLen = sizeof(arr)/sizeof(arr[0]);
    struct Vector * v = NULL;
    createVector(arr, arrayLen, &v);
    printVector(v);
    int *reduced = NULL;

    reduceV(add, v, &reduced);
    printf("%d", *reduced);

    return 0;
}