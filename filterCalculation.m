%% Filter calculation
clc; clearvars; close all;

lowpass = [0 0.037828455506995 -0.023849465018380 -0.11062440441842 0.37740285561265 0.8526986790094 0.37740285561265 -0.11062440441842 -0.02384946501838 0.037828455506995];
lowpass_inv = [0 -0.064538882628938 0.040689417609558 0.41809227322221 0.78848561640566 0.41809227322221 0.040689417609558 -0.064538882628938 0 0];

[LoD, HiD, LoR, HiR] = wfilters('bior4.4');

highpass = zeros(size(lowpass));
highpass_inv = zeros(size(lowpass_inv));

n = [0 -4:4];
for i = 1:size(n,2)
    highpass(i) = (-1)^(n(i)) * lowpass_inv(i);
    highpass_inv(i) = (-1)^(n(i)-1) * lowpass(i);
end

[LoD; lowpass; HiD; lowpass_inv; LoR; highpass; HiR; highpass_inv]

%[lowpass; lowpass_inv; highpass; highpass_inv]
% [LoD;  LoR; HiD; HiR] - [lowpass; lowpass_inv; highpass; highpass_inv];