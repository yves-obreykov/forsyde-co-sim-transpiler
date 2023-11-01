#include <stdio.h>

// Define a Signal structure
struct Signal {
    int data;
    struct Signal* next;
};

/* Combinational process constructors */

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


///////////////////////////
/* Synchronous Processes */
///////////////////////////

struct SignalTuple {
    int data1; int data2;
    struct SignalTuple* next;
};

struct SignalTuple3 {
    int data1; int data2; int data3;
    struct SignalTuple3* next;
};

struct SignalTuple4 {
    int data1; int data2; int data3; int data4;
    struct SignalTuple4* next;
};

struct SignalTuple5 {
    int data1; int data2; int data3; int data4; int data5; 
    struct SignalTuple5* next;
};

struct SignalTuple6 {
    int data1; int data2; int data3; int data4; int data5; int data6;
    struct SignalTuple6* next;
};


// TODO: whenSY

// Source code:
// zipSY :: Signal a -> Signal b -> Signal (a,b)
// zipSY (x:-xs) (y:-ys) = (x, y) :- zipSY xs ys
// zipSY _       _       = NullS

void zipSY(struct Signal* signal1, struct Signal* signal2, struct SignalTuple** result) {
    struct SignalTuple* currentResult = NULL;

    while (signal1 != NULL && signal2 != NULL) {
        int data1 = signal1->data;
        int data2 = signal2->data;

        if (*result == NULL) {
            *result = (struct SignalTuple*)malloc(sizeof(struct SignalTuple));
            (*result)->data1 = data1;
            (*result)->data2 = data2;
            (*result)->next = NULL;
            currentResult = *result;
        } else {
            currentResult->next = (struct SignalTuple*)malloc(sizeof(struct SignalTuple));
            currentResult = currentResult->next;
            currentResult->data1 = data1;
            currentResult->data2 = data2;
            currentResult->next = NULL;
        }

        signal1 = signal1->next;
        signal2 = signal2->next;
    }
}

// -- | The process 'zip3SY' works as 'zipSY', but takes three input
// -- signals.
// Source Code:
// zip3SY :: Signal a -> Signal b -> Signal c -> Signal (a,b,c)
// zip3SY (x:-xs) (y:-ys) (z:-zs) = (x, y, z) :- zip3SY xs ys zs
// zip3SY _       _       _       = NullS

void zip3SY(struct Signal* signal1, struct Signal* signal2, struct Signal* signal3, struct SignalTuple3** result) {
    struct SignalTuple3* currentResult = NULL;

    while (signal1 != NULL && signal2 != NULL && signal3 != NULL) {
        int data1 = signal1->data;
        int data2 = signal2->data;
        int data3 = signal3->data;

        if (*result == NULL) {
            *result = (struct SignalTuple3*)malloc(sizeof(struct SignalTuple3));
            (*result)->data1 = data1;
            (*result)->data2 = data2;
            (*result)->data3 = data3;
            (*result)->next = NULL;
            currentResult = *result;
        } else {
            currentResult->next = (struct SignalTuple3*)malloc(sizeof(struct SignalTuple3));
            currentResult = currentResult->next;
            currentResult->data1 = data1;
            currentResult->data2 = data2;
            currentResult->data3 = data3;
            currentResult->next = NULL;
        }

        signal1 = signal1->next;
        signal2 = signal2->next;
        signal3 = signal3->next;
    }
}

// -- | The process 'zip4SY' works as 'zipSY', but takes four input
// -- signals.
// Source code:
// zip4SY ::    Signal a -> Signal b -> Signal c -> Signal d 
//       -> Signal (a,b,c,d)
// zip4SY (w:-ws) (x:-xs) (y:-ys) (z:-zs)
//   = (w, x, y, z) :- zip4SY ws xs ys zs
// zip4SY _ _ _ _ = NullS
void zip4SY(struct Signal* signal1, struct Signal* signal2, struct Signal* signal3, struct Signal* signal4, struct SignalTuple4** result) {
    struct SignalTuple4* currentResult = NULL;

    while (signal1 != NULL && signal2 != NULL && signal3 != NULL && signal4 != NULL) {
        int data1 = signal1->data;
        int data2 = signal2->data;
        int data3 = signal3->data;
        int data4 = signal4->data;

        if (*result == NULL) {
            *result = (struct SignalTuple4*)malloc(sizeof(struct SignalTuple4));
            (*result)->data1 = data1;
            (*result)->data2 = data2;
            (*result)->data3 = data3;
            (*result)->data4 = data4;
            (*result)->next = NULL;
            currentResult = *result;
        } else {
            currentResult->next = (struct SignalTuple4*)malloc(sizeof(struct SignalTuple4));
            currentResult = currentResult->next;
            currentResult->data1 = data1;
            currentResult->data2 = data2;
            currentResult->data3 = data3;
            currentResult->data4 = data4;
            currentResult->next = NULL;
        }

        signal1 = signal1->next;
        signal2 = signal2->next;
        signal3 = signal3->next;
        signal4 = signal4->next;
    }
}

// -- | The process 'zip5SY' works as 'zipSY', but takes four input
// -- signals.
// Source code:
// zip5SY :: Signal a -> Signal b -> Signal c -> Signal d -> Signal e
//        -> Signal (a,b,c,d,e)
// zip5SY (x1:-x1s) (x2:-x2s) (x3:-x3s) (x4:-x4s) (x5:-x5s) 
//   = (x1,x2,x3,x4,x5) :- zip5SY x1s x2s x3s x4s x5s
// zip5SY _ _ _ _ _ = NullS
void zip5SY(struct Signal* signal1, struct Signal* signal2, struct Signal* signal3, struct Signal* signal4, struct Signal* signal5, struct SignalTuple5** result) {
    struct SignalTuple5* currentResult = NULL;

    while (signal1 != NULL && signal2 != NULL && signal3 != NULL && signal4 != NULL && signal5 != NULL) {
        int data1 = signal1->data;
        int data2 = signal2->data;
        int data3 = signal3->data;
        int data4 = signal4->data;
        int data5 = signal5->data;

        if (*result == NULL) {
            *result = (struct SignalTuple5*)malloc(sizeof(struct SignalTuple5));
            (*result)->data1 = data1;
            (*result)->data2 = data2;
            (*result)->data3 = data3;
            (*result)->data4 = data4;
            (*result)->data5 = data5;
            (*result)->next = NULL;
            currentResult = *result;
        } else {
            currentResult->next = (struct SignalTuple5*)malloc(sizeof(struct SignalTuple5));
            currentResult = currentResult->next;
            currentResult->data1 = data1;
            currentResult->data2 = data2;
            currentResult->data3 = data3;
            currentResult->data4 = data4;
            currentResult->data5 = data5;
            currentResult->next = NULL;
        }

        signal1 = signal1->next;
        signal2 = signal2->next;
        signal3 = signal3->next;
        signal4 = signal4->next;
        signal5 = signal5->next;
    }
}


// -- | The process 'zip6SY' works as 'zipSY', but takes four input
// -- signals.
// Source code:
// zip6SY :: Signal a -> Signal b -> Signal c -> Signal d -> Signal e
//        -> Signal f -> Signal (a,b,c,d,e,f)
// zip6SY (x1:-x1s) (x2:-x2s) (x3:-x3s) (x4:-x4s) (x5:-x5s)  (x6:-x6s) 
//     = (x1,x2,x3,x4,x5,x6) :- zip6SY x1s x2s x3s x4s x5s x6s
// zip6SY _ _ _ _ _ _ = NullS
void zip6SY(struct Signal* signal1, struct Signal* signal2, struct Signal* signal3, struct Signal* signal4, struct Signal* signal5, struct Signal* signal6, struct SignalTuple6** result) {
    struct SignalTuple6* currentResult = NULL;

    while (signal1 != NULL && signal2 != NULL && signal3 != NULL && signal4 != NULL && signal5 != NULL && signal6 != NULL) {
        int data1 = signal1->data;
        int data2 = signal2->data;
        int data3 = signal3->data;
        int data4 = signal4->data;
        int data5 = signal5->data;
        int data6 = signal6->data;

        if (*result == NULL) {
            *result = (struct SignalTuple6*)malloc(sizeof(struct SignalTuple6));
            (*result)->data1 = data1;
            (*result)->data2 = data2;
            (*result)->data3 = data3;
            (*result)->data4 = data4;
            (*result)->data5 = data5;
            (*result)->data6 = data6;
            (*result)->next = NULL;
            currentResult = *result;
        } else {
            currentResult->next = (struct SignalTuple6*)malloc(sizeof(struct SignalTuple6));
            currentResult = currentResult->next;
            currentResult->data1 = data1;
            currentResult->data2 = data2;
            currentResult->data3 = data3;
            currentResult->data4 = data4;
            currentResult->data5 = data5;
            currentResult->data6 = data6;
            currentResult->next = NULL;
        }

        signal1 = signal1->next;
        signal2 = signal2->next;
        signal3 = signal3->next;
        signal4 = signal4->next;
        signal5 = signal5->next;
        signal6 = signal6->next;
    }
}

// -- | The process 'unzipSY' \"unzips\" a signal of tuples into two
// -- signals.
// Source code:
// unzipSY :: Signal (a,b) -> (Signal a,Signal b)
// unzipSY NullS         = (NullS, NullS)
// unzipSY ((x, y):-xys) = (x:-xs, y:-ys)
//   where (xs, ys) = unzipSY xys
void unzipSY(struct SignalTuple* signal, struct Signal **result1, struct Signal** result2) {
    struct Signal* currentResult1 = NULL;
    struct Signal* currentResult2 = NULL;

    while (signal != NULL) {
        int data1 = signal->data1;
        int data2 = signal->data2;

        if (*result1 == NULL && *result2 == NULL) {
            *result1 = (struct Signal*)malloc(sizeof(struct Signal));
            *result2 = (struct Signal*)malloc(sizeof(struct Signal));
            (*result1)->data = data1;
            (*result2)->data = data2;
            (*result1)->next = NULL;
            (*result2)->next = NULL;
            currentResult1 = *result1;
            currentResult2 = *result2;
        } else {
            currentResult1->next = (struct Signal*)malloc(sizeof(struct Signal));
            currentResult2->next = (struct Signal*)malloc(sizeof(struct Signal));
            currentResult1 = currentResult1->next;
            currentResult2 = currentResult2->next;
            currentResult1->data = data1;
            currentResult2->data = data2;
            currentResult1->next = NULL;
            currentResult2->next = NULL;
        }

        signal = signal->next;
    }
}

// -- | The process 'unzip3SY' works as 'unzipSY', but has three output
// -- signals.
// Source code:
// unzip3SY :: Signal (a, b, c) -> (Signal a, Signal b, Signal c)
// unzip3SY NullS             = (NullS, NullS, NullS)
// unzip3SY ((x, y, z):-xyzs) = (x:-xs, y:-ys, z:-zs)
//   where (xs, ys, zs) = unzip3SY xyzs
void unzip3SY(struct SignalTuple3* signal, struct Signal **result1, struct Signal** result2, struct Signal** result3) {
    struct Signal* currentResult1 = NULL;
    struct Signal* currentResult2 = NULL;
    struct Signal* currentResult3 = NULL;

    while (signal != NULL) {
        int data1 = signal->data1;
        int data2 = signal->data2;
        int data3 = signal->data3;

        if (*result1 == NULL && *result2 == NULL && *result3 == NULL) {
            *result1 = (struct Signal*)malloc(sizeof(struct Signal));
            *result2 = (struct Signal*)malloc(sizeof(struct Signal));
            *result3 = (struct Signal*)malloc(sizeof(struct Signal));
            (*result1)->data = data1;
            (*result2)->data = data2;
            (*result3)->data = data3;
            (*result1)->next = NULL;
            (*result2)->next = NULL;
            (*result3)->next = NULL;
            currentResult1 = *result1;
            currentResult2 = *result2;
            currentResult3 = *result3;
        } else {
            currentResult1->next = (struct Signal*)malloc(sizeof(struct Signal));
            currentResult2->next = (struct Signal*)malloc(sizeof(struct Signal));
            currentResult3->next = (struct Signal*)malloc(sizeof(struct Signal));
            currentResult1 = currentResult1->next;
            currentResult2 = currentResult2->next;
            currentResult3 = currentResult3->next;
            currentResult1->data = data1;
            currentResult2->data = data2;
            currentResult3->data = data3;
            currentResult1->next = NULL;
            currentResult2->next = NULL;
            currentResult3->next = NULL;
        }

        signal = signal->next;
    }
}

// -- | The process 'unzip4SY' works as 'unzipSY', but has four output
// -- signals.
// Source code:
// unzip4SY :: Signal (a,b,c,d) -> (Signal a,Signal b,Signal c,Signal d)
// unzip4SY NullS      = (NullS, NullS, NullS, NullS)
// unzip4SY ((w,x,y,z):-wxyzs) = (w:-ws, x:-xs, y:-ys, z:-zs)
//   where (ws, xs, ys, zs) = unzip4SY wxyzs
void unzip4SY(struct SignalTuple4* signal, struct Signal **result1, struct Signal** result2, struct Signal** result3, struct Signal** result4) {
    struct Signal* currentResult1 = NULL;
    struct Signal* currentResult2 = NULL;
    struct Signal* currentResult3 = NULL;
    struct Signal* currentResult4 = NULL;

    while (signal != NULL) {
        int data1 = signal->data1;
        int data2 = signal->data2;
        int data3 = signal->data3;
        int data4 = signal->data4;

        if (*result1 == NULL && *result2 == NULL && *result3 == NULL && *result4 == NULL) {
            *result1 = (struct Signal*)malloc(sizeof(struct Signal));
            *result2 = (struct Signal*)malloc(sizeof(struct Signal));
            *result3 = (struct Signal*)malloc(sizeof(struct Signal));
            *result4 = (struct Signal*)malloc(sizeof(struct Signal));
            (*result1)->data = data1;
            (*result2)->data = data2;
            (*result3)->data = data3;
            (*result4)->data = data4;
            (*result1)->next = NULL;
            (*result2)->next = NULL;
            (*result3)->next = NULL;
            (*result4)->next = NULL;
            currentResult1 = *result1;
            currentResult2 = *result2;
            currentResult3 = *result3;
            currentResult4 = *result4;
        } else {
            currentResult1->next = (struct Signal*)malloc(sizeof(struct Signal));
            currentResult2->next = (struct Signal*)malloc(sizeof(struct Signal));
            currentResult3->next = (struct Signal*)malloc(sizeof(struct Signal));
            currentResult4->next = (struct Signal*)malloc(sizeof(struct Signal));
            currentResult1 = currentResult1->next;
            currentResult2 = currentResult2->next;
            currentResult3 = currentResult3->next;
            currentResult4 = currentResult4->next;
            currentResult1->data = data1;
            currentResult2->data = data2;
            currentResult3->data = data3;
            currentResult4->data = data4;
            currentResult1->next = NULL;
            currentResult2->next = NULL;
            currentResult3->next = NULL;
            currentResult4->next = NULL;
        }

        signal = signal->next;
    }
}

// -- | The process 'unzip5SY' works as 'unzipSY', but has five output
// -- signals.
// Source code:
// unzip5SY :: Signal (a,b,c,d,e) -> (Signal a,Signal b,Signal c,Signal d,Signal e)
// unzip5SY NullS                  = (NullS, NullS, NullS, NullS, NullS)
// unzip5SY ((x1,x2,x3,x4,x5):-xs) = (x1:-x1s, x2:-x2s, x3:-x3s, x4:-x4s, x5:-x5s)
//   where (x1s, x2s, x3s, x4s, x5s) = unzip5SY xs
void unzip5SY(struct SignalTuple5* signal, struct Signal **result1, struct Signal **result2, struct Signal **result3, struct Signal **result4, struct Signal **result5) {
    struct Signal* currentResult1 = NULL;
    struct Signal* currentResult2 = NULL;
    struct Signal* currentResult3 = NULL;
    struct Signal* currentResult4 = NULL;
    struct Signal* currentResult5 = NULL;

    while (signal != NULL) {
        int data1 = signal->data1;
        int data2 = signal->data2;
        int data3 = signal->data3;
        int data4 = signal->data4;
        int data5 = signal->data5;

        if (*result1 == NULL && *result2 == NULL && *result3 == NULL && *result4 == NULL && *result5 == NULL) {
            *result1 = (struct Signal*)malloc(sizeof(struct Signal));
            *result2 = (struct Signal*)malloc(sizeof(struct Signal));
            *result3 = (struct Signal*)malloc(sizeof(struct Signal));
            *result4 = (struct Signal*)malloc(sizeof(struct Signal));
            *result5 = (struct Signal*)malloc(sizeof(struct Signal));

            (*result1)->data = data1;
            (*result2)->data = data2;
            (*result3)->data = data3;
            (*result4)->data = data4;
            (*result5)->data = data5;

            (*result1)->next = NULL;
            (*result2)->next = NULL;
            (*result3)->next = NULL;
            (*result4)->next = NULL;
            (*result5)->next = NULL;

            currentResult1 = *result1;
            currentResult2 = *result2;
            currentResult3 = *result3;
            currentResult4 = *result4;
            currentResult5 = *result5;
        } else {
            currentResult1->next = (struct Signal*)malloc(sizeof(struct Signal));
            currentResult2->next = (struct Signal*)malloc(sizeof(struct Signal));
            currentResult3->next = (struct Signal*)malloc(sizeof(struct Signal));
            currentResult4->next = (struct Signal*)malloc(sizeof(struct Signal));
            currentResult5->next = (struct Signal*)malloc(sizeof(struct Signal));

            currentResult1 = currentResult1->next;
            currentResult2 = currentResult2->next;
            currentResult3 = currentResult3->next;
            currentResult4 = currentResult4->next;
            currentResult5 = currentResult5->next;

            currentResult1->data = data1;
            currentResult2->data = data2;
            currentResult3->data = data3;
            currentResult4->data = data4;
            currentResult5->data = data5;

            currentResult1->next = NULL;
            currentResult2->next = NULL;
            currentResult3->next = NULL;
            currentResult4->next = NULL;
            currentResult5->next = NULL;
        }

        signal = signal->next;
    }
}

// -- | The process 'unzip6SY' works as 'unzipSY', but has six output
// -- signals.
// Source code:
// unzip6SY :: Signal (a,b,c,d,e,f) -> (Signal a,Signal b,Signal c,Signal d,Signal e,Signal f)
// unzip6SY NullS = (NullS, NullS, NullS, NullS, NullS, NullS)
// unzip6SY ((x1,x2,x3,x4,x5,x6):-xs) 
//   = (x1:-x1s, x2:-x2s, x3:-x3s, x4:-x4s, x5:-x5s, x6:-x6s)
//   where (x1s, x2s, x3s, x4s, x5s, x6s) = unzip6SY xs
void unzip6SY(struct SignalTuple6* signal, struct Signal **result1, struct Signal **result2, struct Signal **result3, struct Signal **result4, struct Signal **result5, struct Signal **result6) {
    struct Signal* currentResult1 = NULL;
    struct Signal* currentResult2 = NULL;
    struct Signal* currentResult3 = NULL;
    struct Signal* currentResult4 = NULL;
    struct Signal* currentResult5 = NULL;
    struct Signal* currentResult6 = NULL;

    while (signal != NULL) {
        int data1 = signal->data1;
        int data2 = signal->data2;
        int data3 = signal->data3;
        int data4 = signal->data4;
        int data5 = signal->data5;
        int data6 = signal->data6;

        if (*result1 == NULL && *result2 == NULL && *result3 == NULL && *result4 == NULL && *result5 == NULL && *result6 == NULL) {
            *result1 = (struct Signal*)malloc(sizeof(struct Signal));
            *result2 = (struct Signal*)malloc(sizeof(struct Signal));
            *result3 = (struct Signal*)malloc(sizeof(struct Signal));
            *result4 = (struct Signal*)malloc(sizeof(struct Signal));
            *result5 = (struct Signal*)malloc(sizeof(struct Signal));
            *result6 = (struct Signal*)malloc(sizeof(struct Signal));

            (*result1)->data = data1;
            (*result2)->data = data2;
            (*result3)->data = data3;
            (*result4)->data = data4;
            (*result5)->data = data5;
            (*result6)->data = data6;

            (*result1)->next = NULL;
            (*result2)->next = NULL;
            (*result3)->next = NULL;
            (*result4)->next = NULL;
            (*result5)->next = NULL;
            (*result6)->next = NULL;

            currentResult1 = *result1;
            currentResult2 = *result2;
            currentResult3 = *result3;
            currentResult4 = *result4;
            currentResult5 = *result5;
            currentResult6 = *result6;
        } else {
            currentResult1->next = (struct Signal*)malloc(sizeof(struct Signal));
            currentResult2->next = (struct Signal*)malloc(sizeof(struct Signal));
            currentResult3->next = (struct Signal*)malloc(sizeof(struct Signal));
            currentResult4->next = (struct Signal*)malloc(sizeof(struct Signal));
            currentResult5->next = (struct Signal*)malloc(sizeof(struct Signal));
            currentResult6->next = (struct Signal*)malloc(sizeof(struct Signal));

            currentResult1 = currentResult1->next;
            currentResult2 = currentResult2->next;
            currentResult3 = currentResult3->next;
            currentResult4 = currentResult4->next;
            currentResult5 = currentResult5->next;
            currentResult6 = currentResult6->next;

            currentResult1->data = data1;
            currentResult2->data = data2;
            currentResult3->data = data3;
            currentResult4->data = data4;
            currentResult5->data = data5;
            currentResult6->data = data6;

            currentResult1->next = NULL;
            currentResult2->next = NULL;
            currentResult3->next = NULL;
            currentResult4->next = NULL;
            currentResult5->next = NULL;
            currentResult6->next = NULL;
        }

        signal = signal->next;
    }
}


// TODO zipxSY
// TODO unzipxSY

// -- | The process 'fstSY' selects always the first value from a signal
// -- of pairs.
// Source code:
// fstSY :: Signal (a,b) -> Signal a
// fstSY = mapSY fst 
void fstSY(struct SignalTuple* signal, struct Signal** result) {
    struct Signal* currentResult = NULL;

    while (signal != NULL) {
        int data1 = signal->data1;
        if (*result == NULL) {
            *result = (struct Signal*)malloc(sizeof(struct Signal));
            (*result)->data = data1;
            (*result)->next = NULL;
            currentResult = *result;
        } else {
            currentResult->next = (struct Signal*)malloc(sizeof(struct Signal));
            currentResult = currentResult->next;
            currentResult->data = data1;
            currentResult->next = NULL;
        }

        signal = signal->next;
    }
}

// -- | The process 'sndSY' selects always the second value from a signal
// -- of pairs.
// Source code:
// sndSY :: Signal (a,b) -> Signal b
// sndSY = mapSY snd
void sndSY(struct SignalTuple* signal, struct Signal** result) {
    struct Signal* currentResult = NULL;

    while (signal != NULL) {
        int data2 = signal->data2;
        if (*result == NULL) {
            *result = (struct Signal*)malloc(sizeof(struct Signal));
            (*result)->data = data2;
            (*result)->next = NULL;
            currentResult = *result;
        } else {
            currentResult->next = (struct Signal*)malloc(sizeof(struct Signal));
            currentResult = currentResult->next;
            currentResult->data = data2;
            currentResult->next = NULL;
        }

        signal = signal->next;
    }
}
