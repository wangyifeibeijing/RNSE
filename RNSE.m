function [ label,S,P ] = RNSE( X,clusnum, alpha,beta)
%RNSE function
%
%          
%   X:dataset d*n each column is a data point
%   clusnum: number of clusters
%   alpha,beta:parameters

%   W:n*n
%   S:n*n
%   P:c*n
%   diag:n*1
%   I:n*1

issymmetric=1;
[~, n] = size(X);
W=(constructW_PKN(X,10,issymmetric));
W1=exp(-1*W);
W1(W1==1)=0.0;
oneeye=eye(n,n);
W=oneeye+W1;
I=ones(n,1);
P=rand(clusnum,n);
maxiteration=100;
for i=1:maxiteration
    tempppt=W+beta*(P'*P);
    T=(0.5/alpha)*((tempppt)-diag(tempppt)*I');
    S=constructS(T,n);
    P=constructP(P,S);
    
end

[~, label]=max(P);

end

function [S]=constructS(T,n)
nt=n;
iterationS=50;

S_1=T;
S_2=S_1;
I_1=zeros(nt,nt);
I_2=zeros(nt,nt);
for iss=1:iterationS
    S_1=PC_1(S_2-I_1,nt);
    I_1=S_1-(S_2-I_1);
    S_2=PC_2(S_1-I_2);
    I_2=S_2-(S_1-I_2);
end
S=S_2;
end
function [s1]=PC_1(s01,nt)
ns01=nt;
all_1=ones(ns01,ns01);
one_1=ones(ns01,1);
temps01=s01*one_1;
s1=s01+(((one_1'*temps01)*one_1)*one_1'/(ns01*ns01))+(1.0/ns01)*all_1'-(1.0/ns01)*(temps01)*one_1'-(1.0/ns01)*one_1*(one_1'*s01);

end
function [s2]=PC_2(s02)
s02(s02<0.0)=0.0;
s2=s02;
end
function [P]=constructP(P0,S)
miu=0.9;
lambda=0.5;
iterationP=50;
for ip=1:iterationP
    temp1=P0*(S+S')+2.0*P0;
    temp2=(temp1*P0')*P0;
    %temp3=temp2;
    %temp3(temp3==0)=10;
    %mint2=min(min(temp3))*1e-9;
    P0=P0.*((1-lambda+lambda*(temp1./temp2+eps)).^miu);
end
P=P0;
end

% construct similarity matrix with probabilistic k-nearest neighbors. It is a parameter free, distance consistent similarity.
function W = constructW_PKN(X, k, issymmetric)
% X: each column is a data point
% k: number of neighbors
% issymmetric: set W = (W+W')/2 if issymmetric=1
% W: similarity matrix

if nargin < 3
    issymmetric = 1;
end;
if nargin < 2
    k = 5;
end;

[dim, n] = size(X);
D = L2_distance_1(X, X);

[dumb, idx] = sort(D, 2); % sort each row

W = zeros(n);
for i = 1:n
    id = idx(i,2:k+2);
    di = D(i, id);
    W(i,id) = (di(k+1)-di)/(k*di(k+1)-sum(di(1:k))+eps);
end;

if issymmetric == 1
    W = (W+W')/2;
end;

end


% compute squared Euclidean distance
% ||A-B||^2 = ||A||^2 + ||B||^2 - 2*A'*B
function d = L2_distance_1(a,b)
% a,b: two matrices. each column is a data
% d:   distance matrix of a and b



if (size(a,1) == 1)
  a = [a; zeros(1,size(a,2))]; 
  b = [b; zeros(1,size(b,2))]; 
end

aa=sum(a.*a); 
bb=sum(b.*b);
ab=a'*b; 
d = repmat(aa',[1 size(bb,2)]) + repmat(bb,[size(aa,2) 1]) - 2*ab;

d = real(d);
d = max(d,0);

% % force 0 on the diagonal? 
% if (df==1)
%   d = d.*(1-eye(size(d)));
end