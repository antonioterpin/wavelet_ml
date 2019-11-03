%% CHAPTER 'DETECTOR'

%% example of edge detection
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

% example of segmentation + bounding box
params.kov_nscale = 4;
params.kov_norient = 6;
params.kov_min_wl = 3;
params.kov_mult = 2.1;
params.hyst_tl = 50;
params.hyst_th = 90;
params.alpha = 7;
params.hole_th = 8270;
params.region_th = 672;

segmentation_test_im_plots(im_name, class, params, ...
                           images_eq, images_eq_name, ...
                           images_high, images_high_name, ...
                           dataset,1);

                                           
%% CHAPTER 'RESULTS > DETECTOR'
% NB: le immagini con <- sono quelle state inserite

%% CLASS 1
save_flag = 0;
% im_name = 'f53e75337.jpg'; % bene la equalizzata
                           % buona per far vedere che nella non_eq l'acc aumenta grazie all'overhead
% im_name = 'd0cf465a8.jpg'; % bene la non equalizzata (difetto piccolo) <-
% im_name = 'de89591c4.jpg'; % bene la non equalizzata (difetto verticale)
% im_name = 'cd3b9899c.jpg'; % NOTA: per fare vedere i limiti dell'approccio basato solo su bordi

segmentation_test_im_plots(im_name, 1, params_1, images, images_name, images_high, images_high_name, dataset, save_flag);
% segmentation_test_im_plots(im_name, 1, params_eq_1, images_eq, images_eq_name, images_high, images_high_name, dataset, save_flag);
  

%% CLASS 2
save_flag = 0;

% im_name = 'b9b3b12aa.jpg'; % benino
% im_name = 'c720250a2.jpg'; % bene <-
% im_name = '2a7f8bab0.jpg'; % le becca per fortuna
% im_name = '4613d520c.jpg'; % le becca per fortuna

% im_name = '78b5bc846.jpg'; % acc alta ma troppo overhead
% im_name = '1d718ddb9.jpg'; % acc alta ma troppo overhead
% im_name = '332e21cbc.jpg'; % acc alta ma troppo overhead

% im_name = 'a56df9123.jpg'; % artefatti molto molto brutti sull'equalizzata
% im_name = '8b9c035ec.jpg'; % problemi derivanti dal minmax?

segmentation_test_im_plots(im_name, 2, params_2, images, images_name, images_high, images_high_name, dataset, save_flag);
segmentation_test_im_plots(im_name, 2, params_eq_2, images_eq, images_eq_name, images_high, images_high_name, dataset, save_flag);
                                           
                                           
%% CLASS 3
save_flag = 0;
% im_name = '9574104d6.jpg'; % bene <-
% im_name = '18f057e52.jpg'; % bene (difetto piccolo)
% im_name = 'ea476b31f.jpg'; % bene (area non uniforme)
% im_name = 'dafaf1165.jpg'; % benino (azzecca bene 1 area piccola su 2)
% im_name = '93b2882fd.jpg'; % benino (difetto verticale)
% im_name = '9db1d6f4c.jpg'; % benino (difetti verticali)
% im_name = '0386ce84b.jpg'; % 3 regioni prese benino
% im_name = 'd74442547.jpg'; % BENE ma forma strana
% im_name = 'd5425f5f5.jpg';
% im_name = '7a807824c.jpg'; % bene
% im_name = 'eabd4acaa.jpg'; % PATTERN DOVUTO A EQUALIZZAZIONE
% im_name = '9efbf2ac6.jpg'; % PATTERN DOVUTO A EQUALIZZAZIONE
% im_name = 'e473f2647.jpg'; % per far vedere lo svantaggio di un approccio basato solo su edge


% va meglio senza equalizzazione
% im_name = 'd1dd9098c.jpg'; % a volte l'equalizzazione è dannosa quando il difetto risalta bene in partenza
% im_name = 'c927281da.jpg'; % come sopra

% va meglio con equalizzazione
% im_name = '8e8404fe0.jpg'; % striscione gigante contornato bene
% im_name = '8a90952b4.jpg'; % strisciate in alto a destra contornate bene
im_name = 'fc2968239.jpg'; % li becca entrambi
% im_name = '9d685a825.jpg'; % ne becca uno
% im_name = '08852b69d.jpg'; 

segmentation_test_im_plots(im_name, 3, params_3, images, images_name, images_high, images_high_name, dataset, save_flag);
segmentation_test_im_plots(im_name, 3, params_eq_3, images_eq, images_eq_name, images_high, images_high_name, dataset, save_flag);

                                           
%% CLASS 4
save_flag = 1;
% im_name = '132511b8b.jpg'; % bene (area grande)
% im_name = '2c8c3cb8a.jpg'; % bene (area grande)
% im_name = 'f444c57a7.jpg'; % bene (2 difetti piccoli)
% im_name = 'bb65f4269.jpg'; % bene (difetto verticale)
% im_name = '1c8802c08.jpg';
% im_name = 'c084838d5.jpg'; % benino
% im_name = '9d4b9f63c.jpg';
% im_name = '1bea66c7a.jpg'; % benino
im_name = '1b5427b35.jpg'; % bene <-
% im_name = '2e8733afa.jpg'; % bene

% im_name = 'f5c8f7766.jpg'; % benino
% im_name = 'dc94faafc.jpg'; % benino --
% im_name = 'b68ac5910.jpg'; % benino (difetto piccolo)
% im_name = 'b138e942e.jpg'; % benino ma con overhead

% im_name = 'ce02060b9.jpg'; % da usare per far vedere il vantaggio di usare l'equalizzazione (quando non ci sono pattern brutti)
            
segmentation_test_im_plots(im_name, 4, params_4, images, images_name, images_high, images_high_name, dataset, save_flag);
segmentation_test_im_plots(im_name, 4, params_eq_4, images_eq, images_eq_name, images_high, images_high_name, dataset, save_flag);
                               


%% HISTOGRAMS OF SEGMENTATION ACCURACY
% put non-equalized and equalized data in test_data_# and test_data_eq_# respectively
save_flag = 1;

%%
accuracy_histogram(test_data_1,1,[0 450],0,save_flag);
accuracy_histogram(test_data_eq_1,1,[0 450],1,save_flag);
accuracy_histogram(test_data_2,2,[0 500],0,save_flag);
accuracy_histogram(test_data_eq_2,2,[0 500],1,save_flag);
accuracy_histogram(test_data_3,3,[0 300],0,save_flag);
accuracy_histogram(test_data_eq_3,3,[0 300],1,save_flag);
accuracy_histogram(test_data_4,4,[0 400],0,save_flag);
accuracy_histogram(test_data_eq_4,4,[0 400],1,save_flag);

function accuracy_histogram(data, class, ylim_data, eq_flag, save_flag)

    if nargin==3
        eq_flag = 0;
        save_flag = 0;
    elseif nargin==4
        save_flag = 0;
    end
    
    if eq_flag
        title_data = strcat("Detector accuracy on the test set - class ",num2str(class)," (equalized)");
        filename = strcat("acc-segmentation-class",num2str(class),"-eq.jpg");
    else
        title_data = strcat("Detector accuracy on the test set - class ",num2str(class));
        filename = strcat("acc-segmentation-class",num2str(class),".jpg");
    end

    figure('Position',[0 50 900 300]);
    % histogram(cell2mat(data(:,2)),0:0.05:1);
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
