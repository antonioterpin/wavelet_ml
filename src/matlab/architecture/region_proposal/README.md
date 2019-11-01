# Image processing

This folder will contain code relative to the border detection stage of the proposed architecture:
- [image_processing.m](./image_processing.m): Some example code for image processing.
- [defect_edge_detection.m](./defect_edge_detection.m): This function implements the edge-based defect detection based on Kovesi algorithm and hysteretic thresholding.
- [segmentation_main.m](./segmentation_main.m): This script contains all the stages for segmentation optimization, test and results export.
- [segmentation_configuration.m](./segmentation_configuration.m): This script configures the segmentation for both training and testing.
- [segmentation_optimization.m](./segmentation_optimization.m): This function calculates the optimal segmentation parameters on the given image for the chosen defect class using the [loss function](../../libs/loss_function.m).
- [segmentation_test.m](./segmentation_test.m): This function evaluates the segmentation accuracy with the given parameters, using the [accuracy function](./accuracy_segmentation.m).
- [segmentation_test_im.m](./segmentation_test_im.m): Test segmentation on given image.
- [segmentation_test_im_plots.m](./segmentation_test_im_plots.m): Interface between [segmentation_main.m](./segmentation_main.m) and [segmentation_test_im.m](./segmentation_test_im.m).
- [accuracy_segmentation.m](./accuracy_segmentation.m): This function evaluates the accuracy metric used for image segmentation.

## Kovesi libraries
The [cleaning](./cleaning/) and [kovesi](./kovesi/) folders contain utils functions taken from [P. Kovesi web page](https://www.peterkovesi.com/matlabfns).