# Image manipulation
This folder contains functions for image manipulation:
- [bounds2localfeature.m](./bounds2localfeature.m): This function calculates shape and local features from the encoded shape of a region proposal.
- [flip_image.m](./flip_image.m): This function is used within data augmentation to flip images and re-calculating defective regions.
- [highlight_defects.m](./highlight_defects.m): This function is used to highlight defects on a single image.
- [segmentate_image.m](./segmentate_image.m): This function is used to segmentate an image given a map of the pixels of interesting regions.