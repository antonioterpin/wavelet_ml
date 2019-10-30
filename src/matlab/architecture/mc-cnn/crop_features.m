function crop_features(crop_size)
% CROP_FEATURES Crop local features to desired size

    if nargin < 1
        crop_size = 800;
    end
    
    assert(mod(crop_size, 2) == 0, "Crop size must be even");
    
    globals()
    global local_crop_preprocessed_images local_crop_images local_feature_images local_feature_preprocessed_images;
    global number_defect_classes;

    % create folders
    mkdir(local_crop_preprocessed_images);
    mkdir(local_crop_images);

    crop_defect_class_waitbar = waitbar(0, "Cropping images..");
    for class_id = 1:number_defect_classes
        % crop local features
        waitbar(class_id / number_defect_classes, crop_defect_class_waitbar, sprintf("Cropping images of class %d", class_id));
        to_folder = sprintf("%s%d/", local_crop_images, class_id);
        from_folder = sprintf("%s%d/", local_feature_images, class_id);
        mkdir(to_folder);
        crop_images_in_folder(from_folder, to_folder, crop_size);
        % crop local features preprocessed
        waitbar(class_id / number_defect_classes, crop_defect_class_waitbar, sprintf("Cropping preprocessed images of class %d", class_id));
        to_folder = sprintf("%s%d/", local_crop_preprocessed_images, class_id);
        from_folder = sprintf("%s%d/", local_feature_preprocessed_images, class_id);
        mkdir(to_folder);
        crop_images_in_folder(from_folder, to_folder, crop_size);
    end
    close(crop_defect_class_waitbar);
end

%%%% SCRIPTS
function crop_images_in_folder(from_folder, to_folder, crop_size)
    files = dir(fullfile(from_folder, '*.jpg'));
    crop_image_waitbar = waitbar(0, "Cropping images..");
    n_files = size(files,1);
    for i = 1:n_files
        waitbar(i / n_files, crop_image_waitbar, sprintf("Cropping image %d of %d...", i, n_files));
        fname = files(i,1).name;
        I = imread(sprintf("%s%s", from_folder, fname));
        sz = max(size(I));
        I_squared = zeros(sz);
        I_squared((sz - size(I,1)) / 2 + 1:(sz - size(I,1)) / 2 + size(I,1), (sz - size(I,2)) / 2 + 1:(sz - size(I,2)) / 2 + size(I,2)) = uint8(I);
        crop_limits = (sz - crop_size) / 2:(sz - crop_size) / 2 + crop_size;
        imwrite(uint8(I_squared(crop_limits, crop_limits)),sprintf("%s%s",to_folder,fname));
    end
    close(crop_image_waitbar);
end
