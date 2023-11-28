# C-Skeletons

This folder contains skeletons for some of the process constructors defined for ForSyDe-Shallow. Currently they are only defined for typ int.

---

## SDF
All SDF Actors has been translated from the ForSyDe-Shallow API. https://hackage.haskell.org/package/forsyde-shallow-3.5.0.0/docs/ForSyDe-Shallow-MoC-SDF.html

The delaySDF process constructor has not been implemented.

---

## MOC Synchronos library
A subset of the synchronos library (https://hackage.haskell.org/package/forsyde-shallow-3.5.0.0/docs/ForSyDe-Shallow-MoC-Synchronous.html) has been translated to C skeletons. Below it is specified which process constructors has been tested for some inputs.

### Tested process constructors
The process constructors below has been tested for simple cases. They have not gone through any rigorous testing.

- mapSY
- zipWithSY, zipWith3SY, zipWith4SY
- combSY, comb2SY, comb3SY, comb4SY
- delaySY
- delaynSY
- scanlSY, scanl2SY, scanl3SY
- scanldSY, scanld2SY, scanld3SY
- mooreSY, moore2SY, moore3SY
- mealySY, mealy2SY, mealy3SY
- zipSY,    (the others has not been tested but are implemented in similar fashion)
- unsipSY,  (the others has not been tested but are implemented in similar fashion)
- fstSY
- sndSY

### Not implemented yet
- mapxSY
- zipWithxSY
- sourceSY  (does not work)
- filterSY  (does not work)
- fillSY    (Not tested)
- holdSY    (Not tested)
- whenSY
- zipxSY
- unzipxSY

