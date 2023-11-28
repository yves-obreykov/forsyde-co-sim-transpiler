#include <stdio.h>
#include <stdlib.h>

// Define a Signal structure
struct Signal
{
    int data;
    struct Signal *next;
};

// Defina a Vector of Signal structure
struct Vector 
{
    struct Signal *signal;
    struct Vector *next;
};


////////////////////////////////////////
/* Combinational process constructors */
////////////////////////////////////////

// Source Code:
// mapSY :: (a -> b) -> Signal a -> Signal b
// mapSY _ NullS   = NullS
// mapSY f (x:-xs) = f x :- (mapSY f xs)

// Function to map a void function over a Signal, modifying the values in place
void mapSY(int (*function)(int), struct Signal *signal, struct Signal **result)
{
    struct Signal *currentResult = NULL;

    while (signal != NULL)
    {
        int data = signal->data;
        int resultData = function(data);

        if (*result == NULL)
        {
            *result = (struct Signal *)malloc(sizeof(struct Signal));
            (*result)->data = resultData;
            (*result)->next = NULL;
            currentResult = *result;
        }
        else
        {
            currentResult->next = (struct Signal *)malloc(sizeof(struct Signal));
            currentResult = currentResult->next;
            currentResult->data = resultData;
            currentResult->next = NULL;
        }

        signal = signal->next;
    }
}

// Source Code:
// zipWithSY :: (a -> b -> c) -> Signal a -> Signal b -> Signal c
// zipWithSY _ NullS   _   = NullS
// zipWithSY _ _   NullS   = NullS
// zipWithSY f (x:-xs) (y:-ys) = f x y :- (zipWithSY f xs ys)

// Function to apply a binary function to two Signals and update the result Signal
void zipWithSY(int (*function)(int, int), struct Signal *signal1, struct Signal *signal2, struct Signal **result)
{
    struct Signal *currentResult = NULL;

    while (signal1 != NULL && signal2 != NULL)
    {
        int data1 = signal1->data;
        int data2 = signal2->data;
        int resultData = function(data1, data2);

        if (*result == NULL)
        {
            *result = (struct Signal *)malloc(sizeof(struct Signal));
            (*result)->data = resultData;
            (*result)->next = NULL;
            currentResult = *result;
        }
        else
        {
            currentResult->next = (struct Signal *)malloc(sizeof(struct Signal));
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
void zipWith3SY(int (*function)(int, int, int), struct Signal *signal1, struct Signal *signal2, struct Signal *signal3, struct Signal **result)
{
    struct Signal *currentResult = NULL;

    while (signal1 != NULL && signal2 != NULL && signal3 != NULL)
    {
        int data1 = signal1->data;
        int data2 = signal2->data;
        int data3 = signal3->data;
        int resultData = function(data1, data2, data3);

        if (*result == NULL)
        {
            *result = (struct Signal *)malloc(sizeof(struct Signal));
            (*result)->data = resultData;
            (*result)->next = NULL;
            currentResult = *result;
        }
        else
        {
            currentResult->next = (struct Signal *)malloc(sizeof(struct Signal));
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
void zipWith4SY(int (*function)(int, int, int, int), struct Signal *signal1, struct Signal *signal2, struct Signal *signal3, struct Signal *signal4, struct Signal **result)
{
    struct Signal *currentResult = NULL;

    while (signal1 != NULL && signal2 != NULL && signal3 != NULL && signal4 != NULL)
    {
        int data1 = signal1->data;
        int data2 = signal2->data;
        int data3 = signal3->data;
        int data4 = signal4->data;
        int resultData = function(data1, data2, data3, data4);

        if (*result == NULL)
        {
            *result = (struct Signal *)malloc(sizeof(struct Signal));
            (*result)->data = resultData;
            (*result)->next = NULL;
            currentResult = *result;
        }
        else
        {
            currentResult->next = (struct Signal *)malloc(sizeof(struct Signal));
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
// -- | The process constructor 'mapxSY' creates a process network that
// -- maps a function onto all signals in a vector of signals. See 'mapV'.
// --
// mapxSY :: (a -> b) -> Vector (Signal a) -> Vector (Signal b)
// mapxSY f = mapV (mapSY f)



// The process constructor combSY is an alias to mapSY and behaves exactly in the same way.
void combSY(int (*function)(int), struct Signal *signal, struct Signal **result)
{
    mapSY(function, signal, result);
}

// The process constructor comb2SY is an alias to zipWithSY and behaves exactly in the same way.
void comb2SY(int (*function)(int, int), struct Signal *signal1, struct Signal *signal2, struct Signal **result)
{
    zipWithSY(function, signal1, signal2, result);
}

// The process constructor comb3SY is an alias to zipWith3SY and behaves exactly in the same way.
void comb3SY(int (*function)(int, int, int), struct Signal *signal1, struct Signal *signal2, struct Signal *signal3, struct Signal **result)
{
    zipWith3SY(function, signal1, signal2, signal3, result);
}

// The process constructor comb4SY is an alias to zipWith4SY and behaves exactly in the same way.
void comb4SY(int (*function)(int, int, int, int), struct Signal *signal1, struct Signal *signal2, struct Signal *signal3, struct Signal *signal4, struct Signal **result)
{
    zipWith4SY(function, signal1, signal2, signal3, signal4, result);
}


/////////////////////////////////////
/* Sequential process constructors */
/////////////////////////////////////

// Source code:
// delaySY :: a        -- ^Initial state
//         -> Signal a -- ^Input signal
//         -> Signal a -- ^Output signal
// delaySY e es = e:-es

// Function to prepend a new element to the input signal
void delaySY(int initial, struct Signal **signal)
{
    struct Signal *newNode = (struct Signal *)malloc(sizeof(struct Signal));
    if (*signal == NULL)
    {   // in case signal is empty
        *signal = newNode;
        return;
    }
    
    newNode->data = initial;
    newNode->next = *signal;
    *signal = newNode;
}

// Source code:
// delaynSY :: a        -- ^Initial state
//          -> Int      -- ^ Delay cycles
//          -> Signal a -- ^Input signal
//          -> Signal a -- ^Output signal
// delaynSY e n xs | n <= 0 = xs
//                 | otherwise = e :- delaynSY e (n-1) xs

// Function to delay a Signal by n cycles
void delaynSY(int initial, int delayCycles, struct Signal **signal)
{
    if (delayCycles <= 0)
    {
        return; // if no delay, then unchange signal
    }

    struct Signal *delayedSignal = NULL;

    // Create and initialize the delayed part of the signal
    for (int i = 0; i < delayCycles; i++)
    {
        struct Signal *newNode = (struct Signal *)malloc(sizeof(struct Signal));
        newNode->data = initial;
        newNode->next = delayedSignal;
        delayedSignal = newNode;
    }

    // Append the original signal to the delayed part
    struct Signal *delayTail = delayedSignal;
    while (delayTail->next != NULL) {
        delayTail = delayTail->next;
    }
    delayTail->next = *signal;
    *signal = delayedSignal;
}

// Source code:
// scanlSY :: (a -> b -> a) -- ^Combinational function for next state
//                          -- decoder
//        -> a              -- ^Initial state
//        -> Signal b       -- ^ Input signal
//        -> Signal a       -- ^ Output signal
// scanlSY f mem xs = s'
//   where s' = zipWithSY f (delaySY mem s') xs

// Function to perform scanlSY operation
void scanlSY(int (*function)(int, int), int initial, struct Signal *inputSignal, struct Signal **outputSignal)
{
    // N.B. The implementation is not strictly the same as the Shallow implementation
    struct Signal *accumulator; // Initialize an accumulator

    while (inputSignal != NULL)
    {
        initial = (*function)(initial, inputSignal->data);
        
        if (*outputSignal == NULL)
        {
            *outputSignal = (struct Signal *)malloc(sizeof(struct Signal));
            (*outputSignal)->data = initial;
            (*outputSignal)->next = NULL;
            accumulator = *outputSignal;
        } 
        else 
        {
            accumulator->next = (struct Signal *)malloc(sizeof(struct Signal));
            accumulator = accumulator->next;
            accumulator->data = initial;
            accumulator->next = NULL;
        }
        
        inputSignal = inputSignal->next;
    }
}

// Source code:
//  scanl2SY :: (a -> b -> c -> a) -> a -> Signal b -> Signal c -> Signal a
//  scanl2SY f mem xs ys = s'
//    where s' = zipWith3SY f (delaySY mem s') xs ys

// Function to perform scanl2SY operation
void scanl2SY(int (*function)(int, int, int), int initial, struct Signal *inputSignal1, struct Signal *inputSignal2, struct Signal **outputSignal)
{
    // N.B. The implementation is not strictly the same as the Shallow implementation
    struct Signal *accumulator; // Initialize an accumulator

    while (inputSignal1 != NULL && inputSignal2 != NULL)
    {
        initial = (*function)(initial, inputSignal1->data, inputSignal2->data);
        
        if (*outputSignal == NULL)
        {
            *outputSignal = (struct Signal *)malloc(sizeof(struct Signal));
            (*outputSignal)->data = initial;
            (*outputSignal)->next = NULL;
            accumulator = *outputSignal;
        } 
        else 
        {
            accumulator->next = (struct Signal *)malloc(sizeof(struct Signal));
            accumulator = accumulator->next;
            accumulator->data = initial;
            accumulator->next = NULL;
        }
        
        inputSignal1 = inputSignal1->next;
        inputSignal2 = inputSignal2->next;

    }
}

// Source code:
//  scanl3SY :: (a -> b -> c -> d -> a) -> a -> Signal b
//           -> Signal c -> Signal d -> Signal a
//  scanl3SY f mem xs ys zs = s'
//    where s' = zipWith4SY f (delaySY mem s') xs ys zs

// Function to perform scanl3SY operation
void scanl3SY(int (*function)(int, int, int, int), int initial, struct Signal *inputSignal1, struct Signal *inputSignal2, struct Signal *inputSignal3, struct Signal **outputSignal)
{
    // N.B. The implementation is not strictly the same as the Shallow implementation
    struct Signal *accumulator; // Initialize an accumulator

    while (inputSignal1 != NULL && inputSignal2 != NULL && inputSignal3 != NULL)
    {
        initial = (*function)(initial, inputSignal1->data, inputSignal2->data, inputSignal3->data);
        
        if (*outputSignal == NULL)
        {
            *outputSignal = (struct Signal *)malloc(sizeof(struct Signal));
            (*outputSignal)->data = initial;
            (*outputSignal)->next = NULL;
            accumulator = *outputSignal;
        } 
        else 
        {
            accumulator->next = (struct Signal *)malloc(sizeof(struct Signal));
            accumulator = accumulator->next;
            accumulator->data = initial;
            accumulator->next = NULL;
        }
        
        inputSignal1 = inputSignal1->next;
        inputSignal2 = inputSignal2->next;
        inputSignal3 = inputSignal3->next;
    }
}

// Source code:
//  scanldSY :: (a -> b -> a) -- ^Combinational function for next state
//                            -- decoder
//      -> a                  -- ^Initial state
//      -> Signal b           -- ^ Input signal
//      -> Signal a           -- ^ Output signal
//  scanldSY f mem xs = s'
//      where s' = delaySY mem $ zipWithSY f s' xs

// Function to perform scanldSY operation
// void scanldSY(int (*function)(int, int), int initial, struct Signal *inputSignal, struct Signal **outputSignal)
// {
//     struct Signal *sPrime = NULL; // Initialize an empty s'

//     while (inputSignal != NULL)
//     {
//         delaySY(initial, &sPrime);                              // Delay s' with the initial value
//         zipWithSY(function, sPrime, inputSignal, outputSignal); // Apply the function and update the output signal
//         inputSignal = inputSignal->next;
//     }
// }

// testing a new implementation of scanldSY - YVES
void scanldSY(int (*function)(int, int), int initial, struct Signal *inputSignal, struct Signal **outputSignal)
{
    // N.B. The implementation is not strictly the same as the Shallow implementation
    struct Signal *accumulator; // Initialize an accumulator
    
    *outputSignal = (struct Signal *)malloc(sizeof(struct Signal));
    (*outputSignal)->data = initial;
    (*outputSignal)->next = NULL;
    accumulator = *outputSignal;


    while (inputSignal != NULL)
    {
        initial = (*function)(initial, inputSignal->data);
        
        accumulator->next = (struct Signal *)malloc(sizeof(struct Signal));
        accumulator = accumulator->next;
        accumulator->data = initial;
        accumulator->next = NULL;
            
        inputSignal = inputSignal->next;
    }
}

// Source code:
// -- | The process constructor 'scanld2SY' behaves like 'scanldSY', but
// -- has two input signals.
// scanld2SY ::    (a -> b -> c -> a) -> a -> Signal b -> Signal c
//      -> Signal a
// scanld2SY f mem xs ys = s'
//     where s' = delaySY mem $ zipWith3SY f s' xs ys

// Function to perform scanld2SY operation
void scanld2SY(int (*function)(int, int, int), int initial, struct Signal *inputSignal1, struct Signal *inputSignal2, struct Signal **outputSignal)
{
    // N.B. The implementation is not strictly the same as the Shallow implementation
    struct Signal *accumulator; // Initialize an accumulator

    *outputSignal = (struct Signal *)malloc(sizeof(struct Signal));
    (*outputSignal)->data = initial;
    (*outputSignal)->next = NULL;
    accumulator = *outputSignal;
    
    while (inputSignal1 != NULL && inputSignal2 != NULL)
    {
        initial = (*function)(initial, inputSignal1->data, inputSignal2->data);
        
        accumulator->next = (struct Signal *)malloc(sizeof(struct Signal));
        accumulator = accumulator->next;
        accumulator->data = initial;
        accumulator->next = NULL;
      
        inputSignal1 = inputSignal1->next;
        inputSignal2 = inputSignal2->next;
    }
}

// Source code:
// -- | The process constructor 'scanld3SY' behaves like 'scanldSY', but has three input signals.
// scanld3SY :: (a -> b -> c -> d -> a) -> a -> Signal b
//           -> Signal c -> Signal d -> Signal a
// scanld3SY f mem xs ys zs = s'
//   where s' = delaySY mem $ zipWith4SY f s' xs ys zs

// Function to perform scanld3SY operation
void scanld3SY(int (*function)(int, int, int, int), int initial, struct Signal *inputSignal1, struct Signal *inputSignal2, struct Signal *inputSignal3, struct Signal **outputSignal)
{
    // N.B. The implementation is not strictly the same as the Shallow implementation
    struct Signal *accumulator; // Initialize an accumulator

    *outputSignal = (struct Signal *)malloc(sizeof(struct Signal));
    (*outputSignal)->data = initial;
    (*outputSignal)->next = NULL;
    accumulator = *outputSignal;
    
    while (inputSignal1 != NULL && inputSignal2 != NULL && inputSignal3 != NULL)
    {
        initial = (*function)(initial, inputSignal1->data, inputSignal2->data, inputSignal3->data);
        
        accumulator->next = (struct Signal *)malloc(sizeof(struct Signal));
        accumulator = accumulator->next;
        accumulator->data = initial;
        accumulator->next = NULL;
       
        inputSignal1 = inputSignal1->next;
        inputSignal2 = inputSignal2->next;
        inputSignal3 = inputSignal3->next;
    }
} 

// Source code:
//  mooreSY :: (a -> b -> a) -- ^Combinational function for next state
//                           -- decoder
//          -> (a -> c)      -- ^Combinational function for output decoder
//          -> a             -- ^Initial state
//          -> Signal b      -- ^Input signal
//          -> Signal c      -- ^Output signal
//  mooreSY nextState output initial
//      = mapSY output . (scanldSY nextState initial)

// Moore state machine function
void mooreSY(int (*nextState)(int, int), int (*output)(int), int initial, struct Signal *inputSignal, struct Signal **outputSignal)
{
    struct Signal *accumulator = NULL; // Initialize an empty accumulator

    scanldSY(nextState, initial, inputSignal, &accumulator); // Apply the function and update the output signal
    mapSY(output, accumulator, outputSignal);                // Map the output function over the output signal
}

// Source code:
//  moore2SY ::   (a -> b -> c -> a) -> (a -> d) -> a -> Signal b
//           -> Signal c -> Signal d
//  moore2SY nextState output initial inp1 inp2 =
//    mapSY output (scanld2SY nextState initial inp1 inp2)

// Moore state machine function with two input signals
void moore2SY(int (*nextState)(int, int, int), int (*output)(int), int initial, struct Signal *inputSignal1, struct Signal *inputSignal2, struct Signal **outputSignal)
{
    struct Signal *accumulator = NULL; // Initialize an empty accumulator

    scanld2SY(nextState, initial, inputSignal1, inputSignal2, &accumulator);    // Apply the function and update the output signal
    mapSY(output, accumulator, outputSignal);                                   // Map the output function over the output signal
}

// Source code:
//  moore3SY :: (a -> b -> c -> d -> a) -> (a -> e) -> a -> Signal b
//           -> Signal c -> Signal d -> Signal e
//  moore3SY nextState output initial inp1 inp2 inp3 =
//    mapSY output (scanld3SY nextState initial inp1 inp2 inp3)

// Moore state machine function with three input signals
void moore3SY(int (*nextState)(int, int, int, int), int (*output)(int), int initial, struct Signal *inputSignal1, struct Signal *inputSignal2, struct Signal *inputSignal3, struct Signal **outputSignal)
{
    struct Signal *accumulator = NULL; // Initialize an empty accumulator

    scanld3SY(nextState, initial, inputSignal1, inputSignal2, inputSignal3, &accumulator);  // Apply the function and update the output signal
    mapSY(output, accumulator, outputSignal);                                               // Map the output function over the output signal
}

// Source code:
//  mealySY :: (a -> b -> a) -- ^Combinational function for next state
//                           -- decoder
//         -> (a -> b -> c)  -- ^Combinational function for output decoder
//         -> a              -- ^Initial state
//         -> Signal b       -- ^Input signal
//         -> Signal c       -- ^Output signal
//  mealySY nextState output initial sig =
//    zipWithSY output state sig
//    where state = scanldSY nextState initial sig

// Mealy state machine function
void mealySY(int (*nextState)(int, int), int (*output)(int, int), int initial, struct Signal *inputSignal, struct Signal **outputSignal)
{
    struct Signal *accumulator = NULL; // Initialize an empty accumulator

    scanldSY(nextState, initial, inputSignal, &accumulator); // Apply the function and update the output signal
    zipWithSY(output, accumulator, inputSignal, outputSignal);                // Map the output function over the output signal
}

// Source code:
//  mealy2SY :: (a -> b -> c -> a) -> (a -> b -> c -> d) -> a
//           -> Signal b -> Signal c -> Signal d
//  mealy2SY nextState output initial inp1 inp2 =
//    zipWith3SY output (scanld2SY nextState initial inp1 inp2) inp1 inp2

// Mealy state machine function
void mealy2SY(int (*nextState)(int, int, int), int (*output)(int , int, int), int initial, struct Signal *inputSignal1, struct Signal *inputSignal2, struct Signal **outputSignal)
{
    struct Signal *accumulator = NULL; // Initialize an empty accumulator

    scanld2SY(nextState, initial, inputSignal1, inputSignal2, &accumulator); // Apply the function and update the output signal
    zipWith3SY(output, accumulator, inputSignal1, inputSignal2, outputSignal);                // Map the output function over the output signal
}

// Source code:
//  mealy3SY :: (a -> b -> c -> d -> a) -> (a -> b -> c -> d -> e) -> a
//           -> Signal b -> Signal c -> Signal d -> Signal e
//  mealy3SY nextState output initial inp1 inp2 inp3 =
//    zipWith4SY output (scanld3SY nextState initial inp1 inp2 inp3) inp1 inp2 inp3

// Mealy state machine function
void mealy3SY(int (*nextState)(int, int, int, int), int (*output)(int, int, int, int), int initial, struct Signal *inputSignal1, struct Signal *inputSignal2, struct Signal *inputSignal3, struct Signal **outputSignal)
{
    struct Signal *accumulator = NULL; // Initialize an empty accumulator

    scanld3SY(nextState, initial, inputSignal1, inputSignal2, inputSignal3, &accumulator); // Apply the function and update the output signal
    zipWith4SY(output, accumulator, inputSignal1, inputSignal2, inputSignal3, outputSignal);                // Map the output function over the output signal
}

// Source code:
//  sourceSY :: (a -> a) -> a -> Signal a
//  sourceSY f s0 = o
//     where o = delaySY s0 s
//           s = mapSY f o

// Function to create a Signal based on the sourceSY function
void sourceSY(int (*function)(int), int initial, struct Signal **outputSignal)
{
    struct Signal *delayedSignal = NULL;
    struct Signal *sourceSignal = NULL;

    // Create and initialize the delayed part of the signal
    for (int i = 0; i < 5; i++)
    {
        struct Signal *newNode = createSignalNode(initial);
        newNode->next = delayedSignal;
        delayedSignal = newNode;
    }

    // Create and initialize the source signal
    for (int i = 0; i < 5; i++)
    {
        struct Signal *newNode = createSignalNode(0); // The initial source value
        newNode->next = sourceSignal;
        sourceSignal = newNode;
    }

    *outputSignal = delayedSignal; // The output signal starts with the delayed part

    // Apply the function to the source signal and update the output signal
    while (sourceSignal != NULL)
    {
        sourceSignal->data = function(sourceSignal->data);
        delayedSignal->data = sourceSignal->data;
        sourceSignal = sourceSignal->next;
        delayedSignal = delayedSignal->next;
    }
}

// Define the AbstExt structure
struct AbstExt
{
    int is_present; // Flag to indicate presence (0 for Abst, 1 for Prst)
    int value;      // Value for Prst (ignored for Abst)
};

// Source code:
//  filterSY :: (a -> Bool)        -- ^Predicate function
//           -> Signal a           -- ^Input signal
//           -> Signal (AbstExt a) -- ^Output signal
//  filterSY _ NullS   = NullS
//  filterSY p (x:-xs) = if (p x == True) then
//                         Prst x :- filterSY p xs
//                       else
//                         Abst :- filterSY p xs

// Function to filter a Signal by a predicate and create a new Signal with extended values (void version)
void filterSY(int (*predicate)(int), struct Signal *inputSignal, struct Signal **outputSignal)
{
    struct Signal *outputHead = NULL; // Initialize an empty output signal

    while (inputSignal != NULL)
    {
        int data = inputSignal->data;
        struct AbstExt value; // Create an AbstExt structure

        if (predicate(data) == 1)
        {
            // Add a present value to the AbstExt structure
            value.is_present = 1;
            value.value = data;
        }
        else
        {
            // Add an absent value to the AbstExt structure
            value.is_present = 0;
            value.value = 0; // Can be any default value
        }

        // Add the AbstExt structure to the output signal
        struct Signal *newSignal = (struct Signal *)malloc(sizeof(struct Signal));
        newSignal->data = *(int *)(&value.is_present); // Cast the AbstExt structure to an integer
        newSignal->next = NULL;

        if (*outputSignal == NULL)
        {
            *outputSignal = newSignal;
            outputHead = newSignal;
        }
        else
        {
            outputHead->next = newSignal;
            outputHead = newSignal;
        }

        inputSignal = inputSignal->next;
    }
}

// Source code:
//  fillSY :: a                  -- ^Default value
//         -> Signal (AbstExt a) -- ^Absent extended input signal
//         -> Signal a           -- ^Output signal
//  fillSY a xs = mapSY (replaceAbst a) xs
//        where replaceAbst a' Abst     = a'
//              replaceAbst _  (Prst x) = x

// Function to fill a Signal with a default value
void fillSY(int defaultValue, struct Signal *inputSignal, struct Signal **outputSignal)
{
    struct Signal *outputHead = NULL; // Initialize an empty output signal

    while (inputSignal != NULL)
    {
        int is_present = inputSignal->data;
        struct Signal *newSignal = (struct Signal *)malloc(sizeof(struct Signal));

        if (is_present)
        {
            newSignal->data = inputSignal->next->data; // Extract the value
        }
        else
        {
            newSignal->data = defaultValue; // Fill with the default value
        }

        newSignal->next = NULL;

        if (*outputSignal == NULL)
        {
            *outputSignal = newSignal;
            outputHead = newSignal;
        }
        else
        {
            outputHead->next = newSignal;
            outputHead = newSignal;
        }

        inputSignal = inputSignal->next->next;
    }
}

// Source code:
//  holdSY :: a                  -- ^Default value
//         -> Signal (AbstExt a) -- ^Absent extended input signal
//         -> Signal a           -- ^Output signal
//  holdSY a xs = scanlSY hold a xs
//        where hold a' Abst     = a'
//              hold _  (Prst x) = x

// Function to apply the hold function to a Signal and create a new Signal with extended values (void version)
void holdSY(int defaultValue, struct Signal *inputSignal, struct Signal **outputSignal)
{
    struct Signal *outputHead = NULL; // Initialize an empty output signal
    struct AbstExt currentHold;
    currentHold.is_present = 0;
    currentHold.value = defaultValue;

    while (inputSignal != NULL)
    {
        struct AbstExt input = *(struct AbstExt *)(&(inputSignal->data));
        struct Signal *newSignal = (struct Signal *)malloc(sizeof(struct Signal));

        if (input.is_present)
        {
            currentHold = input;                      // Update the current hold value
            newSignal->data = *(int *)(&currentHold); // Set the current hold value
        }
        else
        {
            newSignal->data = *(int *)(&currentHold); // Use the current hold value
        }

        newSignal->next = NULL;

        if (*outputSignal == NULL)
        {
            *outputSignal = newSignal;
            outputHead = newSignal;
        }
        else
        {
            outputHead->next = newSignal;
            outputHead = newSignal;
        }

        inputSignal = inputSignal->next->next;
    }
}



///////////////////////////
/* Synchronous Processes */
///////////////////////////

struct SignalTuple
{
    int data1;
    int data2;
    struct SignalTuple *next;
};

struct SignalTuple3
{
    int data1;
    int data2;
    int data3;
    struct SignalTuple3 *next;
};

struct SignalTuple4
{
    int data1;
    int data2;
    int data3;
    int data4;
    struct SignalTuple4 *next;
};

struct SignalTuple5
{
    int data1;
    int data2;
    int data3;
    int data4;
    int data5;
    struct SignalTuple5 *next;
};

struct SignalTuple6
{
    int data1;
    int data2;
    int data3;
    int data4;
    int data5;
    int data6;
    struct SignalTuple6 *next;
};

// TODO: whenSY

// Source code:
// zipSY :: Signal a -> Signal b -> Signal (a,b)
// zipSY (x:-xs) (y:-ys) = (x, y) :- zipSY xs ys
// zipSY _       _       = NullS

void zipSY(struct Signal *signal1, struct Signal *signal2, struct SignalTuple **result)
{
    struct SignalTuple *currentResult = NULL;

    while (signal1 != NULL && signal2 != NULL)
    {
        int data1 = signal1->data;
        int data2 = signal2->data;

        if (*result == NULL)
        {
            *result = (struct SignalTuple *)malloc(sizeof(struct SignalTuple));
            (*result)->data1 = data1;
            (*result)->data2 = data2;
            (*result)->next = NULL;
            currentResult = *result;
        }
        else
        {
            currentResult->next = (struct SignalTuple *)malloc(sizeof(struct SignalTuple));
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

void zip3SY(struct Signal *signal1, struct Signal *signal2, struct Signal *signal3, struct SignalTuple3 **result)
{
    struct SignalTuple3 *currentResult = NULL;

    while (signal1 != NULL && signal2 != NULL && signal3 != NULL)
    {
        int data1 = signal1->data;
        int data2 = signal2->data;
        int data3 = signal3->data;

        if (*result == NULL)
        {
            *result = (struct SignalTuple3 *)malloc(sizeof(struct SignalTuple3));
            (*result)->data1 = data1;
            (*result)->data2 = data2;
            (*result)->data3 = data3;
            (*result)->next = NULL;
            currentResult = *result;
        }
        else
        {
            currentResult->next = (struct SignalTuple3 *)malloc(sizeof(struct SignalTuple3));
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
void zip4SY(struct Signal *signal1, struct Signal *signal2, struct Signal *signal3, struct Signal *signal4, struct SignalTuple4 **result)
{
    struct SignalTuple4 *currentResult = NULL;

    while (signal1 != NULL && signal2 != NULL && signal3 != NULL && signal4 != NULL)
    {
        int data1 = signal1->data;
        int data2 = signal2->data;
        int data3 = signal3->data;
        int data4 = signal4->data;

        if (*result == NULL)
        {
            *result = (struct SignalTuple4 *)malloc(sizeof(struct SignalTuple4));
            (*result)->data1 = data1;
            (*result)->data2 = data2;
            (*result)->data3 = data3;
            (*result)->data4 = data4;
            (*result)->next = NULL;
            currentResult = *result;
        }
        else
        {
            currentResult->next = (struct SignalTuple4 *)malloc(sizeof(struct SignalTuple4));
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
void zip5SY(struct Signal *signal1, struct Signal *signal2, struct Signal *signal3, struct Signal *signal4, struct Signal *signal5, struct SignalTuple5 **result)
{
    struct SignalTuple5 *currentResult = NULL;

    while (signal1 != NULL && signal2 != NULL && signal3 != NULL && signal4 != NULL && signal5 != NULL)
    {
        int data1 = signal1->data;
        int data2 = signal2->data;
        int data3 = signal3->data;
        int data4 = signal4->data;
        int data5 = signal5->data;

        if (*result == NULL)
        {
            *result = (struct SignalTuple5 *)malloc(sizeof(struct SignalTuple5));
            (*result)->data1 = data1;
            (*result)->data2 = data2;
            (*result)->data3 = data3;
            (*result)->data4 = data4;
            (*result)->data5 = data5;
            (*result)->next = NULL;
            currentResult = *result;
        }
        else
        {
            currentResult->next = (struct SignalTuple5 *)malloc(sizeof(struct SignalTuple5));
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
void zip6SY(struct Signal *signal1, struct Signal *signal2, struct Signal *signal3, struct Signal *signal4, struct Signal *signal5, struct Signal *signal6, struct SignalTuple6 **result)
{
    struct SignalTuple6 *currentResult = NULL;

    while (signal1 != NULL && signal2 != NULL && signal3 != NULL && signal4 != NULL && signal5 != NULL && signal6 != NULL)
    {
        int data1 = signal1->data;
        int data2 = signal2->data;
        int data3 = signal3->data;
        int data4 = signal4->data;
        int data5 = signal5->data;
        int data6 = signal6->data;

        if (*result == NULL)
        {
            *result = (struct SignalTuple6 *)malloc(sizeof(struct SignalTuple6));
            (*result)->data1 = data1;
            (*result)->data2 = data2;
            (*result)->data3 = data3;
            (*result)->data4 = data4;
            (*result)->data5 = data5;
            (*result)->data6 = data6;
            (*result)->next = NULL;
            currentResult = *result;
        }
        else
        {
            currentResult->next = (struct SignalTuple6 *)malloc(sizeof(struct SignalTuple6));
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
void unzipSY(struct SignalTuple *signal, struct Signal **result1, struct Signal **result2)
{
    struct Signal *currentResult1 = NULL;
    struct Signal *currentResult2 = NULL;

    while (signal != NULL)
    {
        int data1 = signal->data1;
        int data2 = signal->data2;

        if (*result1 == NULL && *result2 == NULL)
        {
            *result1 = (struct Signal *)malloc(sizeof(struct Signal));
            *result2 = (struct Signal *)malloc(sizeof(struct Signal));
            (*result1)->data = data1;
            (*result2)->data = data2;
            (*result1)->next = NULL;
            (*result2)->next = NULL;
            currentResult1 = *result1;
            currentResult2 = *result2;
        }
        else
        {
            currentResult1->next = (struct Signal *)malloc(sizeof(struct Signal));
            currentResult2->next = (struct Signal *)malloc(sizeof(struct Signal));
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
void unzip3SY(struct SignalTuple3 *signal, struct Signal **result1, struct Signal **result2, struct Signal **result3)
{
    struct Signal *currentResult1 = NULL;
    struct Signal *currentResult2 = NULL;
    struct Signal *currentResult3 = NULL;

    while (signal != NULL)
    {
        int data1 = signal->data1;
        int data2 = signal->data2;
        int data3 = signal->data3;

        if (*result1 == NULL && *result2 == NULL && *result3 == NULL)
        {
            *result1 = (struct Signal *)malloc(sizeof(struct Signal));
            *result2 = (struct Signal *)malloc(sizeof(struct Signal));
            *result3 = (struct Signal *)malloc(sizeof(struct Signal));
            (*result1)->data = data1;
            (*result2)->data = data2;
            (*result3)->data = data3;
            (*result1)->next = NULL;
            (*result2)->next = NULL;
            (*result3)->next = NULL;
            currentResult1 = *result1;
            currentResult2 = *result2;
            currentResult3 = *result3;
        }
        else
        {
            currentResult1->next = (struct Signal *)malloc(sizeof(struct Signal));
            currentResult2->next = (struct Signal *)malloc(sizeof(struct Signal));
            currentResult3->next = (struct Signal *)malloc(sizeof(struct Signal));
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
void unzip4SY(struct SignalTuple4 *signal, struct Signal **result1, struct Signal **result2, struct Signal **result3, struct Signal **result4)
{
    struct Signal *currentResult1 = NULL;
    struct Signal *currentResult2 = NULL;
    struct Signal *currentResult3 = NULL;
    struct Signal *currentResult4 = NULL;

    while (signal != NULL)
    {
        int data1 = signal->data1;
        int data2 = signal->data2;
        int data3 = signal->data3;
        int data4 = signal->data4;

        if (*result1 == NULL && *result2 == NULL && *result3 == NULL && *result4 == NULL)
        {
            *result1 = (struct Signal *)malloc(sizeof(struct Signal));
            *result2 = (struct Signal *)malloc(sizeof(struct Signal));
            *result3 = (struct Signal *)malloc(sizeof(struct Signal));
            *result4 = (struct Signal *)malloc(sizeof(struct Signal));
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
        }
        else
        {
            currentResult1->next = (struct Signal *)malloc(sizeof(struct Signal));
            currentResult2->next = (struct Signal *)malloc(sizeof(struct Signal));
            currentResult3->next = (struct Signal *)malloc(sizeof(struct Signal));
            currentResult4->next = (struct Signal *)malloc(sizeof(struct Signal));
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
void unzip5SY(struct SignalTuple5 *signal, struct Signal **result1, struct Signal **result2, struct Signal **result3, struct Signal **result4, struct Signal **result5)
{
    struct Signal *currentResult1 = NULL;
    struct Signal *currentResult2 = NULL;
    struct Signal *currentResult3 = NULL;
    struct Signal *currentResult4 = NULL;
    struct Signal *currentResult5 = NULL;

    while (signal != NULL)
    {
        int data1 = signal->data1;
        int data2 = signal->data2;
        int data3 = signal->data3;
        int data4 = signal->data4;
        int data5 = signal->data5;

        if (*result1 == NULL && *result2 == NULL && *result3 == NULL && *result4 == NULL && *result5 == NULL)
        {
            *result1 = (struct Signal *)malloc(sizeof(struct Signal));
            *result2 = (struct Signal *)malloc(sizeof(struct Signal));
            *result3 = (struct Signal *)malloc(sizeof(struct Signal));
            *result4 = (struct Signal *)malloc(sizeof(struct Signal));
            *result5 = (struct Signal *)malloc(sizeof(struct Signal));

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
        }
        else
        {
            currentResult1->next = (struct Signal *)malloc(sizeof(struct Signal));
            currentResult2->next = (struct Signal *)malloc(sizeof(struct Signal));
            currentResult3->next = (struct Signal *)malloc(sizeof(struct Signal));
            currentResult4->next = (struct Signal *)malloc(sizeof(struct Signal));
            currentResult5->next = (struct Signal *)malloc(sizeof(struct Signal));

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
void unzip6SY(struct SignalTuple6 *signal, struct Signal **result1, struct Signal **result2, struct Signal **result3, struct Signal **result4, struct Signal **result5, struct Signal **result6)
{
    struct Signal *currentResult1 = NULL;
    struct Signal *currentResult2 = NULL;
    struct Signal *currentResult3 = NULL;
    struct Signal *currentResult4 = NULL;
    struct Signal *currentResult5 = NULL;
    struct Signal *currentResult6 = NULL;

    while (signal != NULL)
    {
        int data1 = signal->data1;
        int data2 = signal->data2;
        int data3 = signal->data3;
        int data4 = signal->data4;
        int data5 = signal->data5;
        int data6 = signal->data6;

        if (*result1 == NULL && *result2 == NULL && *result3 == NULL && *result4 == NULL && *result5 == NULL && *result6 == NULL)
        {
            *result1 = (struct Signal *)malloc(sizeof(struct Signal));
            *result2 = (struct Signal *)malloc(sizeof(struct Signal));
            *result3 = (struct Signal *)malloc(sizeof(struct Signal));
            *result4 = (struct Signal *)malloc(sizeof(struct Signal));
            *result5 = (struct Signal *)malloc(sizeof(struct Signal));
            *result6 = (struct Signal *)malloc(sizeof(struct Signal));

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
        }
        else
        {
            currentResult1->next = (struct Signal *)malloc(sizeof(struct Signal));
            currentResult2->next = (struct Signal *)malloc(sizeof(struct Signal));
            currentResult3->next = (struct Signal *)malloc(sizeof(struct Signal));
            currentResult4->next = (struct Signal *)malloc(sizeof(struct Signal));
            currentResult5->next = (struct Signal *)malloc(sizeof(struct Signal));
            currentResult6->next = (struct Signal *)malloc(sizeof(struct Signal));

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
void fstSY(struct SignalTuple *signal, struct Signal **result)
{
    struct Signal *currentResult = NULL;

    while (signal != NULL)
    {
        int data1 = signal->data1;
        if (*result == NULL)
        {
            *result = (struct Signal *)malloc(sizeof(struct Signal));
            (*result)->data = data1;
            (*result)->next = NULL;
            currentResult = *result;
        }
        else
        {
            currentResult->next = (struct Signal *)malloc(sizeof(struct Signal));
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
void sndSY(struct SignalTuple *signal, struct Signal **result)
{
    struct Signal *currentResult = NULL;

    while (signal != NULL)
    {
        int data2 = signal->data2;
        if (*result == NULL)
        {
            *result = (struct Signal *)malloc(sizeof(struct Signal));
            (*result)->data = data2;
            (*result)->next = NULL;
            currentResult = *result;
        }
        else
        {
            currentResult->next = (struct Signal *)malloc(sizeof(struct Signal));
            currentResult = currentResult->next;
            currentResult->data = data2;
            currentResult->next = NULL;
        }

        signal = signal->next;
    }
}

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
    printf("}\n");
}

void freeSignal(struct Signal *signal) 
{
    struct Signal * temp = signal;
    while (signal != NULL)
    {
        signal = signal->next;
        free(temp);
        temp = signal;
    }
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
    printf("}\n");
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


int main () {
    struct Signal *mySig = (struct Signal *)malloc(sizeof(struct Signal));
    mySig->next = NULL;
    mySig->data = 1;

    struct Signal *mySig2 = (struct Signal *)malloc(sizeof(struct Signal));
    mySig2->next = NULL;
    mySig2->data = -1;
    append_to_signal(mySig2, 2);
    append_to_signal(mySig2, 3);

    struct Signal *mySig3 = (struct Signal *)malloc(sizeof(struct Signal));
    mySig3->next = NULL;
    mySig3->data = 1;

    for (int i = 2; i < 6; i++)
    {
        append_to_signal(mySig, i);
        append_to_signal(mySig2, (i+2));
        append_to_signal(mySig3, i);
    }

    // struct Signal *output = NULL;
    // struct SignalTuple *output = NULL;
    struct Signal *out1 = NULL;
    struct Signal *out2 = NULL;

    sourceSY(incr, 0, &out1);

    struct Signal * current = mySig;
    printSignal(mySig);
    freeSignal(mySig);

    printSignal(mySig2);
    freeSignal(mySig2);
    
    // printSignal(mySig3);
    freeSignal(mySig3);

    // printSignal(output);
    // freeSignal(output);

    // printSignalTuple(output);
    // freeSignalTuple(output);

    printSignal(out1);
    freeSignal(out1);

    printSignal(out2);
    freeSignal(out2);

    return 0;
}