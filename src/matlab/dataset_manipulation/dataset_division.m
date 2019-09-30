function dataset_division(train_set_perc, test_set_perc, type, use_augmented_dataset)
% DATASET_DIVISION Dataset division in training set, cross validation set
% and test set.
%
%   DATASET_DIVISION(train_set_perc, test_set_perc) Divides the dataset 
%   randomly, #train_set_perc% of the rows in the training set, 
%   #test_set_perc% of the rows in the test set, and the remaining ones in
%   the cross validation set.
%
%   DATASET_DIVISION(_, type) Divides the dataset in different ways:
%       * type = "Randomly": random division
%       * type = "Anomaly": in the training set there are only flawless
%                   surfaces, in the cv and test sets there are both.
%
%   DATASET_DIVISION(_, use_augmented_dataset) Use the unskew dataset.
%
%   Further developments: implement type = "Anomaly".
    
    random_type = "Randomly";
    if nargin < 3
        type = random_type;
    end
    if nargin < 4
       use_augmented_dataset = false;
    end
    
    assert(strcmp(type, random_type), "At the moment only random division is supported");
    assert(train_set_perc + test_set_perc <= 1, "Percentages must sum up to something less or equal to 1");
    
    % Load global variables
    globals();
    global formatted_dataset_path augmented_dataset_path training_set_path cv_set_path test_set_path; % datasets
    
    dataset_path = formatted_dataset_path;
    if use_augmented_dataset
        dataset_path = augmented_dataset_path;
    end
    % import dataset
    opts = detectImportOptions(dataset_path);
    dataset = readtable(dataset_path, opts);
    
    number_of_images = size(dataset, 1);
    train_set_size = floor(train_set_perc * number_of_images);
    test_set_size = floor(test_set_perc * number_of_images);
    cv_set_size = number_of_images - (train_set_size + test_set_size);

    
    if strcmp(type, "Randomly")
        % divide dataset randomly
        random_dataset = dataset(randperm(number_of_images),:); % random shuffle
        train_set = random_dataset(1:train_set_size,:);
        cv_set = random_dataset(train_set_size + 1:train_set_size + cv_set_size,:);
        test_set = random_dataset(train_set_size + cv_set_size + 1:train_set_size + cv_set_size + test_set_size,:);
    end
    
    % save datasets
    writetable(train_set, training_set_path);
    writetable(test_set, test_set_path);
    writetable(cv_set, cv_set_path);
    
end