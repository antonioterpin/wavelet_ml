# MC-CNN

All the primitives and scripts used to design, to train and to optimize the mc-cnn are in this folder.
For a brief introduction to this architecture, check [mc_cnn.mlx](./mc_cnn.mlx). 
The training and validation procedures can also be found in that live script.
- [structure_shape_column.m](./structure_shape_column.m) describes the layers of the shape feature column.
- [structure_local_column.m](./structure_local_column.m) describes the layers of the local feature column.
- [structure_global_column.m](./structure_global_column.m) describes the layers of the global feature column.
- [train_column.m](./train_column.m) centralize the training options for the different mc-cnn columns.
- [ds2segmented_class_folders.m](./ds2segmented_class_folders.m) prepares the features for mc-cnn columns training.