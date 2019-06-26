%% problem 2
load('shoesducks.mat');
% plot(X(12,:));

% split the dataset
trnX = X( 1:72,: );trnY = Y( 1:72,: );
tstX = X( 73:144,: );tstY = Y( 73:144,: );


% classify using linear
[nsv, alpha, b0] = svc(trnX,trnY);
predictedY = svcoutput(trnX,trnY,tstX,'linear',alpha,b0,0);
err = svcerror(trnX,trnY,tstX,tstY,'linear',alpha,b0)


global p1;
% classify using polynomials
d_max = 50;
err_d = zeros( 1,d_max );
for d=1:d_max
    p1 = d;
    % train
    [nsv,alpha,b0] = svc(trnX,trnY,'poly');
    % predict
    predictedY = svcoutput(trnX,trnY,tstX,'poly',alpha,b0);
    % compute test error
    err_d(d)= svcerror(trnX,trnY,tstX,tstY,'poly',alpha,b0);
end
% plot error vs polynomial degree
f = figure(1);
clf(f);
plot( 1:d_max,err_d );
title('polynomial');
print( f,'-depsc','poly.eps' );


% classify using rbfs
sigmas = .1:.1:2;
err_sigma = zeros( 1,numel(sigmas) );
for sigma_i=1:numel(sigmas)
    p1 = sigmas(sigma_i);
    % train
    [ nsv,alpha,bias ]=svc(trnX,trnY,'rbf',inf);
    % predict
    predictedY = svcoutput( trnX,trnY,tstX,'rbf',alpha,bias );
    % compute test error
    err_sigma(sigma_i)= svcerror( trnX,trnY,tstX,tstY,'rbf',alpha,bias );
end
% plot error vs polynomial degree
f2 = figure(2);
clf(f2);
plot(sigmas,err_sigma);
title('RBFs');
print(f2,'-depsc','rbf.eps');


%% problem 3 PCA
load('teapots.mat');

figure(1);
for i=1:10
    subplot(4,5,i);
    imagesc(reshape(teapotImages(10*i,:),38,50));
    colormap gray;
    hold;
end

sigma=cov(teapotImages);
[eigenvector,eigenvalue]=eig(sigma);% columns are the corresponding eigenvectors
%find the principle component
a = sort(max(eigenvalue),'descend');
[~,b]=find(eigenvalue>a(4));% max()is maximum of each column

% top 3 eigenvalues: eigenvalue(:,b(1)) eigenvalue(:,b(2)) eigenvalue(:,b(3))
% show the 3 top eigenvectors of the data covariance matrix
h=figure(2);
for i=1:3
    subplot(2,3,i);
    imagesc(reshape(eigenvector(:,b(i)),38,50));
    colormap gray;
    hold;
end
u = mean( teapotImages,1 );
subplot(2,3,4);
imagesc(reshape(u,38,50));
colormap gray;

% show the reconstructed data
for i=1:10
    reconstruct(:,i)= ( u'+i*eigenvector(:,b(1))+3.3*eigenvector(:,b(2))+(6.7-i)*eigenvector(:,b(3)) );
end

figure(1);
for i=1:10
    subplot(4,5,i+10);
    imagesc(reshape(reconstruct(:,i),38,50));
    colormap gray;
    hold;
end









