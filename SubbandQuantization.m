function [p,Q,Z,a1,b1,a2,b2,a3,b3] = SubbandQuantization(subband)
% Qk is quantization interval
% Assign numbers to all the blocks
A = ones(1,64);% building the A array
A(52) = 1.32;
A(56) = 1.32;
A(53) = 1.08;
A(58) = 1.08;
A(54) = 1.42;
A(57) = 1.42;
A(55) = 1.08;
A(59) = 1.08;
Q = zeros(1,64);% building the Q array
variance = zeros(1,60);% building the variance array
% bin width Qk and Zk from the variances of the transform coefficients
%subtract = 0;
%uk = 0; % uk denotes the mean of ak (m,n) in the region.
for i = 1:4
    uk = 0; % uk denotes the mean of ak (m,n) in the region.
    subtract = 0;
    [a,b] = size(subband{i});
    Xk = a;Yk = b;
    x = floor(3*Xk/4); %Width of subregion [for variance]Xk'
    y = floor(7*Yk/16); %Height of subregion [for variance]Yk'
    x_0 = floor(Xk/8);
    X1k = x_0 + x - 1;
    y_0 = floor(9*Yk/32);
    Y1k = y_0 + y - 1;
    for i1 = 1:a
        for j1 = 1:b
        uk = subband{i}(i1,j1) + uk;
        end
    end
    uk = uk/(a*b); % Average value in a subband
    for i1 = round(x_0):round(X1k)
        for j1 = round(y_0):round(Y1k)
            subtract = (subband{i}(i1,j1) - uk)^2 + subtract;
        end
    end
    variance(i) = subtract/(x*y-1); % calculation of variance
end
Q(1:4) = 1; % Calculation of Qk' (Qk' = q*Qk)
for i = 5:60
    uk = 0; % uk denotes the mean of ak (m,n) in the region.
    subtract = 0;
    [a,b] = size(subband{i});
    Xk = a;Yk = b;
    x = floor(3*Xk/4); %Width of subregion [for variance]Xk'
    y = floor(7*Yk/16); %Height of subregion [for variance]Yk'
    x_0 = floor(Xk/8);
    X1k = x_0 + x - 1;
    y_0 = floor(9*Yk/32);
    Y1k = y_0 + y - 1;
    for i1 = 1:a
        for j1 = 1:b
        uk = subband{i}(i1,j1) + uk;
        end
    end
    uk = uk/(a*b);
    for i1 = round(x_0):round(X1k)
        for j1 = round(y_0):round(Y1k)
            subtract = (subband{i}(i1,j1) - uk)^2 + subtract;
        end
    end
    variance(i) = subtract/(x*y-1); % calculation of variance
    if variance(i) < 1.01
        Q(i) = 0;
    else
        Q(i) = 10/(A(i)*log(variance(i))); % Calculation of Qk' (Qk' = q*Qk)
    end
end
Q(60:64) = 0;

% Python code that hasn't finished converting -- Calculating value q is hard, might need to work on later
% For getting the really Qk, I need to find out quantization factor q first
% j = 1;
% for i = (1:64)
%     if (Q(i) ~= 0)
%         K(j) = i;
%     end
% end

% K = [k for k in range(64) if Q[k]!=0]
% z = [(np.sqrt(variances[k])/Q[k])**(1/2**(len(filter_bank_path[k])*2)) for k in K]
% xi = [k for k in K if Q[k]/min(1e300,q) >= 2 * 2.25 * np.sqrt(variances[k])]
% remaining_k = [k for k in K if k not in xi];

% S = np.sum([1/2**(len(filter_bank_path[k])*2) for k in K])
%         
% q = 1/2.5 * 2**(bpp/S-1) 
% q *= np.prod(z)**(-1/S)
%Q = Q/q; % Now we got the value of Qk (Qk = Qk'/q)

Z = 1.2 * Q; % The width of the zero bin
[a1,b1] = size(subband{1});
[a2,b2] = size(subband{5});
[a3,b3] = size(subband{52});
% Actual quantization
for i = 1:64
    if (i <= 4)
        p{i} = zeros(a1,b1);% P should be the same size as the input block
    elseif ((i > 4) && (i <= 51))
        p{i} = zeros(a2,b2);
    else
        p{i} = zeros(a3,b3);
    end
end
for i = 1:64 % The number of subband
    [a,b] = size(subband{i});
    if (Q(i) ~= 0)
        for i1 = 1 : a
            for j1 = 1 : b
                if (subband{i}(i1,j1)) > (Z(i)/2)
                    p{i}(i1,j1) = floor((subband{i}(i1,j1) - (Z(i)/2))/Q(i)) + 1;
                elseif(subband{i}(i1,j1)) < (-1)*(Z(i)/2)
                    p{i}(i1,j1) = ceil((subband{i}(i1,j1) + (Z(i)/2))/Q(i)) - 1;   
                else
                    p{i}(i1,j1) = 0;
                end
            end
        end
    else
        p{i} = zeros(a,b); % p contains all the coefficients after quantization
    end
end
end

