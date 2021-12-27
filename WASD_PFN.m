%   Main paper: T.E. Simos, S.D.Mourtas, V.N.Katsikis,              %
%               "Time-Varying Black-Litterman Portfolio Optimization%
%               under Nonlinear Constraints via Neuronets and BAS   %
%               Algorithm," Applied Soft Computing, 107767, 2021    %

function pred=WASD_PFN(z,Z,x)

if x==1
    G=176; L=30;  T=30;
elseif x==2
    G=200; L=40;  T=40;
else
    G=180;  L=40;  T=40;
end
kmax=10; % number of training iterations

% Data Preprocessing
n=G+Z;
x=1:n;x=x';
D = polyfit(x,z,1);
zD=@(t)z(t)./polyval(D,t)';
zC_min=zD(1);zC_max=zD(1);
for i=2:n
    zC_min=min(zC_min,zD(i));
    zC_max=max(zC_max,zD(i));
end
zCn=@(t)(zD(t)-zC_min)/(4*zC_max-4*zC_min)-0.5;
Xz=zeros(n,1);
for i=1:n
    Xz(i)=zCn(i);
end

% PFN model
tic
M=WASD(Xz,G,T,L,kmax); % optimal structure of the PFN
toc
[W,N]=OHLW(Xz,G-T,L,M,kmax); % optimal hidden-layer structure
H=G-M-L+1;     % previous samples
YY=Xz(1:G);YY(G+1:G+Z)=0;
for i=1:Z
Q=Qmatrix2(YY,M,i,H,N);
YY(G+1:G+i)=Q*W;
end
A=YY(G+1:G+Z);
B=@(t)(A(t)+0.5)*(4*zC_max-4*zC_min)+zC_min;
C=@(t)(B(t)).*polyval(D,G+t)';
pred=zeros(Z,1);
for i=1:Z
    pred(i)=C(i);
end