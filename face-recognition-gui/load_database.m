function out = load_database()
% We load the database the first time we run the program.

persistent loaded;
persistent w;
if(isempty(loaded))
    v = zeros(10304,400);
    for i = 1:40
        cd(strcat('orl_faces\s',num2str(i)));
        for j = 1:10
            a = imread(strcat(num2str(j),'.pgm'));
            v(:,(i-1)*10+j) = reshape(a,size(a,1)*size(a,2),1);
        end
        cd ..
        cd ..
    end
    % Convert to unsigned 8 bit numbers to save memory. 
    w = uint8(v); 
end
% Set 'loaded' to aviod loading the database again.
loaded = 1;   
out = w;