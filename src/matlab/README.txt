All the code in this directory assumes that pwd is here.

Folder structure:

init.m
wavelet_intro.mlx
|___libs
    |___image-manipulation
    |___rle
|___dataset-manipulation
|___architecture
    |___image-processing
    |___mc-cnn
|___analytics

Folder description:

INIT.M
Since all the code in this directory assumes that pwd is here, init.m add all paths to be able to run all the code.

WAVELET_INTRO.MLX
Live script introducing wavelets and wavelet analysis.

LIBS
This folder contains common utilities functions.
    RLE
    This folder contains utilities to rle encode and decode pixels.
    IMAGE-MANIPULATION
    This folder contains utilities to manipulate images.

DATASET-MANIPULATION
This folder contains functions and live scripts used to manipulate dataset.

ARCHITECTURE
This folder contains functions and live scripts used to implement and describe the architecture.   
    IMAGE-PROCESSING
    This folder contains functions and live scripts used to implement the image processing step.
    MC-CNN
    This folder contains functions and live scripts used to implement the multi-column convolutional neural network.

ANALYTICS
This folder contains functions and live scripts used to perform analysis on data.
