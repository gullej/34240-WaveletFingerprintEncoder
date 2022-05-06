% Test of WSQ
close all; clearvars; clc;

files = dir('DB1_B/*.tif');
values = [];
names = [];


for i = 3:8
    j = 1;
    for file = files'
        img = imread(strcat('DB1_B/',file.name));
        [psnr, len, bpp, mse, per, rate] = evaluateCompression(img, i);
        values = [values ; psnr, len, bpp, mse, per, rate];
        j = j + 1;
    end

    S{i} = struct("psnr", values(:,1), "len", values(:,2), "bpp", values(:,3), "mse", values(:,4), "per", values(:,5), "rate", values(:,6));
end

