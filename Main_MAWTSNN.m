%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  A 3-layer feed-forward neuronet model for time-series modeling   %
%  and forecasting problems, trained by a MAWTS algorithm.          %
%  (version 1.0)                                                    %
%  Developed in MATLAB R2021a                                       %
%                                                                   %
%  Author and programmer: S.D.Mourtas, V.N.Katsikis                 %
%                                                                   %
%   e-Mail: spirosmourtas@gmail.com                                 %
%           vaskatsikis@econ.uoa.gr                                 %
%                                                                   %
%   Main paper: S.D.Mourtas, V.N.Katsikis,                          %
%               "Exploiting the Black-Litterman Framework through   %
%               Error-Correction Neural Networks", Neurocomputing,  %
%               vol. 498, 43-58 (2022)                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear 
close all
clc

% Choose forecasting problem (for x = 1 to 24)
x=1;
[X_train,Y_train,X_test,Y_test]=problem(x);
vmax=50;          % maximum power of hidden-layer neurons
Z=length(Y_test); % number of forecasting prices

%% Training
% Data Preprocessing: Normalization
[XY_N,X_min,X_max]=Normalization([X_train;Y_train]); 
X_N=XY_N(1:length(X_train));
Y_N=XY_N(length(X_train)+1:end);

% Neuronet models Training
tic
[W,M,V,c,Em,E_M,E_V]=MAWTS(X_N,Y_N,vmax); % optimal structure of the MAWTSNN
toc

if x<5
pred1=WASD_PFN([X_train;Y_train;Y_test],Z,x); % WASD PFN model

X=test_NN(X_train,Y_train,M);
tic
TM_LSVM = LSVM(X,x); % Linear SVM model
toc
tic
TM_EGPR = EGPR(X,x); % Exponential GRP model
toc
tic
TM_EBT = EBT(X,x);   % Ensemble Bagged Trees model
toc
end

%% Predict
pred=predictN(X_test(end-M+1:end),M,W,V,c,X_min,X_max,Z);

fprintf('MAWTSN model statistics on test data: \n')
error_pred(pred,Y_test);  % Error of test data
if x<5
pred2=predictNN(X_test(end-M+1:end),TM_LSVM,M,Z);
pred3=predictNN(X_test(end-M+1:end),TM_EGPR,M,Z);
pred4=predictNN(X_test(end-M+1:end),TM_EBT,M,Z);

fprintf('WASD-PFN model statistics on test data: \n')
error_pred(pred1,Y_test);  % Error of test data
fprintf('LSVM model statistics on test data: \n')
error_pred(pred2,Y_test); % Error of test data
fprintf('EGPR model statistics on test data: \n')
error_pred(pred3,Y_test); % Error of test data
fprintf('EBT model statistics on test data: \n')
error_pred(pred4,Y_test); % Error of test data
else
pred1=[]; pred2=[]; pred3=[]; pred4=[];
end

%% Figures

Problem_figures(pred,pred1,pred2,pred3,pred4,X_test,Y_test,E_M,E_V,V,c,M,Z,x)
