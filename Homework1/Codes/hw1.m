%% please use Ctrl + Enter to run the following parts seperately

%% problem 1
clear;
% load feature vectors and label vectors
% and divide them into training sets and testing sets
load('problem1.mat');
x_train = x( 1:400,: ); y_train = y( 1:400,: );
x_test = x( 401:500,: ); y_test = y( 401:500,: );
% use polyreg.m to do polynomial curve fitting
for i=1:9
    [err,model] = polyreg(x_train,y_train,i);
    pause % If the program gets stuck, use Ctrl+c to terminate.
    vpa(model,50)
end
close
% cross-validation
for i=1:40
    [err,model,errT] = polyreg(x_train,y_train,i,x_test,y_test);
    err_train(i)=err; err_test(i)=errT;
    close
end
plot([1:40],err_train,'r',[1:40],err_test,'b')
legend('train error','test error');
xlabel('d+1','Fontsize',16)
hold on;
fprintf( 'the best choice of d is %d\n  ', find(err_test==min(err_test))-1 )
plot( find(err_test==min(err_test)),min(err_test),'b*' )
title('problem 1')
pause(2)

%% problem 2
clear;
load('problem2.mat');
x_train = x( 1:300,: ); y_train = y( 1:300,: );
x_test = x( 301:400,: ); y_test = y( 301:400,: );
% use polyreg2.m to do multivariate regression
for lamda=1:1:1000
    [err,model,errT] = polyreg2(x_train,y_train,lamda,x_test,y_test);
    err_train(lamda) = err;
    err_test(lamda) = errT;
end
figure(2);
plot(1:1000,err_train,'b',1:1000,err_test,'r')
legend('train error','test error');
hold on;
fprintf( 'the best choice of lamda is %d\n  ', find(err_test==min(err_test)) )
plot( find(err_test==min(err_test)),min(err_test),'r*' )
xlabel('lamda');ylabel('error(risk)');
title('problem 2')
pause(2)

%% problem 3
% no codes needed
%% problem 4
clear;
load('dataset4.mat');
% Initialization
n = 1; % step size n
e = 0.001; % tolerance e
new_model = rand( size(X,2),1 );
old_model = new_model+2*e; % make sure the difference is bigger than tolerance

% use gardient descent to get model
i=1;
while sqrt(sum((new_model-old_model).^2)) > e
    [f,risk_R] = risk( X,Y,new_model );
    error(i) = sum( ((f>0.5)-Y').^2 )/length(Y);
    empRisk(i) = risk_R;
    
    old_model=new_model;
    gradient_R = gradient(X,Y,old_model);
    new_model=old_model-n*gradient_R;
    i=i+1;
end

figure(3);
subplot(1,2,1);
plot( X(:,1),X(:,2),'g.' )
hold on;
x=0:0.01:1;
y=(-new_model(3) - new_model(1).* x)/ new_model(2);
plot(x,y,'r')
title('decision boundary');

subplot(1,2,2);
plot( 1:i-1,error,'r',1:i-1,empRisk,'b' )
legend('error rate','empirical risk')
suptitle('problem 4')
