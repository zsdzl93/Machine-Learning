function new_theta = SGD(x,y,n,theta)
% stochastic gradient descent
sum = 0; n = 1;
for i=1:length(y)
    f(i)= sign(theta'*x(i,:)');
    if f(i)==y(i)
        gradient_P = 0;
    else
        gradient_P = y(i)*x(i,:)';
    end
    sum = sum + gradient_P;
end
gradient_P = -sum; % perceptron gradient     ./length(y)

new_theta = theta-n*gradient_P;
end