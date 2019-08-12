% NOTE: Using only 100 iterations

%sources_filename = 'sources_functional.bin';
%heat_frac_bits = 14;
%input_filename = 'out_functional.bin';
%output_filename = 'out_functional_heat.bin';
sources_filename = 'sources_performance.bin';
heat_frac_bits = 14;
input_filename = 'out_performance.bin';
output_filename = 'out_performance_heat.bin';

% Read sources
fp = fopen(sources_filename, 'rb');
c_x = fread(fp, 1, 'int16')/2^heat_frac_bits;
c_y = fread(fp, 1, 'int16')/2^heat_frac_bits;
nr_srcs = fread(fp, 1, 'uint16');
sources = zeros(nr_srcs, 3);
for i = 1:nr_srcs
    sources(i,1) = fread(fp, 1, 'uint16') + 1;  % xpos
    sources(i,2) = fread(fp, 1, 'uint16') + 1;  % ypos
    sources(i,3) = fread(fp, 1, 'int16')/2^heat_frac_bits;  % heat
end
fclose(fp);

% Read input image
fp = fopen(input_filename, 'rb');
width = fread(fp, 1, 'uint32');
height = fread(fp, 1, 'uint32');
output_image = reshape(fread(fp, width*height, 'int16')/2^heat_frac_bits, [width height]);
fclose(fp);

% Process data
next_data = zeros(width+2);
data = zeros(width+2);

for s = 1:size(sources,1)
    sources(s,1) = sources(s,1) + 1;
    sources(s,2) = sources(s,2) + 1;
    data(sources(s,1), sources(s,2)) = sources(s,3);
end

for it = 1:100
    for j = 2:size(data,1)-1
        for i = 2:size(data,2)-1
            is_source = 0;
            for s = 1:size(sources,1)
                    if (sources(s,1) == i) && (sources(s,2) == j)
                        is_source=1;
                    end
            end
            if is_source
                next_data(i,j) = data(i,j);
            else
                next_data(i,j) = data(i,j) + c_x * (data(i+1,j) + data(i-1,j) - 2*data(i,j)) + c_y * (data(i,j+1) + data(i,j-1) - 2*data(i,j));
            end
        end
    end
    data = next_data;
    %it
    %fflush(stdout);
end

% Compare output and reference image
diff_image = data(2:width+1,2:height+1) - output_image;
figure; imshow(data); title('Reference output image');
figure; imshow(output_image); title('Nios2 output image');
figure; imagesc(diff_image); title('Difference image');

disp(['Maximal abs error: ', num2str(max(abs(diff_image(:))))])
