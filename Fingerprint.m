%% Transform
% decompose
clc 
clear
dwtmode('sym')
pic = imread('110_8.tif');
pic = double(pic);
[c,d] = size(pic);
[LL,LH,HL,HH] = dwt2(pic,'bior 4.4');
filter = wfilters('bior 4.4');
[LL1,LH1,HL1,HH1] = dwt2(LL,'bior 4.4'); % left up corner
[LL2,LH2,HL2,HH2] = dwt2(HL,'bior 4.4');% right up corner
[LL3,LH3,HL3,HH3] = dwt2(LH,'bior 4.4');% left buttom corner
[LL4,LH4,HL4,HH4] = dwt2(HH,'bior 4.4');% right buttom corner

[LL1_lu,LL1_lb,LL1_ru,LL1_rb] = dwt2(LL1,'bior 4.4');
[HL1_lu,HL1_lb,HL1_ru,HL1_rb] = dwt2(HL1,'bior 4.4');
[LH1_lu,LH1_lb,LH1_ru,LH1_rb] = dwt2(LH1,'bior 4.4');

[LL1_lulu,LL1_lulb,LL1_luru,LL1_lurb] = dwt2(LL1_lu,'bior 4.4');
[LL1_lblu,LL1_lblb,LL1_lbru,LL1_lbrb] = dwt2(LL1_lb,'bior 4.4');
[LL1_rulu,LL1_rulb,LL1_ruru,LL1_rurb] = dwt2(LL1_ru,'bior 4.4');
[LL1_rblu,LL1_rblb,LL1_rbru,LL1_rbrb] = dwt2(LL1_rb,'bior 4.4');

[HL1_lulu,HL1_lulb,HL1_luru,HL1_lurb] = dwt2(HL1_lu,'bior 4.4');
[HL1_lblu,HL1_lblb,HL1_lbru,HL1_lbrb] = dwt2(HL1_lb,'bior 4.4');
[HL1_rulu,HL1_rulb,HL1_ruru,HL1_rurb] = dwt2(HL1_ru,'bior 4.4');
[HL1_rblu,HL1_rblb,HL1_rbru,HL1_rbrb] = dwt2(HL1_rb,'bior 4.4');

[LH1_lulu,LH1_lulb,LH1_luru,LH1_lurb] = dwt2(LH1_lu,'bior 4.4');
[LH1_lblu,LH1_lblb,LH1_lbru,LH1_lbrb] = dwt2(LH1_lb,'bior 4.4');
[LH1_rulu,LH1_rulb,LH1_ruru,LH1_rurb] = dwt2(LH1_ru,'bior 4.4');
[LH1_rblu,LH1_rblb,LH1_rbru,LH1_rbrb] = dwt2(LH1_rb,'bior 4.4');

[LL1_lululu,LL1_lululb,LL1_luluru,LL1_lulurb] = dwt2(LL1_lulu,'bior 4.4');
imshow(LL1_lululu,[min(min(LL1_lululu)), max(max(LL1_lululu))])

%% Compose
recover_LL1_lulu = idwt2(LL1_lululu, LL1_lululb,LL1_luluru, LL1_lulurb,'bior 4.4');
recover_LL1_lu = idwt2(recover_LL1_lulu, LL1_lulb,LL1_luru, LL1_lurb,'bior 4.4');
recover_LL1_lb = idwt2(LL1_lblu,LL1_lblb,LL1_lbru,LL1_lbrb,'bior 4.4');
recover_LL1_ru = idwt2(LL1_rulu,LL1_rulb,LL1_ruru,LL1_rurb,'bior 4.4');
recover_LL1_rb = idwt2(LL1_rblu,LL1_rblb,LL1_rbru,LL1_rbrb,'bior 4.4');
recover_LL1 = idwt2(recover_LL1_lu(1:67,1:87),recover_LL1_lb(1:67,1:87),recover_LL1_ru(1:67,1:87),recover_LL1_rb(1:67,1:87),'bior 4.4');

recover_LH1_lu = idwt2(LH1_lulu,LH1_lulb,LH1_luru,LH1_lurb,'bior 4.4');
recover_LH1_lb = idwt2(LH1_lblu,LH1_lblb,LH1_lbru,LH1_lbrb,'bior 4.4');
recover_LH1_ru = idwt2(LH1_rulu,LH1_rulb,LH1_ruru,LH1_rurb,'bior 4.4');
recover_LH1_rb = idwt2(LH1_rblu,LH1_rblb,LH1_rbru,LH1_rbrb,'bior 4.4');
recover_LH1 = idwt2(recover_LH1_lu(1:67,1:87),recover_LH1_lb(1:67,1:87),recover_LH1_ru(1:67,1:87),recover_LH1_rb(1:67,1:87),'bior 4.4');

recover_HL1_lu = idwt2(HL1_lulu,HL1_lulb,HL1_luru,HL1_lurb,'bior 4.4');
recover_HL1_lb = idwt2(HL1_lblu,HL1_lblb,HL1_lbru,HL1_lbrb,'bior 4.4');
recover_HL1_ru = idwt2(HL1_rulu,HL1_rulb,HL1_ruru,HL1_rurb,'bior 4.4');
recover_HL1_rb = idwt2(HL1_rblu,HL1_rblb,HL1_rbru,HL1_rbrb,'bior 4.4');
recover_HL1 = idwt2(recover_HL1_lu(1:67,1:87),recover_HL1_lb(1:67,1:87),recover_HL1_ru(1:67,1:87),recover_HL1_rb(1:67,1:87),'bior 4.4');

recover_LL = idwt2(recover_LL1,recover_LH1,recover_HL1,HH1,'bior 4.4');

recover_HL = idwt2(LL2,LH2,HL2,HH2,'bior 4.4');
recover_LH = idwt2(LL3,LH3,HL3,HH3,'bior 4.4');
recover_HH = idwt2(LL4,LH4,HL4,HH4,'bior 4.4');

recover_pic = idwt2(recover_LL,recover_LH,recover_HL,recover_HH,'bior 4.4');
imshow(recover_pic,[min(min(recover_pic)), max(max(recover_pic))])
%% Quantization
% Qk is quantization interval
% Assign numbers to all the blocks
subband{1} = LL1_lululu;subband{2} = LL1_luluru;subband{3} = LL1_lululb;subband{4} = LL1_lulurb;
subband{5} = LL1_luru;subband{6} = LL1_lulb;subband{7} = LL1_lurb;subband{8} = LL1_rulu;
subband{9} = LL1_ruru;subband{10} = LL1_rulb;subband{11} = LL1_rurb;subband{12} = LL1_lblu; 
subband{13} = LL1_lbru;subband{14} = LL1_lblb;subband{15} = LL1_lbrb;subband{16} = LL1_rblu; 
subband{17} = LL1_rbru;subband{18} = LL1_rblb;subband{19} = LL1_rbrb;subband{20} = LH1_lulu;
subband{21} = LH1_luru;subband{22} = LH1_lulb;subband{23} = LH1_lurb;subband{24} = LH1_rulu;
subband{25} = LH1_ruru;subband{26} = LH1_rulb;subband{27} = LH1_rurb;subband{28} = LH1_lblu;
subband{29} = LH1_lbru;subband{30} = LH1_lblb;subband{31} = LH1_lbrb;subband{32} = LH1_rblu;
subband{33} = LH1_rbru;subband{34} = LH1_rblb;subband{35} = LH1_rbrb;subband{36} = HL1_lulu;
subband{37} = HL1_luru;subband{38} = HL1_lulb;subband{39} = HL1_lurb;subband{40} = HL1_rulu;
subband{41} = HL1_ruru;subband{42} = HL1_rulb;subband{43} = HL1_rurb;subband{44} = HL1_lblu;
subband{45} = HL1_lbru;subband{46} = HL1_lblb;subband{47} = HL1_lbrb;subband{48} = HL1_rblu;
subband{49} = HL1_rbru;subband{50} = HL1_rblb;subband{51} = HL1_rbrb;subband{52} = HH1;
subband{53} = LL2;subband{54} = HL2;subband{55} = LH2;subband{56} = HH2;
subband{57} = LL3;subband{58} = HL3;subband{59} = LH3;subband{60} = HH3;
subband{61} = LL4;subband{62} = HL4;subband{63} = LH4;subband{64} = HH4;
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

%% Python code that hasn't finished converting -- Calculating value q is hard, might need to work on later
% For getting the really Qk, I need to find out quantization factor q first
j = 1;
for i = (1:64)
    if (Q(i) ~= 0)
       K(j) = i;
    end
end

% K = [k for k in range(64) if Q[k]!=0]
% z = [(np.sqrt(variances[k])/Q[k])**(1/2**(len(filter_bank_path[k])*2)) for k in K]
% xi = [k for k in K if Q[k]/min(1e300,q) >= 2 * 2.25 * np.sqrt(variances[k])]
% remaining_k = [k for k in K if k not in xi];

% S = np.sum([1/2**(len(filter_bank_path[k])*2) for k in K])
%         
% q = 1/2.5 * 2**(bpp/S-1) 
% q *= np.prod(z)**(-1/S)
%Q = Q/q; % Now we got the value of Qk (Qk = Qk'/q)

%% Keep quantizing
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

%% Huffman coding
% Firstly, put all the values in p into a sequence by using raster scan
% c and d are the size of the input pic
p_sequence = zeros(1,c*d);
j = 1;
for i = 1 : 64
    [a,b] = size(p{i});
    for i1 = 1 : a
        for j1 = 1 : b
              p_sequence(j) = p{i}(i1,j1);
              j = j + 1;
        end
    end
end

uni = unique(p_sequence); % Get all the unique values from p_sequence
for i = 1:length(uni)
    count = find(p_sequence == uni(i));
    sumcount = sum(count);
    frequency(i) = sumcount/length(p_sequence); % count frequency for each unique value
end
% sum all the frequencies
freq_sum = sum(frequency) ;
% calculate the frequency of each pixel
probability = frequency ./ freq_sum ;
% create a dictionary
dict = huffmandict(uni,probability);
% encoding
encodedseq = huffmanenco(p_sequence,dict);

%% Huffman decoding
decodedseq = huffmandeco(encodedseq,dict);
decodedseq = [decodedseq zeros(1,288773)];
count = 1;
for i = 1:4
    for i1 = 1:a1
        for j1 = 1:b1
            p_recover{i}(i1,j1) = decodedseq(count);
            count = count + 1;
        end
    end
end
for i = 5:51
   for i1 = 1:a2
        for j1 = 1:b2
            p_recover{i}(i1,j1) = decodedseq(count);
            count = count + 1;
        end
    end
end
for i = 52:64
   for i1 = 1:a3
        for j1 = 1:b3
            p_recover{i}(i1,j1) = decodedseq(count);
            count = count + 1;
        end
    end
end
%% Dequantization

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
%% Quantization - Compose
qrecover_LL1_lulu = idwt2(a_hat{1}, a_hat{3},a_hat{2}, a_hat{4},'bior 4.4');
qrecover_LL1_lu = idwt2(qrecover_LL1_lulu, a_hat{6},a_hat{5}, a_hat{7},'bior 4.4');
qrecover_LL1_lb = idwt2(a_hat{12},a_hat{14},a_hat{13},a_hat{15},'bior 4.4');
qrecover_LL1_ru = idwt2(a_hat{8},a_hat{10},a_hat{9},a_hat{11},'bior 4.4');
qrecover_LL1_rb = idwt2(a_hat{16},a_hat{18},a_hat{17},a_hat{19},'bior 4.4');
qrecover_LL1 = idwt2(qrecover_LL1_lu(1:67,1:87),qrecover_LL1_lb(1:67,1:87),qrecover_LL1_ru(1:67,1:87),qrecover_LL1_rb(1:67,1:87),'bior 4.4');

qrecover_LH1_lu = idwt2(a_hat{20},a_hat{22},a_hat{21},a_hat{23},'bior 4.4');
qrecover_LH1_lb = idwt2(a_hat{28},a_hat{30},a_hat{29},a_hat{31},'bior 4.4');
qrecover_LH1_ru = idwt2(a_hat{24},a_hat{26},a_hat{25},a_hat{27},'bior 4.4');
qrecover_LH1_rb = idwt2(a_hat{32},a_hat{34},a_hat{33},a_hat{35},'bior 4.4');
qrecover_LH1 = idwt2(qrecover_LH1_lu(1:67,1:87),qrecover_LH1_lb(1:67,1:87),qrecover_LH1_ru(1:67,1:87),qrecover_LH1_rb(1:67,1:87),'bior 4.4');

qrecover_HL1_lu = idwt2(a_hat{36},a_hat{38},a_hat{37},a_hat{39},'bior 4.4');
qrecover_HL1_lb = idwt2(a_hat{44},a_hat{46},a_hat{45},a_hat{47},'bior 4.4');
qrecover_HL1_ru = idwt2(a_hat{40},a_hat{42},a_hat{41},a_hat{43},'bior 4.4');
qrecover_HL1_rb = idwt2(a_hat{48},a_hat{50},a_hat{49},a_hat{51},'bior 4.4');
qrecover_HL1 = idwt2(qrecover_HL1_lu(1:67,1:87),qrecover_HL1_lb(1:67,1:87),qrecover_HL1_ru(1:67,1:87),qrecover_HL1_rb(1:67,1:87),'bior 4.4');

qrecover_LL = idwt2(qrecover_LL1,qrecover_LH1,qrecover_HL1,a_hat{52},'bior 4.4');

qrecover_HL = idwt2(a_hat{53},a_hat{55},a_hat{54},a_hat{56},'bior 4.4');
qrecover_LH = idwt2(a_hat{57},a_hat{59},a_hat{58},a_hat{60},'bior 4.4');
qrecover_HH = idwt2(a_hat{61},a_hat{63},a_hat{62},a_hat{64},'bior 4.4');

qrecover_pic = idwt2(qrecover_LL,qrecover_LH,qrecover_HL,qrecover_HH,'bior 4.4');
imshow(qrecover_pic,[min(min(qrecover_pic)), max(max(qrecover_pic))])
