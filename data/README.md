# Data
In this folder there are data of different kinds.

## Images
Original images should be kept in the [images](./images) folder. However, a text placeholder is used, since images are not tracked by git.

## Manipulated data
In the [manipulated-data](./manipulated-data) folder there are csv files containing information about manipulated data.

## Manipulated images
In the [manipulated-images](./manipulated-images) folder there are some texts placeholders used to keep its structure. Data manipulation routines save in these subfolders ([compressed-images](./compressed-images), [defects-highlighted](./defects-highlighted), [preprocessed-images](./preprocessed-images)) their output images.

## MC-CNN related data
[ideal-mc-cnn](./ideal-mc-cnn) contains the features used to train the mc-cnn architecture:
- [shape-features](./ideal-mc-cnn/shape-features) Images, differentiated by type, with the b/w border of the interesting regions.
- [local-features](./ideal-mc-cnn/local-features) Images, differentiated by type, with the gray scale rectangular region of interest.

## Exports
In the [exports](./exports) folder there are saved results of computationally expensive operations. In particular, there are variables regarding:
- [defect-analysis](./exports/defect-analysis) Results of defect analyses.
- [mc-cnn](./exports/mc-cnn) Data relative to the mc-cnn architecture.
  - [data](./exports/mc-cnn/data) Training, cross validation and test data.
  - [net](./exports/mc-cnn/net) Trained networks.