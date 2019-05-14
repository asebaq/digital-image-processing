function bit_slice(gray_img)

[row, col] = size(gray_img);

% pre-allocation (for speed purposes)
bit_planes = zeros(row, col,8);
bit_layers = zeros(row, col,8);

% extract each bit plane
for i = 1:8
    bit_planes(:,:,i) = bitget(gray_img,i);
    % create layers, by adding a bit plane to another 
    for j = 1:i
        bit_layers(:,:,i) = bitset(bit_layers(:,:,i),9-j,bitget(gray_img,9-j));
    end
end

% show images
% one bit plane at a time
for i = 1:8
    subplot(2,4,i), imshow(logical(bit_planes(:,:,i)));title(['Bit-plane ',num2str(i)]);
end

% one layer at a time
figure
for i = 1:8
    subplot(2,4,i), imshow(uint8(bit_layers(:,:,i)));title([num2str(i),' bit-plane']);
end
end

