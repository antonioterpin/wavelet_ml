% Augment number of images of steel surfaces with defect classes with low frequency                                                        

globals();

global formatted_dataset_path augmented_dataset_path; % dataset
global compressed_images preprocessed_images augmentated_images augmentated_preprocessed_images; % images

mkdir(augmentated_images);
mkdir(augmentated_preprocessed_images);

opts = detectImportOptions(formatted_dataset_path);
dataset = readtable(formatted_dataset_path, opts);

augmented_dataset = dataset;
number_of_original_images = size(dataset,1);

% copy all old data
% copyfile(compressed_images, augmentated_images);
% copyfile(preprocessed_images, augmentated_preprocessed_images);
% since the above exceed maximum list length
data_augmentation_waitbar = waitbar(0, "Copying old images...");
for i = 1 : number_of_original_images
    waitbar(i / number_of_original_images, data_augmentation_waitbar, sprintf("Copying old images... Image %d of %d", i, number_of_original_images))
    copyfile(sprintf("%s%s",compressed_images,dataset{i,1}{1}),sprintf("%s%s",augmentated_images,dataset{i,1}{1}));
    copyfile(sprintf("%s%s",preprocessed_images,dataset{i,1}{1}),sprintf("%s%s",augmentated_preprocessed_images,dataset{i,1}{1}));
end
close(data_augmentation_waitbar);

% do not increase the number of surfaces with only class_id 3 or flawless.
dataset = dataset(...
    find(strcmp(dataset.EncodedPixels1, "") == 0 ... 
    | strcmp(dataset.EncodedPixels2, "") == 0 ...
    | strcmp(dataset.EncodedPixels4, "") == 0), :);


number_of_images = size(dataset,1);
data_augmentation_waitbar = waitbar(0, "Augmenting less frequent defects...");
for i = 1 : number_of_images
    image_row = dataset(i,:);
    new_rows = flip_image(image_row, "jpg");
    augmented_dataset = [augmented_dataset; new_rows];
    waitbar(i / number_of_images, data_augmentation_waitbar, sprintf("Augmenting less frequent defects... Image %d of %d", i, number_of_images));
end
close(data_augmentation_waitbar);

writetable(augmented_dataset, augmented_dataset_path);