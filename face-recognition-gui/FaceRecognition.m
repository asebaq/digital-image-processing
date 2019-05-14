% Face recognition
% This algorithm uses the eigenface system (based on pricipal component
% analysis)
function [test, train, imgMean, V, feature] = FaceRecognition( index )
% Loading the database 
dataBase = LoadDatabase();

% 1. Data acquisition
% Randomly pick an image from our database and use the rest of the
% images for training. Training is done on 399 pictues. We later
% use the randomly selectted picture to test the algorithm.

% Randomly pick an index
randImage = index;

% Image later on will be used to test the algorithm
test = dataBase(:, randImage);
% The rest of the 399 images for training
train = dataBase(:, [1:randImage-1 randImage+1:end]);

% 2. Preprocessing
% Number of features used for each image
NF = 300;
% Subtracting the mean from train
% The maen of all images
imgMean = uint8(mean(train, 2));
% train with the mean removed
tzmr = train - uint8(single(imgMean)*single(uint8(ones(1, size(train, 2)))));   

% 3. Feature Extraction
% Calculating eignevectors of the correlation matrix(sigma)(aka covariance matrix)
% We are picking N of the 400 eigenfaces
sigma = single(tzmr)'*single(tzmr);
[V, D] = eig(sigma);
% [U S V] = svd(L);
V = single(tzmr)*V;
% Pick the eignevectors corresponding to the 300 largest eigenvalues
V = V(:, end:-1:end-(NF-1));


% Calculating the features for each image
feature = zeros(size(train,2), NF);
for i = 1:size(train, 2)
    % Row of feature for one image
    feature(i, :) = single(tzmr(:, i))'*V;    
end
