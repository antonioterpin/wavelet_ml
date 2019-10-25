%% 1. CREAZIONE TRAINING e TEST SET

% random 'seed' per la riproducibilità (stessi k-fold)
rng(0,'twister') 

% training e test set

% con 40 feat

% con 28 feat
train_csv = readtable('../dataset/biclass/qnt10ms_lin/28feat/train_std_co_lowpass3035.csv'); 
test_csv  = readtable('../dataset/biclass/qnt10ms_lin/28feat/test_std_co_lowpass3035.csv');

% con 36 feat

% features da utilizzare
idx_feat = [1:28]; % tutte
% idx_feat = [1:40]; % tutte
% idx_feat = [1:20 37:40]; 

Xtrain = cell2mat(table2cell(train_csv(:,idx_feat)));
Xtest  = cell2mat(table2cell(test_csv(:,idx_feat)));
Ytrain = cell2mat(table2cell(train_csv(:,end)));
Ytest  = cell2mat(table2cell(test_csv(:,end)));


%% 2. CLASSIFICATORE RANDOM FOREST e TRAINING

minLS = optimizableVariable('minLS',[1,30],'Type','integer');
numPTS = optimizableVariable('numPTS',[1,size(Xtrain,2)-1],'Type','integer');
% numTree = optimizableVariable('numTree',[100,500],'Type','integer');
% maxSplit = optimizableVariable('maxSplit',[1,30],'Type','integer');
% hyperparametersRF = [minLS, numPTS];
hyperparametersRF = [minLS, numPTS];

results = bayesopt(@(params)oobErrRF(params,Xtrain,Ytrain),...
                    hyperparametersRF,...
                    'AcquisitionFunctionName','expected-improvement-plus',...
                    'Verbose',1);
                
%                 ,...
%                     'PlotFcn',[]
                
bestOOBErr = results.MinObjective;
bestHyperparameters = results.XAtMinObjective;
                
Mdl = TreeBagger(300,Xtrain,Ytrain,...
                 'Method','classification',...
                 'NumPredictorsToSample',bestHyperparameters.numPTS,...
                 'MinLeafSize',bestHyperparameters.minLS);       
             
%                  'MaxNumSplits',bestHyperparameters.maxSplit

CompactRFModel = compact(Mdl);


%% 3. TEST DEL CLASSIFICATORE

% previsioni del classificatore sul test set
Ypredicted = str2num(cell2mat(predict(CompactRFModel,Xtest)));

% confusion matrix
conf_mat = confusionmat(Ytest,Ypredicted);

% true positive
TP = conf_mat(2,2);
% true negative
TN = conf_mat(1,1);
% false positive
FP = conf_mat(1,2);
% false negative
FN = conf_mat(2,1);

% conteggio manuale
% TP=sum(and(Ypredicted==1,Ytest==1));
% TN=sum(and(Ypredicted==0,Ytest==0));
% FP=sum(and(Ypredicted==1,Ytest==0));
% FN=sum(and(Ypredicted==0,Ytest==1));

% accuratezza
acc = (TP+TN)/(TP+TN+FP+FN);
fprintf("ACCURACY: %.2f %%\n", acc*100);


%% 4. grafici dei dati
% -> su Python


function oobErr = oobErrRF(params,X,Y)

    RF = TreeBagger(300,X,Y,...
                    'Method','classification',...
                    'OOBPrediction','on',...
                    'NumPredictorstoSample',params.numPTS,...
                    'MinLeafSize',params.minLS);  
                
%                     'MaxNumSplits',params.maxSplit

    oobErr = oobError(RF, 'Mode','ensemble');
end
