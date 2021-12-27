function Y=predictNN(X,model,M,Z)
% function for predicting


YY=[X;zeros(Z,1)];
for i=1:Z
YY(M+i)=model.predictFcn(YY(i:M-1+i)');
end
Y=YY(end-Z+1:end);