clc; clear; close all;
load('USPS.mat')

p_vec = [10 50 100 200];        % number of selected feature
X = A;
cv = cov(X);   % covariance matrix
[U,S,V] = svd(cv);

for cnt = 1:length(p_vec)
    p = p_vec(cnt);
    xb = X*V(:,1:p)*V(:,1:p)';  % reconstructed image
    error(cnt) = norm(X-xb,'fro');
    img1 = reshape(xb(1,:), 16, 16);
    img2 = reshape(xb(500,:), 16, 16);
    
    subplot(length(p_vec),2,2*cnt-1);
    imshow(img1')
    title(['p = ' num2str(p)])
    subplot(length(p_vec),2,2*cnt);
    imshow(img2')
    title(['p = ' num2str(p)])
end

figure
plot(error,p_vec,'-o','LineWidth',2)
xlabel('p')
ylabel('total reconstruction error')
title('total reconstruction error vs number of selected feature')


%%% cov(X):
% for i = 1:256
%     X(:,i) = A(:,i) - mean(A(:,i));
% end
% cov = (X'*X)/(2999);