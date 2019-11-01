%% EXAMPLE KOVESI + HYSTERESIS 
params.kov_nscale = 4;
params.kov_norient = 6;
params.kov_min_wl = 3;
params.kov_mult = 2.1;
params.hyst_tl = 50;
params.hyst_th = 90;
params.alpha = 7;
params.hole_th = 8270;
params.region_th = 672;

% class = 0;
% im_name = '0d0c21687.jpg';
class = 3;
im_name = '0b7a4c9b9.jpg';
im = readimage(images,find(strcmp(images_name,im_name)));
im_high = readimage(images_high,find(strcmp(images_high_name,im_name)));

M = phasecong3(im);
M_scaled = ( M - min(min(M)) ) ./ ( max(max(M)) - min(min(M)) ) .* 255;
imwrite(M_scaled,gray(256),'detector-kovesi.jpg');

TH = [50 100 150];
TL = [30 60 90];
for i=1:length(TH)
    map = defect_edge_detection(im, 4, 6, 3, 2.1, TL(i), TH(i));
    %figure('Position', [0 400 1600 256]);
    %colormap(gray(256));
    %imagesc(map);
    %set(gca,'xtick',[],'ytick',[]);
    imwrite(map,strcat('detector-ex-hysteresis-',num2str(TL(i)),'-',num2str(TH(i)),'.jpg'));
end

[loss_im, acc_im] = segmentation_test_im_plots(im_name, class, params, ...
                                               images, images_name, ...
                                               images_high, images_high_name, ...
                                               dataset,1);


                                           
%% DEFECTS SEGMENTATION
class = 1;
im_name = 'd0befd683.jpg';
% im_name = 'f53e75337.jpg';
% im_name = '';
% im_name = '';
% im_name = '';
% im_name = '933a9dc8b_h.jpg';
[loss_im, acc_im] = segmentation_test_im_plots(im_name, class, params_1, ...
                                               images, images_name, ...
                                               images_high, images_high_name, ...
                                               dataset,0);

%%
class = 2;
% im_name = '78b5bc846.jpg';  % bene
im_name = '7a31a3b5e.jpg';
% im_name = '18ba753ff.jpg';
% im_name = '1d718ddb9.jpg';
% im_name = '332e21cbc.jpg';
im_name = 'f30beded6.jpg'; % <-
% im_name = 'fbdc2daae.jpg'; % male 

% im_name = 'a56df9123.jpg'; % <- artefatti molto molto brutti
% im_name = 'b8a69919f.jpg';
% im_name = '8b9c035ec.jpg';

[loss_im, acc_im] = segmentation_test_im_plots(im_name, class, params_2, ...
                                               images, images_name, ...
                                               images_high, images_high_name, ...
                                               dataset, 0);

[loss_im_eq, acc_im_eq] = segmentation_test_im_plots(im_name, class, params_eq_2, ...
                                               images_eq, images_eq_name, ...
                                               images_high, images_high_name, ...
                                               dataset, save_flag);
                                           
                                           
%%
class = 3;
save_flag = 0;
% im_name = 'ee45a1736.jpg';
% im_name = 'ea476b31f.jpg';
% im_name = 'dafaf1165.jpg';
% im_name = 'd96428a9e.jpg';
% im_name = 'd598af62f.jpg'; % -> corretto ma con overhead
% im_name = 'bdff0aefc.jpg';
% im_name = '93b2882fd.jpg'; % <-
% im_name = '8a90952b4.jpg';
% im_name = '0386ce84b.jpg'; % brutto
% im_name = 'a08e02e56.jpg'; % pattern tipo cane
% im_name = '8e8404fe0.jpg';
% im_name = '87ebb9d4f.jpg'; % forma strana
% im_name = '810f96801.jpg'; % forma strana
% im_name = '7e63e3baf.jpg';
% im_name = '9db1d6f4c.jpg';

%va meglio senza equalizzazione
% im_name = 'd1dd9098c.jpg'; %bello per far vedere che a volte l'equalizzazione è dannosa quando il difetto risalta bene in partenza

%va meglio con equalizzazione
% im_name = 'fc2968239.jpg'; % li becca entrambi
% im_name = '9d685a825.jpg'; % ne becca uno
% im_name = '08852b69d.jpg'; % rivedere
im_name = '2f69f62ae.jpg';

[loss_im, acc_im] = segmentation_test_im_plots(im_name, class, params_3, ...
                                               images, images_name, ...
                                               images_high, images_high_name, ...
                                               dataset, save_flag);

[loss_im_eq, acc_im_eq] = segmentation_test_im_plots(im_name, class, params_eq_3, ...
                                               images_eq, images_eq_name, ...
                                               images_high, images_high_name, ...
                                               dataset, save_flag);
                                           
%%
class = 4;
save_flag = 0;
% im_name = 'f5c8f7766.jpg';
% im_name = 'dc94faafc.jpg';
% im_name = 'ce02060b9.jpg'; % da usare per far vedere il vantaggio di usare l'equalizzazione (quando non ci sono pattern brutti)
% im_name = 'b68ac5910.jpg';
% im_name = 'b138e942e.jpg'; % anche questa come sopra

[loss_im, acc_im] = segmentation_test_im_plots(im_name, class, params_4, ...
                                               images, images_name, ...
                                               images_high, images_high_name, ...
                                               dataset, save_flag);

[loss_im_eq, acc_im_eq] = segmentation_test_im_plots(im_name, class, params_eq_4, ...
                                               images_eq, images_eq_name, ...
                                               images_high, images_high_name, ...
                                               dataset, save_flag);
                                           


%% HISTOGRAMS OF SEGMENTATION ACCURACY
% put non-equalized and equalized data in test_data_# and test_data_eq_#
% respectively

save_flag = 0;
%%
accuracy_histogram(test_data_1,1,[0 450],0,save_flag);
accuracy_histogram(test_data_eq_1,1,[0 450],1,save_flag);
%%
accuracy_histogram(test_data_2,2,[0 500],0,save_flag);
accuracy_histogram(test_data_eq_2,2,[0 500],1,save_flag);
accuracy_histogram(test_data_real_eq_2,2,[0 500],1,save_flag);
%%
accuracy_histogram(test_data_3,3,[0 400],0,save_flag);
accuracy_histogram(test_data_eq_3,3,[0 400],1,save_flag);
accuracy_histogram(test_data_real_eq_3,3,[0 400],1,save_flag);
%%
accuracy_histogram(test_data_4,4,[0 500],0,save_flag);
accuracy_histogram(test_data_eq_4,4,[0 500],1,save_flag);
accuracy_histogram(test_data_real_eq_4,4,[0 500],1,save_flag);

function accuracy_histogram(data, class, ylim_data, eq_flag, save_flag)

    if nargin==3
        eq_flag = 0;
        save_flag = 0;
    elseif nargin==4
        save_flag = 0;
    end
    
    if eq_flag
        title_data = strcat("Segmentation accuracy on the test set - class ",num2str(class)," (equalized)");
        filename = strcat("acc-segmentation-class",num2str(class),"-eq.jpg");
    else
        title_data = strcat("Segmentation accuracy on the test set - class ",num2str(class));
        filename = strcat("acc-segmentation-class",num2str(class),".jpg");
    end

    figure('Position',[0 50 900 300]);
    histogram(cell2mat(data(:,3)),0:0.05:1);
    title(title_data);
    xlabel('Accuracy');
    ylabel('Number of images');
    ylim(ylim_data);
    xlim([0 1]);
    
    if save_flag
        saveas(gcf,filename);
    end
    
end
