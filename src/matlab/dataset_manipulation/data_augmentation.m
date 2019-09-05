% Augment number of images of steel surfaces with defect classes with low frequency                                                        

globals();

global formatted_dataset_path augmented_dataset_path;

opts = detectImportOptions(formatted_dataset_path);
dataset = readtable(formatted_dataset_path, opts);

augmented_dataset = dataset;
number_of_original_images = size(dataset,1);

% do not increase the number of surfaces with only class_id 3 or flawless.
dataset = dataset(...
    find(strcmp(dataset.EncodedPixels1, '') == 0 ... 
    | strcmp(dataset.EncodedPixels2, '') == 0 ...
    | strcmp(dataset.EncodedPixels4, '') == 0), :);


number_of_images = size(dataset,1);
data_augmentation_waitbar = waitbar(0, 'Augmenting less frequent defects...');
for i = 1 : number_of_images
    image_row = dataset(i,:);
    new_rows = flip_image(image_row, 'jpg');
    augmented_dataset = [augmented_dataset; new_rows];
    waitbar(i / number_of_images, data_augmentation_waitbar, 'Augmenting less frequent defects...');
end
close(data_augmentation_waitbar);

writetable(augmented_dataset, augmented_dataset_path);