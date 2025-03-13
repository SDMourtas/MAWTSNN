function E=error_pred(X,Y)

R=(X-Y)./Y; Z=length(R);
[row,col]=find(isnan(R)); R(row,col)=0;
[row,col]=find(isinf(R)); R(row,col)=0;

yh=mean(Y); % test
SStot=sum((X-yh).^2);
SSres=sum((X-Y).^2);
R2=1-SSres/SStot;
fprintf('The R-squared is: %f \n',R2)

E=100/Z*sum(abs(R)); % MAPE
fprintf('The MAPE is: %f \n',E)

R=X-Y;
E=sum(abs(R))/Z; % MAE
fprintf('The MAE is: %f \n',E)

E=sqrt(sum(R.^2)/Z); % RMSE
fprintf('The RMSE is: %f \n',E)
