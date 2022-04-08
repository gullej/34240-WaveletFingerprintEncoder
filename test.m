img = imread('DB1_B/110_8.tif');
mode = 'symw';
filter = 'bior4.4';

[a, b, c, d] = dwt2(img, filter, mode);
[w, x, y, z] = wsqTransform(img);

subplot(1,2,1);
imshow([a b; c d], [0 255]);
subplot(1,2,2);
imshow([w x; y z], [0 255]);

immse([a b; c d], [w x; y z])

A = idwt2(a, b, c, d, filter, mode);
B = iwsqTransform(w, x, y, z);

clf
subplot(1,3,1);
imshow(img);
subplot(1,3,2);
imshow(uint8(A));
subplot(1,3,3);
imshow(uint8(B));

immse(img, uint8(A))
immse(img, uint8(B))