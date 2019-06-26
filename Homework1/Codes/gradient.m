function gradient_R = gradient(x,y,theta)
sum = 0;
for i=1:length(y)
    gradient_R=(1-y(i))*(x(i,:)'./(1+exp(-theta'*x(i,:)')))-y(i)*(x(i,:)'./(1+exp(theta'*x(i,:)')));
    sum = sum + gradient_R;
end
gradient_R = sum./length(y);
end

