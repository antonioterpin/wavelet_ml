# Dataset manipulation
The scripts used to manipulate the dataset can be found in this directory:
- [dataset_formatting.m](./dataset_formatting.m): script to format the dataset descriptor. All the other code written in matlab relies on the provided formatting.
- [data_augmentation.m](./data_augmentation.m): to perform data augmentation in order to unskew the dataset (see [dataset_statistics.m](../analytics/dataset_statistics.m)).
- [dataset_division.m](./dataset_division.m): the dataset is divided in training, cross-validation and test sets through this function.
- [dataset_preprocessing.m](./dataset_preprocessing.m): this script performs some basic manipulation on images, such as rgb to gray scale conversion, or histogram equalization.