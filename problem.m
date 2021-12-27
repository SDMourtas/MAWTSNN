function [X_train,Y_train,X_test,Y_test]=problem(x)
% Input data and parameters of the MI-WASDTSN setup

% Neuronet model options
if x==1
filename='IPG2211A2N.csv';  % Example 1
data=readtable(filename,'ReadVariableNames',true,'ReadRowNames' ,false,'TreatAsEmpty' ,'-');
data=data{:,2}; % monthly data of IPG2211A2N
G=176;   % total number of observations for training
Z=50;    % number of forecasting data
p=0.65;  % percentage train-validate
elseif x==2
filename='IPG21222S.csv';  % Example 2
data=readtable(filename,'ReadVariableNames',true,'ReadRowNames' ,false,'TreatAsEmpty' ,'-');
data=data{:,2}; % monthly data of IPG21222S
G=200;   % total number of observations for training
Z=50;    % number of forecasting data
p=0.7;   % percentage train-validate
elseif x==3
data1=xlsread('market'); data=data1(:,2);
G=180;   % total number of observations for training
Z=50;    % number of forecasting data
p=0.7;  % percentage train-validate
elseif x==4
data1=xlsread('market'); data=data1(:,5);
G=180;   % total number of observations for training
Z=50;    % number of forecasting data
p=0.7;  % percentage train-validate
else
s=x-4; % change stock (for s=1 to 20)
data1=xlsread('market'); data=data1(:,s);
G=180;   % total number of observations for training
Z=50;    % number of forecasting data
p=0.7;  % percentage train-validate
end

tr=round(p*G);
X_train=data(1:tr,1);
Y_train=data(tr+1:G,1);
X_test=data(1:G,1);
Y_test=data(G+1:G+Z,1);