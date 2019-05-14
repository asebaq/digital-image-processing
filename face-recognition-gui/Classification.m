function image = Classification(test, train, imgMean, V, feature)
% 4. Classification (Recognition)
% Subtract the mean
p = test - imgMean;
s = single(p)'*V;
z = zeros(1, size(train,2));
for i = 1:size(train,2)
    z(i) = norm(feature(i,:)-s, 2);
end

[a,i] = min(z);
image = reshape(train(:,i),112,92);
