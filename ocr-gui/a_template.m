% Create template for the character A
character = imresize(imread('letter_A\A.bmp'),  [42 42]); 

% Template of characters
atemplate = mat2cell(character,42,42);
save ('atemplate','atemplate')
