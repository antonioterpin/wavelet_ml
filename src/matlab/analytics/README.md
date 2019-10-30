# Analytics
In this directory there are scripts and live functions that analyze and describe data.

### defect_analysis.m
This script is used to gain a statistical perspective about defects.

### dataset_statistics.m
This script plot basic statistics about the dataset.

### defect_visualization.m
This script run [highlight_defects.m](../libs/image-manipulation/highlight_defects.m) on all the augmented dataset, saving the output images in [manipuldated-images/defects-highlighted](../../../data/manipuldated-images/defects-highlighted).

### region_per_image.m
This function calculates the number of regions per image in a segmentated folder (e.g. local-features/1).

### distribution_hypothesis_tests.m
This function returns the results of various hypothesis tests on the given set of values.

### distribution_plot.m
This function plots distribution charts from the given data.

### map2distribution_map.m
This function calculates the distribution map from the rle encoding (map) of a set of defective images.