% Find permutation matrix to match columns of B to columns of A to minimize
% their ell_2 norm.
%
% Coded by: Jason Parker, The Ohio State Univ.
% E-mail: vilaj@ece.osu.edu
% Last change: 1/9/15
% Change summary: 
%   v 1.0 (JV)- First release
%
% Version 1.0
function Q = find_perm(A,B)

%find_permutation uses a greedy method to find the scaled permutation 
%matrix Q that minimizes ||A - BQ||


%Number of columns
N = size(A,2);

%First, normalize the columns of A
columnNormsA = sqrt(diag(A'*A));
Amat = A*diag(1 ./ columnNormsA); %unit norm columns

%Now, normalize the columns of B
columnNormsB = sqrt(diag(B'*B));
Bmat = B*diag(1 ./ columnNormsB); %unit norm columns

%Compute all inner products
G = Bmat'*Amat;


%Preallocate
Q = zeros(N,N);

%Find the entries using a greedy approach
for kk = 1:N %walk through columns
    
    %Find current largest inner product
    [~,loc] = max(abs(G(:)));
    
    %Determine location in matrix
    [m,n] = ind2sub([N N],loc);
    
    %Set the value in Q
    Q(m,n) = sign(G(m,n));
    
    %Zero out the row/column of G
    G(m,:) = 0;
    G(:,n) = 0;
   
end
