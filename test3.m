% Test of WSQ
close all; clearvars; clc;

files = dir('DB1_B/*.tif');

for bpp = 3:8
    values = [];
    for file = files'
        img = imread(strcat('DB1_B/',file.name));
        [psnr, len, bit, mse, per, rate] = evaluateCompression(img, bpp);
        values = [values ; psnr, len, bit, mse, per, rate];
    end

    S{bpp} = struct("psnr", values(:,1), "len", values(:,2), "bpp", values(:,3), "mse", values(:,4), "per", values(:,5), "rate", values(:,6));
end

%%
psnr_mean = [];
psnr = [];
len_mean = [];
bpp_mean = [];
mse_mean = [];
per_mean = [];
rate_mean = [];

for i = 3:8
    psnr_mean = [psnr_mean mean(S{i}.psnr)];
    psnr = [psnr (S{i}.psnr)];
    len_mean = [len_mean mean(S{i}.len)];
    bpp_mean = [bpp_mean mean(S{i}.bpp)];
    mse_mean = [mse_mean mean(S{i}.mse)];
    per_mean = [per_mean mean(S{i}.per)];
    rate_mean = [rate_mean mean(S{i}.rate)];
end


%%
close all; clc;
hold on
yyaxis left
ylabel('Mean PSNR (dB)')
plot(3:8, psnr_mean)
yyaxis right
ylabel('Mean code length (bits)')
plot(3:8, len_mean)
xlabel('Compression level')

%%
close all; clc;
hold on
yyaxis left
ylabel('Mean PSNR (dB)')
plot(3:8, psnr_mean)
yyaxis right
ylabel('Mean bits per pixel (bits)')
plot(3:8, bpp_mean)
xlabel('Compression level')

%%
close all; clc;
boxplot(psnr,3:8)
ylabel('Mean PSNR (dB)')
xlabel('Compression level')


%%
close all; clc;
boxplot(psnr(:,2:end,:),4:8)
ylabel('PSNR (db)')
xlabel('BPP')