# Analytics
In this directory there are scripts and live functions that analyze and describe data:
- [defect_analysis.m](./defect_analysis.m): script used to gain a statistical perspective about defects.
- [dataset_statistics.m](./dataset_statistics.m): script to plot basic statistics about the dataset.
- [defect_visualization.m](./defect_visualization.m): This script runs [highlight_defects.m](../libs/image-manipulation/highlight_defects.m) on all the augmented dataset, saving the output images in [manipuldated-images/defects-highlighted](../../../data/manipuldated-images/defects-highlighted).
- [region_per_image.m](./region_per_image.m): This function calculates the number of regions per image in a segmentated folder (e.g. local-features/1).
- [distribution_hypothesis_tests.m](./distribution_hypothesis_tests.m): This function returns the results of various hypothesis tests on the given set of values.
- [distribution_plot.m](./distribution_plot.m): This function plots distribution charts from the given data.
- [map2distribution_map.m](./map2distribution_map.m): This function calculates the distribution map from the rle encoding (map) of a set of defective images.