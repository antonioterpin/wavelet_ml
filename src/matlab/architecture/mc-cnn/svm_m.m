function CompactSVMModel = svm_m(Xtrain,Ytrain,Xtest,Ytest)


%% 2. CLASSIFICATORE SVM e TRAINING

% K-Fold validation 
% Il training set viene suddiviso in K=5 coppie di validation/training set,
% le quali per le K-Fold cross validation
c = cvpartition(size(Xtrain,1),'KFold',5);

% Proprietà dell'ottimizzatore degli iperparametri
% - Optimizer: tipo di ottimizzatore ('bayesopt' è l'ottimizzatore bayesiano)
% - Verbose: se 1 mostra nella console l'avanzamento dell'ottimizzazione
% - ShowPlots: se true mostra l'avanzameto dell'ottimizzatore nel grafico
% - CVPartition: cross-validation set da usare (salvati prima in c)
% - AcquisitionFunctionName: tipo di acquisition function usata dall'ottimizzatore
opts = struct('Optimizer','bayesopt',...
              'Verbose',1,...
              'ShowPlots',true,...
              'CVPartition',c,...
              'AcquisitionFunctionName','expected-improvement-plus');
          
% Creazione modello del classificatore
% - Standardize: se 1 standardizza i dati (0 perchè l'abbiamo già fatto)
% - KernelFunction: tipo di kernel ('gaussian' è quello gaussiano)
LearnerTemplate = templateSVM('Standardize',0,...
                              'KernelFunction','gaussian');

% Training del classificatore
% - Xtrain: training set
% - Ytrain: label del traning set
% - Learners: modello di classificatore da addestrare
% - FitPosterior: ....
% - OptimizeHyperparameters: iperparametri da ottimizzare
%       BoxConstraint: parametro di regularization
%       KernelScale: parametri kernel gaussiano
% - HyperparameterOptimizationOptions: proprietà dell'ottimizzazione
%   degli iperparametri (struttura 'opts' definita prima)
Mdl = fitcecoc(Xtrain,Ytrain,...
               'Learners',LearnerTemplate,...
               'OptimizeHyperparameters',{'BoxConstraint','KernelScale'},...
               'HyperparameterOptimizationOptions',opts);

% Versione computazionalmente più leggera del classificatore
% (ad esempio non contiene al suo interno il training set)
CompactSVMModel = compact(Mdl);