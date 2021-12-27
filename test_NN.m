function X=test_NN(X_train,Y_train,M)
XX=[X_train;Y_train];
kk=length(X_train);k=length(Y_train);
X=zeros(k,M+1);
for i=1:k
X(i,:)=XX(kk-M+i:kk+i);
end