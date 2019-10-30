% Stats on number of regions per surface. The group of images is selected
% through ui.

d = uigetdir(pwd, "");
files = dir(fullfile(d, '*.jpg'));
tot = size(files,1);
nregions = []; last_im = ''; count = 0;
for file_index = 1:tot
    fname = extractBefore(files(file_index,1).name, '.jpg');
    imname = extractBefore(fname, size(fname,2) - 3);
    if strcmp(imname, last_im) == 0
        if strcmp(last_im, "") == 0
            nregions = [nregions; count];
        end
        last_im = imname;
        count = 0;
    end
    count = count + 1;
end