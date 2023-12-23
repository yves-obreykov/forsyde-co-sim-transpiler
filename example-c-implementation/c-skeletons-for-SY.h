#ifndef C_SKELETONS_FOR_SY_H
#define C_SKELETONS_FOR_SY_H

#include "c-skeletons-for-core-vector.h"

// Define a Signal structure
typedef struct Signal
{
    int data;
    struct Signal *next;
} Signal;

// Function prototypes for combinational process constructors
void mapSY(int (*function)(int), struct Signal *signal, struct Signal **result);
void zipWithSY(int (*function)(int, int), struct Signal *signal1, struct Signal *signal2, struct Signal **result);
void zipWith3SY(int (*function)(int, int, int), struct Signal *signal1, struct Signal *signal2, struct Signal *signal3, struct Signal **result);
void zipWith4SY(int (*function)(int, int, int, int), struct Signal *signal1, struct Signal *signal2, struct Signal *signal3, struct Signal *signal4, struct Signal **result);
void mapxSY(int (*function)(int), struct VectorSignal *vector, struct VectorSignal **vectorOut);
void combSY(int (*function)(int), struct Signal *signal, struct Signal **result);
void comb2SY(int (*function)(int, int), struct Signal *signal1, struct Signal *signal2, struct Signal **result);
void comb3SY(int (*function)(int, int, int), struct Signal *signal1, struct Signal *signal2, struct Signal *signal3, struct Signal **result);
void comb4SY(int (*function)(int, int, int, int), struct Signal *signal1, struct Signal *signal2, struct Signal *signal3, struct Signal *signal4, struct Signal **result);

// Function prototypes for sequential process constructors
void delaySY(int initial, struct Signal **signal);
void delaynSY(int initial, int delayCycles, struct Signal **signal);
void scanlSY(int (*function)(int, int), int initial, struct Signal *inputSignal, struct Signal **outputSignal);
void scanl2SY(int (*function)(int, int, int), int initial, struct Signal *inputSignal1, struct Signal *inputSignal2, struct Signal **outputSignal);
void scanl3SY(int (*function)(int, int, int, int), int initial, struct Signal *inputSignal1, struct Signal *inputSignal2, struct Signal *inputSignal3, struct Signal **outputSignal);
void scanldSY(int (*function)(int, int), int initial, struct Signal *inputSignal, struct Signal **outputSignal);
void scanld2SY(int (*function)(int, int, int), int initial, struct Signal *inputSignal1, struct Signal *inputSignal2, struct Signal **outputSignal);
void scanld3SY(int (*function)(int, int, int, int), int initial, struct Signal *inputSignal1, struct Signal *inputSignal2, struct Signal *inputSignal3, struct Signal **outputSignal);

// Function prototypes for Moore and Mealy state machine functions
void mooreSY(int (*nextState)(int, int), int (*output)(int), int initial, struct Signal *inputSignal, struct Signal **outputSignal);
void moore2SY(int (*nextState)(int, int, int), int (*output)(int), int initial, struct Signal *inputSignal1, struct Signal *inputSignal2, struct Signal **outputSignal);
void moore3SY(int (*nextState)(int, int, int, int), int (*output)(int), int initial, struct Signal *inputSignal1, struct Signal *inputSignal2, struct Signal *inputSignal3, struct Signal **outputSignal);
void mealySY(int (*nextState)(int, int), int (*output)(int, int), int initial, struct Signal *inputSignal, struct Signal **outputSignal);
void mealy2SY(int (*nextState)(int, int, int), int (*output)(int , int, int), int initial, struct Signal *inputSignal1, struct Signal *inputSignal2, struct Signal **outputSignal);
void mealy3SY(int (*nextState)(int, int, int, int), int (*output)(int, int, int, int), int initial, struct Signal *inputSignal1, struct Signal *inputSignal2, struct Signal *inputSignal3, struct Signal **outputSignal);

// Function prototype for sourceSY
// void sourceSY(int (*function)(int), int initial, struct Signal **outputSignal);

// Define the AbstExt structure
struct AbstExt
{
    int is_present; // Flag to indicate presence (0 for Abst, 1 for Prst)
    int value;      // Value for Prst (ignored for Abst)
};

// Function to filter a Signal by a predicate and create a new Signal with extended values (void version)
void filterSY(int (*predicate)(int), struct Signal *inputSignal, struct Signal **outputSignal);

// Function to fill a Signal with a default value
void fillSY(int defaultValue, struct Signal *inputSignal, struct Signal **outputSignal);


// Function to apply the hold function to a Signal and create a new Signal with extended values (void version)
void holdSY(int defaultValue, struct Signal *inputSignal, struct Signal **outputSignal);


// Define the necessary structures for Signals and Signal Tuples

struct SignalTuple {
    int data1;
    int data2;
    struct SignalTuple* next;
};

struct SignalTuple3 {
    int data1;
    int data2;
    int data3;
    struct SignalTuple3* next;
};

struct SignalTuple4 {
    int data1;
    int data2;
    int data3;
    int data4;
    struct SignalTuple4* next;
};

struct SignalTuple5 {
    int data1;
    int data2;
    int data3;
    int data4;
    int data5;
    struct SignalTuple5* next;
};

struct SignalTuple6 {
    int data1;
    int data2;
    int data3;
    int data4;
    int data5;
    int data6;
    struct SignalTuple6* next;
};

// Function prototypes
void filterSY(int (*predicate)(int), struct Signal *inputSignal, struct Signal **outputSignal);
void fillSY(int defaultValue, struct Signal *inputSignal, struct Signal **outputSignal);
void holdSY(int defaultValue, struct Signal *inputSignal, struct Signal **outputSignal);
void zipSY(struct Signal *signal1, struct Signal *signal2, struct SignalTuple **result);
void zip3SY(struct Signal *signal1, struct Signal *signal2, struct Signal *signal3, struct SignalTuple3 **result);
void zip4SY(struct Signal *signal1, struct Signal *signal2, struct Signal *signal3, struct Signal *signal4, struct SignalTuple4 **result);
void zip5SY(struct Signal *signal1, struct Signal *signal2, struct Signal *signal3, struct Signal *signal4, struct Signal *signal5, struct SignalTuple5 **result);
void zip6SY(struct Signal *signal1, struct Signal *signal2, struct Signal *signal3, struct Signal *signal4, struct Signal *signal5, struct Signal *signal6, struct SignalTuple6 **result);
void unzipSY(struct SignalTuple *signal, struct Signal **result1, struct Signal **result2);
void unzip3SY(struct SignalTuple3 *signal, struct Signal **result1, struct Signal **result2, struct Signal **result3);
void unzip4SY(struct SignalTuple4 *signal, struct Signal **result1, struct Signal **result2, struct Signal **result3, struct Signal **result4);
void unzip5SY(struct SignalTuple5 *signal, struct Signal **result1, struct Signal **result2, struct Signal **result3, struct Signal **result4, struct Signal **result5);
void unzip6SY(struct SignalTuple6 *signal, struct Signal **result1, struct Signal **result2, struct Signal **result3, struct Signal **result4, struct Signal **result5, struct Signal **result6);
void zipxSY(struct VectorSignal *vectorSignal, struct SignalVector **signalVector);
void unzipxSY(struct SignalVector *signalVector, struct VectorSignal **vectorSignal);


void fstSY(struct SignalTuple *signal, struct Signal **result);
void sndSY(struct SignalTuple *signal, struct Signal **result);


// extra helper functions
void freeSignal(struct Signal *signal);
void freeVector(struct Vector *vector);
void freeVectorSignal(struct VectorSignal *vectorSignal); 
void freeSignalVector(struct SignalVector *signalVector); 



#endif  // C_SKELETONS_FOR_SY_H
