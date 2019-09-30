% Dataset csv formatting.

% Load global variables
globals();
global dataset_path formatted_dataset_path; % datasets
global number_defect_classes column_encoded_pixels column_image_id; % dataset details

% import original dataset
opts = detectImportOptions(dataset_path);
dataset = readtable(dataset_path, opts);

% format dataset
number_of_images = size(dataset,1) / number_defect_classes;
dataset_formatted = cell2table(cell(number_of_images,1 + number_defect_classes)); % create empty table
formatting_dataset_waitbar = waitbar(0, "Formatting dataset..."); % initialize waitbar

for i = 1 : number_of_images
    dataset_formatted{i,:} = format_image_row(dataset((i - 1) * number_defect_classes + 1 : i * number_defect_classes, :), 'jpg');
    waitbar(i / number_of_images, formatting_dataset_waitbar, "Formatting dataset..."); % update waitbar
end
close(formatting_dataset_waitbar); % close waitbar

% rename columns
dataset_formatted.Properties.VariableNames{"Var1"} = column_image_id;
for i = 1 : number_defect_classes
    dataset_formatted.Properties.VariableNames{strcat("Var", num2str(i + 1))} = strcat(column_encoded_pixels, num2str(i));
end

% save formatted dataset to csv
writetable(dataset_formatted, formatted_dataset_path);

%%%%%%%%%%%%%%%%%%
% Script functions

function formatted_row = format_image_row(image_rows, image_type)
    % FORMAT_IMAGE_ROW Format the given image_rows into a single image_row
    %
    %   formatted_row = format_image_row(image_rows, image_type) This 
    %   routine returns, given the image_rows referring to the same image 
    %   but describing different defect classes, a single image_row
    %   containing all information.
    
    global column_encoded_pixels column_image_id_class_id;
    
    if nargin < 2
        image_type = "jpg";
    end
    
    formatted_row = erase(image_rows{1, column_image_id_class_id}, extractAfter(image_rows{1, column_image_id_class_id}, image_type));
    
    for i = 1:size(image_rows, 1)
        formatted_row(i + 1) = image_rows{i, column_encoded_pixels};
    end
end