fp = fopen('out.bin', 'rb');

fractional_bits = 14;

width = fread(fp, 1, 'uint32');
height = fread(fp, 1, 'uint32');

data = reshape(fread(fp, width*height, 'int16'), [width height])/(2^fractional_bits);
% do log1p to get better image
data = log1p(data);

figure; imshow(data,[min(min(data)), max(max(data))]);
colormap("hot")
print("out.png",'-dpng');
