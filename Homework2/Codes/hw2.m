%% use Ctrl + Enter to run each problem seperately

%% problem 1
clear;
load('data3.mat');
X = [ data(:,1:2),ones(size(data,1),1) ];
Y = data(:,3);

% Initialization
n = 1; % step size n
e = 0.0001; % tolerance e
new_model = rand( size(X,2),1 );
old_model = new_model+2*e; % make sure the difference is bigger than tolerance

% use gradient descent to get model
i=1;
while sqrt(sum((new_model-old_model).^2)) > e
    [error,risk_P] = risk( X,Y,new_model );
    Error(i) = error/length(Y);
    empRisk(i) = risk_P*100;
    
    old_model=new_model;
    new_model = GD(X,Y,n,old_model);
    i=i+1;
    if i>20000
        break;
    end
end

% use Stochastic Gradient Descent
% i=1;
% while sqrt(sum((new_model-old_model).^2)) > e
%     [error,risk_P] = risk( X,Y,new_model );
%     Error(i) = error/length(Y);
%     empRisk(i) = risk_P;
%     
%     old_model=new_model;
%     new_model = SGD(X,Y,n,old_model);
%     i=i+1;
%     if i>20000
%         break;
%     end
% end

figure(3);
subplot(1,2,1);
plot( X(find(Y==-1),1),X(find(Y==-1),2),'g.' );
hold on;
plot( X(find(Y==1),1),X(find(Y==1),2),'m.' );

x=0:0.01:1;
y=(-new_model(3) - new_model(1).* x)/ new_model(2);
plot(x,y,'r')
title('decision boundary');

subplot(1,2,2);
plot( 1:i-1,Error(1:i-1)*100,'r',1:i-1,empRisk,'b' )
legend('error rate(%)','empirical risk')
suptitle('problem 1')

%% problem 2
clear;
x=-20:0.01:20;
y=(1+exp(x))./(1+exp(2*x)) ;
plot(x,y,'r')
grid on

%% problem 3
clear;


%% problem 4

