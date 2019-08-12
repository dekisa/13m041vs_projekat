%fp = fopen('sources_functional.bin', 'wb');
fp = fopen('sources_performance.bin', 'wb');

% KEEP THIS
fractional_bits = 14;

% heat conduction coefficients - update if needed
c_x = 0.2;
c_y = 0.2;

% sources matrix - xpos (col 1), ypos (col 2), heat (col 3)
% functional test
%sources = [[5, 5, 1.0];[50, 10, 0.7];[55, 64, 0.6];[64, 64, 1.0];[100, 120, 0.8]];
% performance test
 sources = [[25, 10, 0.7];[32, 32, 1.0];[50, 60, 0.8]];

% number of sources - must be equal to height of sources matrix
nr_sources = length(sources(:,1));

% convert to fixed point
sources(:,3) = int16(sources(:,3) * 2^fractional_bits);
c_x = int16(c_x * 2^fractional_bits);
c_y = int16(c_y * 2^fractional_bits);

% save data to file sources.bin
data = [c_x, c_y, nr_sources, reshape(sources',1,[])]

fwrite(fp, data', 'uint16');

fclose(fp);
