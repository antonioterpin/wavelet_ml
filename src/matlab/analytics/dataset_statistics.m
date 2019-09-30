% Plot statistics of interesting dataset

globals();
global formatted_dataset_path training_set_path cv_set_path test_set_path; % original dataset
global augmented_dataset_path;

% load datasets
opts = detectImportOptions(training_set_path);
train_set = readtable(training_set_path, opts);
opts = detectImportOptions(cv_set_path);
cv_set = readtable(cv_set_path, opts);
opts = detectImportOptions(test_set_path);
test_set = readtable(test_set_path, opts);
opts = detectImportOptions(formatted_dataset_path);
dataset = readtable(formatted_dataset_path, opts);
opts = detectImportOptions(augmented_dataset_path);
balanced_dataset = readtable(augmented_dataset_path, opts);

figure;

% original dataset
subplot(2,2,1);
title("Original dataset");
bar_stats = [not_exclusive_stats(train_set) not_exclusive_stats(cv_set) not_exclusive_stats(test_set)];
perc_stats = bar_stats / size(dataset,1);
bar(perc_stats, "stacked");
ylabel("%");
xticklabels(["Flawless Surfaces","Class 1","Class 2","Class 3","Class 4"])

subplot(2,2,2);
title("Original dataset");
pie_stats = exclusive_stats_categories(dataset);
pie(pie_stats, ones(size(categories(pie_stats)))); % TODO fix

subplot(2,2,3:4);
title("Balanced dataset");
bar_stats = not_exclusive_stats(balanced_dataset);
perc_stats = bar_stats / size(balanced_dataset,1);
bar(perc_stats, "stacked");
ylabel("%");
xticklabels({"Flawless Surfaces","Class 1","Class 2","Class 3","Class 4"})


% Script functions

function counts = not_exclusive_stats(dataset)
    % NOT_EXCLUSIVE_STATS Calculate the not exclusive stats of the given
    % dataset.
    
    logical_dataset = ~strcmp(dataset{:,2:end}, ""); % 1 where there is a defect, 0 otherwise
    vals = sum(logical_dataset)'; % sum through columns gives the number of surfaces with a particular defect
    n_flawless = sum(sum(logical_dataset, 2) == 0); % sum through rows and looking for zeros gives the flawless surfaces
    counts = [n_flawless; vals];
end

function categories = exclusive_stats_categories(dataset)
    % EXCLUSIVE_STATS calculate the categorical vector for the
    % surfaces in the given dataset.
    
    logical_dataset = ~strcmp(dataset{:,2:end}, ""); % 1 where there is a defect, 0 otherwise
    categories = categorical(cellstr(num2str(logical_dataset)));
end