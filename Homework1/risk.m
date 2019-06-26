function [f,risk_R] = risk( x,y,theta )
sum = 0;
for i=1:length(y)
    f(i)= 1/(1+exp(-theta'*x(i,:)'));
    risk_R = (y(i)-1)*log(1-f(i))-y(i)*log(f(i));
    if isnan (risk_R)
        risk_R=0;
    end
    sum = sum + risk_R;
end
risk_R = sum/length(y);
end