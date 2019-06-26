function [error,risk_P] = risk( x,y,theta )
sum = 0; error = 0;
for i=1:length(y)
    f(i)= sign(theta'*x(i,:)');
    if f(i)==y(i)
        risk_P = 0;
    else
        risk_P = y(i)*(theta'*x(i,:)');
        error = error + 1;
    end
    if isnan (risk_P)
        risk_P=0;
    end
    sum = sum + risk_P;
end
risk_P = -sum/length(y);% perceptron loss
end