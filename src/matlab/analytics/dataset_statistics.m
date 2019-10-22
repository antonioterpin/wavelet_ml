% Plot statistics of interesting dataset

globals();
global formatted_dataset_path training_set_path cv_set_path test_set_path; % original dataset
global augmented_dataset_path;

% load datasets
% opts = detectImportOptions(formatted_dataset_path);
dataset = readtable(formatted_dataset_path, 'Delimiter', ',');
% opts = detectImportOptions(training_set_path, 'FileType','text');
train_set = readtable(training_set_path, 'Delimiter', ',');
% opts = detectImportOptions(cv_set_path);
cv_set = readtable(cv_set_path, 'Delimiter', ',');
% opts = detectImportOptions(test_set_path);
test_set = readtable(test_set_path, 'Delimiter', ',');
% opts = detectImportOptions(augmented_dataset_path);
balanced_dataset = readtable(augmented_dataset_path, 'Delimiter', ',');

%%
% original dataset
fig1 = figure('Position',[0 50 900 300]);
% bar_stats = [not_exclusive_stats(train_set) not_exclusive_stats(cv_set) not_exclusive_stats(test_set)];
bar_stats = [not_exclusive_stats(dataset)];
perc_stats = bar_stats / size(dataset,1);
bar(perc_stats);
title("Class representation in the original dataset");
ylabel("%");
xticklabels(["Flawless","Class 1","Class 2","Class 3","Class 4"])

%%
fig2 = figure('Position',[0 50 900 300]);
pie_stats = exclusive_stats_categories(dataset);
% pie(pie_stats, ones(size(categories(pie_stats)))); % TODO fix

cat_names = str2num(cell2mat(categories(pie_stats)));
cat_names_str = strings(length(cat_names),1);

for i=1:length(cat_names)
    
    if isequal(cat_names(i,:),[0 0 0 0])
        cat_names_str(i) = "0";
    else
        n_defect = 0;
        for j=1:4
            if cat_names(i,j)
                n_defect = n_defect+1;
                if n_defect > 1
                    cat_names_str(i) = cat_names_str(i) + ',' + num2str(j);
                else
                    cat_names_str(i) = cat_names_str(i) + num2str(j);
                end
            end
        end
    end

end
cat_names_str = cellstr(cat_names_str);

pie_stats=renamecats(pie_stats,categories(pie_stats),cat_names_str);
histogram(pie_stats,'Normalization','probability');
ylabel('%');
title("Frequencies of defect combinations");

%%
fig3 = figure('Position',[0 50 900 300]);
bar_stats = not_exclusive_stats(balanced_dataset);
perc_stats = bar_stats / size(balanced_dataset,1);
bar(perc_stats, "stacked");
title("Augmented dataset");
ylabel("%");
xticklabels({"Flawless","Class 1","Class 2","Class 3","Class 4"})

%%

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