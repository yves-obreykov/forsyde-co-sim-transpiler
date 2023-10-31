#include <stdio.h>

// Define a Signal structure
struct Signal {
    int data;
    struct Signal* next;
};


// Source Code:
// mapSY :: (a -> b) -> Signal a -> Signal b
// mapSY _ NullS   = NullS
// mapSY f (x:-xs) = f x :- (mapSY f xs)

// Function to map a void function over a Signal, modifying the values in place
void mapSY(void (*function)(int*), struct Signal* signal) {
    while (signal != NULL) {
        function(&(signal->data));
        signal = signal->next;
    }
}


// Source Code:
// zipWithSY :: (a -> b -> c) -> Signal a -> Signal b -> Signal c
// zipWithSY _ NullS   _   = NullS
// zipWithSY _ _   NullS   = NullS
// zipWithSY f (x:-xs) (y:-ys) = f x y :- (zipWithSY f xs ys)

// Function to apply a binary function to two Signals and update the result Signal
void zipWithSY(int (*function)(int, int), struct Signal* signal1, struct Signal* signal2, struct Signal** result) {
    struct Signal* currentResult = NULL;

    while (signal1 != NULL && signal2 != NULL) {
        int data1 = signal1->data;
        int data2 = signal2->data;
        int resultData = function(data1, data2);

        if (*result == NULL) {
            *result = (struct Signal*)malloc(sizeof(struct Signal));
            (*result)->data = resultData;
            (*result)->next = NULL;
            currentResult = *result;
        } else {
            currentResult->next = (struct Signal*)malloc(sizeof(struct Signal));
            currentResult = currentResult->next;
            currentResult->data = resultData;
            currentResult->next = NULL;
        }

        signal1 = signal1->next;
        signal2 = signal2->next;
    }
}


// Source code:
// zipWith3SY :: (a -> b -> c -> d) -> Signal a -> Signal b -> Signal c -> Signal d
// zipWith3SY _ NullS   _   _   = NullS
// zipWith3SY _ _   NullS   _   = NullS
// zipWith3SY _ _   _   NullS   = NullS
// zipWith3SY f (x:-xs) (y:-ys) (z:-zs)
//   = f x y z :- (zipWith3SY f xs ys zs)

// The process constructor zipWith3SY takes a combinational function as argument and returns a process with three input signals and one output signal.
void zipWith3SY(int (*function)(int, int, int), struct Signal* signal1, struct Signal* signal2, struct Signal* signal3, struct Signal** result) {
    struct Signal* currentResult = NULL;

    while (signal1 != NULL && signal2 != NULL && signal3 != NULL) {
        int data1 = signal1->data;
        int data2 = signal2->data;
        int data3 = signal3->data;
        int resultData = function(data1, data2, data3);

        if (*result == NULL) {
            *result = (struct Signal*)malloc(sizeof(struct Signal));
            (*result)->data = resultData;
            (*result)->next = NULL;
            currentResult = *result;
        } else {
            currentResult->next = (struct Signal*)malloc(sizeof(struct Signal));
            currentResult = currentResult->next;
            currentResult->data = resultData;
            currentResult->next = NULL;
        }

        signal1 = signal1->next;
        signal2 = signal2->next;
        signal3 = signal3->next;
    }
}


// Source code:
// zipWith4SY :: (a -> b -> c -> d -> e) -> Signal a -> Signal b -> Signal c -> Signal d -> Signal e
// zipWith4SY _ NullS _ _ _ = NullS
// zipWith4SY _ _ NullS _ _ = NullS
// zipWith4SY _ _ _ NullS _ = NullS
// zipWith4SY _ _ _ _ NullS = NullS
// zipWith4SY f (w:-ws) (x:-xs) (y:-ys) (z:-zs) = f w x y z :- (zipWith4SY f ws xs ys zs)

// The process constructor zipWith4SY takes a combinational function as argument and returns a process with four input signals and one output signal.
void zipWith4SY(int (*function)(int, int, int, int), struct Signal* signal1, struct Signal* signal2, struct Signal* signal3, struct Signal* signal4, struct Signal** result) {
    struct Signal* currentResult = NULL;

    while (signal1 != NULL && signal2 != NULL && signal3 != NULL && signal4 != NULL) {
        int data1 = signal1->data;
        int data2 = signal2->data;
        int data3 = signal3->data;
        int data4 = signal4->data;
        int resultData = function(data1, data2, data3, data4);

        if (*result == NULL) {
            *result = (struct Signal*)malloc(sizeof(struct Signal));
            (*result)->data = resultData;
            (*result)->next = NULL;
            currentResult = *result;
        } else {
            currentResult->next = (struct Signal*)malloc(sizeof(struct Signal));
            currentResult = currentResult->next;
            currentResult->data = resultData;
            currentResult->next = NULL;
        }

        signal1 = signal1->next;
        signal2 = signal2->next;
        signal3 = signal3->next;
        signal4 = signal4->next;
    }
}

// TODO: implement mapxSY zipWithxSY 

// The process constructor combSY is an alias to mapSY and behaves exactly in the same way.
void combSY(int (*function)(int), struct Signal* signal) {
    mapSY(function, signal);
}

// The process constructor comb2SY is an alias to zipWithSY and behaves exactly in the same way.
void comb2SY(int (*function)(int, int), struct Signal* signal1, struct Signal* signal2, struct Signal** result) {
    zipWithSY(function, signal1, signal2, result);
}

// The process constructor comb3SY is an alias to zipWith3SY and behaves exactly in the same way.
void comb3SY(int (*function)(int, int, int), struct Signal* signal1, struct Signal* signal2, struct Signal* signal3, struct Signal** result) {
    zipWith3SY(function, signal1, signal2, signal3, result);
}

// The process constructor comb4SY is an alias to zipWith4SY and behaves exactly in the same way.
void comb4SY(int (*function)(int, int, int, int), struct Signal* signal1, struct Signal* signal2, struct Signal* signal3, struct Signal* signal4, struct Signal** result) {
    zipWith4SY(function, signal1, signal2, signal3, signal4, result);
}

