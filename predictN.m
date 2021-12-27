function Y=predictN(X,M,W,V,c,x_min,x_max,Z)
% function for predicting

X_N=Normalization(X,x_min,x_max);

YY=[X_N;zeros(Z,1)];
for i=1:Z
Q=Qmatrix(YY(i:M-1+i)',M,V,c);
YY(M+i)=Q*W;
end
Y_N=YY(end-Z+1:end);

Y=(Y_N+0.5)*(4*x_max-4*x_min)+x_min;