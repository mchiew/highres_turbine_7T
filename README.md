# Ultra-High Resolution fMRI at 7T using Radial-Cartesian TURBINE sampling

## Raw Data

Raw datasets in ISMRMRD format for the paper: Graedel NN, Miller KL, Chiew M, "Ultra-High Resolution fMRI at 7T using Radial-Cartesian TURBINE sampling", Magnetic Resonance in Medicine.

The following data are 0.67 mm isotropic slab datasets over the visual cortex, acquired using 3D TURBINE (hybrid radial-Cartesian) sampling, with a 58 ms acquisition shot-TR, with a 30s/30s off/on flashing checkerboard task. Other relevant acquisition parameters can be found in the paper, or in the data headers.

- Dataset 1: https://doi.org/10.5281/zenodo.6619414
- Dataset 2: https://doi.org/10.5281/zenodo.6620395
- Dataset 3: https://doi.org/10.5281/zenodo.6620499

## Example Reconstruction

An example reconstruction is provided, along with a prepared single-slice raw [dataset](https://github.com/mchiew/highres_turbine_7T/releases/download/v1.0/single_slice_prepared.mat). The reconstruction is written in MATLAB, and depends on Jeff Fessler's Michigan Image Reconstruction Toolbox (https://web.eecs.umich.edu/~fessler/code/) for NUFFT operations (not included).
