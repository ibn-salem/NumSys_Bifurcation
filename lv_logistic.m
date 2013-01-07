function f = lv_logistic(y)
    a = 2; b = 1; c = 0.1; r = 0.5;
    f = zeros(2,1);
    f(1) = y(1)*(1-y(1)) - a*y(2)*(1-exp(-b*y(1)));
    f(2) = r*y(2)*(1-y(2)/(y(1)+c));

