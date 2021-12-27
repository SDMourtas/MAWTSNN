function Problem_figures(pred,pred1,pred2,pred3,pred4,X_test,Y_test,E_M,E_V,V,c,M,Z,x)

figure
R=length(X_test);
plot(1:R+Z,[X_test;Y_test],'Color',[0.4660 0.6740 0.1880])
hold on
plot(R:R+Z,[X_test(end);pred],'Color',[0.4940 0.1840 0.5560])
if x<5
plot(R:R+Z,[X_test(end);pred1],'--','Color',[0.3010 0.7450 0.9330])
plot(R:R+Z,[X_test(end);pred2],':','Color',[0.8500 0.3250 0.0980])
plot(R:R+Z,[X_test(end);pred3],'--','Color',[0.9290 0.6940 0.1250])
plot(R:R+Z,[X_test(end);pred4],'-.','Color',[0 0.4470 0.7410])
legend('Actual price','MAWTSN Prediction','WASD-PFN Prediction',...
    'LSVM Prediction','EGPR Prediction','EBT Prediction')
else
legend('Actual price','MAWTSN Prediction')
end
xlabel('Time');ylabel('Price')
hold off

E_M(E_M==inf)=100;
figure;
semilogy(E_M,'Color',[0.4660 0.6740 0.1880],...
    'DisplayName','Delays Number Error');hold on
semilogy(M,E_M(M),'.','Color',[0.8500 0.3250 0.0980],...
        'MarkerSize',16,'DisplayName','Optimal Delays Number')
xlabel('M');ylabel('MAPE');legend;hold off

figure
semilogy(0:length(E_V)-1,E_V,'Color',[0.4660 0.6740 0.1880],...
    'DisplayName','Error of Optimal N')
hold on
if any(c==1)
    v=find(c==1);
    semilogy(V(v),E_V(V(v)+1),'.','Color',[0.8500 0.3250 0.0980],...
        'MarkerSize',16,'DisplayName','AF: Power')
end
if any(c==2)
    v=find(c==2);
    semilogy(V(v),E_V(V(v)+1),'.','Color',[0 0.4470 0.7410],...
        'MarkerSize',16,'DisplayName','AF: Power Sigmoid')
end
if any(c==3)
    v=find(c==3);
    semilogy(V(v),E_V(V(v)+1),'.','Color',[0.4940 0.1840 0.5560],...
        'MarkerSize',16,'DisplayName','AF: Power Inv. Exp.')
end
if any(c==4)
    v=find(c==4);
    semilogy(V(v),E_V(V(v)+1),'.','Color',[0.9290 0.6940 0.1250],...
        'MarkerSize',16,'DisplayName','AF: Power Softplus')
end
xlabel('Iteration');
ylabel('MAPE')
legend
hold off