% Visualize defects on images

% import dataset
globals();
global formatted_dataset_path column_image_id;
opts = detectImportOptions(formatted_dataset_path);
dataset = readtable(formatted_dataset_path, opts);

number_of_images = size(dataset,1);
defects_drawing_waitbar = waitbar(0, 'Drawing defects on images');
for i = 1 : number_of_images
    image_row = dataset(i,:);
    waitbar(i / number_of_images, defects_drawing_waitbar, sprintf('Drawing defects on image: %s', image_row{1,column_image_id}{1}));
    highlight_defects(image_row);
end
close(defects_drawing_waitbar);