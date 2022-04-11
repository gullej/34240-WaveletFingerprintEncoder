function [a_hat] = SubbandDequan(p_recover,Q,Z,a1,b1,a2,b2,a3,b3)
for i = 1:64
    if (i <= 4)
        a_hat{i} = zeros(a1,b1);% a_hat should be the same size as the input block
    elseif ((i > 4) && (i <= 51))
        a_hat{i} = zeros(a2,b2);
    else
        a_hat{i} = zeros(a3,b3);
    end
end
C = 0.44; % the reconstructed value for each quantization bin is the center of the bin
for i = 1:64 % The number of subband
    [a,b] = size(p_recover{i});% For reconstraction, we need to use values from previous step
    for i1 = 1 : a
        for j1 = 1 : b
             if (p_recover{i}(i1,j1)) > 0
                 a_hat{i}(i1,j1) = (p_recover{i}(i1,j1) - C)*Q(i) + Z(i)/2;
             elseif(p_recover{i}(i1,j1)) < 0
                 a_hat{i}(i1,j1) = (p_recover{i}(i1,j1) + C)*Q(i) - Z(i)/2; 
             else
                 a_hat{i}(i1,j1) = 0;
             end
        end
    end
end 
end

