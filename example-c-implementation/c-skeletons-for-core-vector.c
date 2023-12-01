#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "c-skeletons-for-SY.h"
#include "c-skeletons-for-core-vector.h"


// -- | The data type 'Vector' is modeled similar to a list. It has two data type constructors. 'NullV' constructs the empty vector, while ':>' constructsa vector by adding an value to an existing vector..

// data Vector a = NullV
//               | a :> (Vector a) deriving (Eq)
// struct VectorSignal {
//     struct Signal* signal;
//     struct VectorSignal* next;
// };

// struct Vector {
//     int data;
//     struct Vector* next;
// };

// struct SignalVector {
//     struct Vector* vector;
//     struct SignalVector* next;
// };


/////////////
/* QUERIES */
/////////////

// -- | The function 'nullV' returns 'True' if a vector is empty. 
// nullV       :: Vector a -> Bool
// nullV NullV = True
// nullV _     = False
bool nullV(struct Vector* vector)
{
    if (vector == NULL) {
        return true;
    } else {
        return false;
    }
}

// -- | The function 'lengthV' returns the number of elements in a value. 
// lengthV         :: Vector a -> Int
// lengthV NullV   = 0
// lengthV (_:>xs) = 1 + lengthV xs
int lengthV(struct Vector* vector)
{
    if (vector->next == NULL){
        return 1;
    } else {
        return 1 + lengthV(vector->next);
    }
} 

////////////////////////////
/* HIGHER ORDER SKELETONS */
////////////////////////////

// -- | The higher-order function 'mapV' applies a function on all elements of a vector.
// mapV :: (a -> b)
//      -> Vector a  -- ^ /length/ = @la@
//      -> Vector b  -- ^ /length/ = @la@
// mapV f (x:>xs) = f x :> mapV f xs
// mapV _ NullV   = NullV
void mapV(int (*function)(int), struct Vector *vector, struct Vector **result)
{
    struct Vector *currentResult = NULL;
    
    while (vector != NULL)
    {
        int data = vector->data;
        int resultData = function(data);

        if (*result == NULL)
        {
            *result = (struct Vector *)malloc(sizeof(struct Vector));
            (*result)->data = resultData;
            (*result)->next = NULL;
            currentResult = *result;
        }
        else
        {
            currentResult->next = (struct Vector *)malloc(sizeof(struct Vector));
            currentResult = currentResult->next;
            currentResult->data = resultData;
            currentResult->next = NULL;
        }

        vector = vector->next;
    }
}



// -- | The higher-order function 'zipWithV' applies a function pairwise on two vectors.
// zipWithV :: (a -> b -> c)
//          -> Vector a  -- ^ /length/ = @la@
//          -> Vector b  -- ^ /length/ = @lb@
//          -> Vector c  -- ^ /length/ = @minimum [la,lb]@
// zipWithV f (x:>xs) (y:>ys) = f x y :> (zipWithV f xs ys)
// zipWithV _ _ _ = NullV

// -- | The higher-order function 'zipWithV3' applies a function 3-tuple-wise on three vectors.
// zipWith3V :: (a -> b -> c -> d)
//           -> Vector a  -- ^ /length/ = @la@
//           -> Vector b  -- ^ /length/ = @lb@
//           -> Vector c  -- ^ /length/ = @lc@
//           -> Vector d  -- ^ /length/ = @minimum [la,lb,lc]@
// zipWith3V f (x:>xs) (y:>ys) (z:>zs) = f x y z :> (zipWith3V f xs ys zs)
// zipWith3V _ _ _ _ = NullV


// -- | Reduces a vector of elements to a single element based on a
// -- binary function.
// --
// reduceV :: (a -> a -> a) -> Vector a -> a
// reduceV _ NullV      = error "Cannot reduce a null vector"
// reduceV _ (x:>NullV) = x
// reduceV f (x:>xs)    = foldlV f x xs
void reduceV(int (*function)(int, int), struct Vector * vector, int **result) 
{
    if (*result == NULL)
    {
        *result = (int *)malloc(sizeof(int));
        **result = 0;
    }
    // only one element in vector
    if (vector->next == NULL)
    {
        **result = vector->data;
        return;
    } else 
    {
        struct Vector * temp = vector;
        while (temp != NULL)
        {
            **result = function(**result, temp->data);
            temp = temp->next;
        }
    }
}