# Dataset manipulation
The scripts used to manipulate the dataset can be found in this directory.

### Dataset formatting
Dataset descriptor can be formatted to be easier to use with the [dataset_formatting.m](./dataset_formatting.m) script. All the other code written in matlab relies on the provided formatting.

### Data augmentation
Data augmentation is used to unskew the dataset (see [dataset_statistics.m](../analytics/dataset_statistics.m)) and it is implemented is [data_augmentation.m](./data_augmentation.m).

### Dataset division
The dataset is divided in training, cross-validation and test sets through [dataset_division.m](./dataset_division.m) function.

### Dataset preprocessing
The [dataset_preprocessing.m](./dataset_preprocessing.m) script performs some basic manipulation on images, such as rgb to gray scale conversion, or histogram equalization.