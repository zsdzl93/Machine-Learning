function new_theta = GD(x,y,n,theta)
% gradient descent
sum = 0;
for i=1:length(y)
    f(i)= sign(theta'*x(i,:)');
    if f(i)==y(i)
        gradient_P = 0;
    else
        gradient_P = y(i)*x(i,:)';
    end
    sum = sum + gradient_P;
end
gradient_P = -sum./length(y); % perceptron gradient

new_theta = theta-n*gradient_P;
end

