function out = LoadDatabase()
% Load database the first time we run the program
persistent isLoaded;
persistent dataBase;

if(isempty(isLoaded))
    dataVector = zeros(10304,400);
    for i = 1:40
        cd(strcat('data\s',num2str(i)));
        for j = 1:10
            img = imread(strcat(num2str(j),'.pgm'));
            dataVector(:,(i-1)*10+j) = reshape(img,size(img,1)*size(img,2),1);
        end
        cd ..
        cd ..
    end
    % Convert to unsigned 8 bit numbers to save memory
    dataBase = uint8(dataVector); 
end
% Set 'isLoaded' to aviod loading the database again
isLoaded = 1;   
out = dataBase;