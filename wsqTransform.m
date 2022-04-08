function [LL,  LH, HL, HH] = wsqTransform(A)
%wsqTransform Performs a discrete wavelet transformation on the
% matrix a.
%   The Wavelet transform is predetermined based on predetermined coefficients.

% Setup
    lp     = [0, 0.0378284555069950, -0.0238494650183800, -0.110624404418420, 0.377402855612650, 0.852698679009400, 0.377402855612650, -0.110624404418420, -0.0238494650183800, 0.0378284555069950];
    hp     = [0, -0.0645388826289380, 0.0406894176095580, 0.418092273222210, -0.788485616405660, 0.418092273222210, 0.0406894176095580, -0.0645388826289380, 0, 0];
   
% Row Extension
[~, m] = size(A);

if mod(m,2) == 0 
    mode = 'sym';
else
    mode = 'symw';
end

B = wextend('addcol', mode, A, 9);

% Row Operations
low  = conv2(B, lp, 'valid');
high = conv2(B, hp, 'valid');

% Row Downscale
low  = low(:,2:2:end);
high = high(:,2:2:end);

% Column Extension
[n, ~] = size(low);

if mod(n,2) == 0 
    mode = 'sym';
else
    mode = 'symw';
end

low  = wextend('addrow', mode, low, 9);
high = wextend('addrow', mode, high, 9);

% Column Operations
hh = conv2(high', hp, 'valid')';
hl = conv2(high', lp, 'valid')';
lh = conv2(low', hp, 'valid')';
ll = conv2(low', lp, 'valid')';

% Column Downscale
HH  = hh(2:2:end,:);
HL = hl(2:2:end,:);
LH  = lh(2:2:end,:);
LL = ll(2:2:end,:);

end

