function [Wm,Mbest,Vbest,cbest,Em,E_M,E_VV]=MAWTS(X,Y,vmax)
% function for finding the optimal input-layers number of the neuronet

% M: the neurons number of the input layer (i.e., the number of lagged...
% observations)
% V: the neurons powers of the hidden layers

S=round(length(X)/3); E_M=zeros(S,1); Em=inf; Ev=zeros(4,1); K=length(Y);
p=length(X)/(length(X)+K);
K1=round(p*K); % size of data fitting
K2=K-K1;       % size of data validation
for M=1:S
    % find the optimal hidden-layer neurons weights of the neuronet
    
    V=[]; c=[];  % the neurons number of the hidden layer (i.e., hidneurons)
    E_Mm=inf;    % Initialization
    XY=test_NN(X,Y,M); X1=XY(:,1:end-1); Y1=XY(:,end); E_V=zeros(vmax,1);
    for v=0:vmax-1        
        for i=1:4
            Q=Qmatrix(X1,M,[V;v],c,i);
            W=pinv(Q(1:K1,:))*Y1(1:K1); % WDD Method
            Ev(i)=100/K2*sum(abs((Q(K1+1:end,:)*W-Y1(K1+1:end))./Y1(K1+1:end))); % MAPE
        end
            E_V(v+1)=min(Ev);
        if E_V(v+1)<Em
            r=find(Ev==E_V(v+1));
            E_Mm=E_V(v+1);V=[V;v];c=[c;r(1)];
        end
    end
    
    E_M(M)=E_Mm;
    if E_M(M)<Em
        Q=Qmatrix(X1,M,V,c);
        W=pinv(Q)*Y1;  % WDD Method
        Em=E_M(M);Mbest=M;Wm=W;Vbest=V;cbest=c;E_VV=E_V;
    end
end