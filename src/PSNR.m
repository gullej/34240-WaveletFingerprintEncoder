function [PSNR, MSE] = PSNR(A,B)
A = A/max(A);
B = B/max(B);
if A==B
    error('Images are identical; PSNR is undefined')
end
max2_A=max(max(A)); max2_B=max(max(B));
min2_A=min(min(A)); min2_B=min(min(B));
if max2_A>1 || max2_B>1 || min2_A<0 || min2_B<0
    error('pixels must be in [0,1]')
end
differ=A-B;
MSE = mean(mean(differ.^2));
PSNR=20*log10(1/(sqrt(MSE)));
end

