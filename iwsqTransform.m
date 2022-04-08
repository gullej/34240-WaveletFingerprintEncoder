function A = iwsqTransform(LL,  LH, HL, HH)
%iwsqTransform Performs an inverse discrete wavelet transformation on the
% four input matrices LL,  LH, HL, HH.
%   The Wavelet transform is predetermined based on predetermined coefficients.

% Setup
    lp_inv = [0, -0.0645388826289380, -0.0406894176095580, 0.418092273222210, 0.788485616405660, 0.418092273222210, -0.0406894176095580, -0.0645388826289380, 0, 0];
    hp_inv  = [0, -0.0378284555069950, -0.0238494650183800, 0.110624404418420, 0.377402855612650, -0.852698679009400, 0.377402855612650, 0.110624404418420, -0.0238494650183800, -0.0378284555069950];

% Determine extension mode
[~, m] = size(LL);

if mod(m,2) == 0 
    mode = 'sym';
else
    mode = 'symw';
end
    
% Subband Synthesis
A = iwsqInternal(LL, lp_inv, lp_inv, mode) + ...
    iwsqInternal(LH, lp_inv, hp_inv, mode) + ...
    iwsqInternal(HL, hp_inv, lp_inv, mode) + ...
    iwsqInternal(HH, hp_inv, hp_inv, mode);
  
end

% --------------------------- %
%      Internal Function      %
% --------------------------- %

function y = iwsqInternal(x, f1, f2, mode)
    a = dyadup(x,'col',1);
    b = wextend('addcol', mode, a, 9);
    c  = conv2(b, f1, 'valid');
    d = dyadup(c,'row',1);
    e  = wextend('addrow', mode, d, 9);
    f = conv2(e', f2, 'valid')';
    y= f(9+1:end-9, 9+1:end-9);
end


