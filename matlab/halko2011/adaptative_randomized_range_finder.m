function Q = adaptative_randomized_range_finder(A ,L, tol, r)
%% ADAPTATIVE_RANDOMIZED_RANGE_FINDER is algo 4.2 of the reference below. 
% This algorithm compute an orthonormal matrix Q such that |(I-QQ')A| < tol. 
%
%
% Inputs :
%   - A : Either matrix or matrix operator.
%   - L : the length of the signal 
%   - tol : the precision with which the approximate base Q for the range of A 
%           is constructed.   
%   - r: integer
% Output:   
%    - Q : an Orthonormal matrix. The columns of Q are orthonormal
%
% REFERENCES:
%
%  Nathan Halko, Per-Gunnar Martinsson, Joel A. Tropp, "Finding structure
%  with randomness: Probabilistic algorithms for constructing approximate
%  matrix decompositions", 2011.
%
% Author : A. Marina KREME
% e-mail : ama-marina.kreme@lis-lab.fr/ama-marina.kreme@univ-amu.fr
% Created: 2020-28-01
%%

if nargin ==3
    r=10;
end

if nargin==2
    tol=10^(-6);
end

Omega = randn(L, r);

 m=L;


Y = zeros(m,r);
for i =1:r
    yi = A(Omega(:,i));
    Y(:,i)=Y(:,i)+yi;
end

y_norms = zeros(1,r);
for k =1:r
    ni = norm(Y(:,k),2);
    y_norms(k)=ni;
end

max_norms = max(y_norms);
j=0;
Qj= zeros(m,0);

while max_norms >tol/(10*sqrt(2/pi))
    j=j+1;
    
    Y(:,j) = Y(:,j)-Qj*(Qj'*Y(:,j));
    
    qj = Y(:,j)/norm(Y(:,j),2);
    Qj = [Qj qj];
    
    new_Omega = randn(L,1);
    
    Aw = A(new_Omega);
    y_n = Aw - Qj*(Qj'*Aw);
    
    Y = [Y y_n];
    y_norms = [y_norms norm(y_n,2)];
        
    for i =j+1:j+r-1
        Y(:,i) = Y(:,i)- qj*(qj'*Y(:,i));
        y_norms(i)=norm(Y(:,i),2);
    end
    max_norms = max(y_norms(j+1: end));
end

Q = Qj;

end