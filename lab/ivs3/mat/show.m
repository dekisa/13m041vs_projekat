fp = fopen('lena256.bin','rb');
I = uint8(reshape(fread(fp),[256 256])');
fclose(fp);

fp = fopen('lena256.bin.out','rb');
I1 = uint8(reshape(fread(fp),[256 256])');
fclose(fp);

figure;
subplot(2,2,1);
imshow(I);
subplot(2,2,2);
imshow(I1);