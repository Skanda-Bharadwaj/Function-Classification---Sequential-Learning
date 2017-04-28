clear; close all; clc;

x = -5*pi:0.01:5*pi;

x1 = sin(x);
x2 = 2*sin(x)+3*cos(x);
x3 = sin(2*x)+cos((pi/4)+(3*x));
x4 = sin((2*pi/5)+(x)) + cos((7*pi/6)-(x));
x5 = sin(x).^2;
x6 = sin(x).^2 - sin(x);
x7 = cos((2*pi/5) - sin(x));
x8 = (2*cos(pi/5)*sin(x)) - 3;
x9 = cos(sin(x).^2);
x10 = 0.2*sin(2*pi*x/25)+0.3*sin(3*pi*x/15);

sinusoids = [x1; x2; x3; x4; x5; x6; x7; x8; x9; x10];


e1 = exp(x);
e2 = exp(-x);
e3 = exp(2*x+3);
e4 = exp(2*x+1)./(2*exp(x));
e5 = (exp(x)-exp(-x))./(exp(x)+exp(-x));
e6 = exp(x)+exp(-x);
e7 = 1./exp(x.^2);
e8 = exp(sqrt(10+(2*x)));
e9 = exp((2*x.^2)+(5*x)-10);
e10 = exp(10*x).*exp(-5*x);

exponentials = [e1; e2; e3; e4; e5; e6; e7; e8; e9; e10];

y1 = 5*x + 10;
y2 = (x.^2) + (10*x) - 6;
y3 = (3*x.^3) - (9*x.^2) - (6*x) - 10;
y4 = ((x.^2)-2)./(x.^3 - 3);
y5 = x.^4 + 1 + (1./(x.^2+x+1));
y6 = sqrt((2*x+1)./(x.^3 - (3*x.^2) + 2*x));
y7 = (x.^3 + sqrt(30 - x.^2))./(2*x);
y8 = 1./(sqrt(x.^2 + 2));
y9 = (x.^5)+(2*x.^4)-(6*x.^3)+(7*x.^2)-(9*x)+3;
y10 = sqrt(1 - sqrt(1 - sqrt(1 - x.^2)));

polynomials = [y1; y2; y3; y4; y5; y6; y7; y8; y9; y10];


input_matrix = [sinusoids; exponentials; polynomials];
output_matrix = [1*ones(size(sinusoids, 1), 1);...
                 2*ones(size(exponentials, 1), 1);... 
                 3*ones(size(polynomials, 1), 1)];

save('fn_classification_train.mat', 'input_matrix', 'output_matrix');


x11 = cos(-x);
x12 = 0.6*sin(3*pi*x/8)+ 0.3*cos(2*pi*x/17);
x13 = 2*sin(x)+0.5*cos(2*pi*x/13);
test_sinusoids = [x11; x12; x13];

e11 = exp(x.^2 + 2*x);
e12 = 1./exp(-x + 8);
e13 = exp(-x) + exp(x.^2);
test_exponentials = [e11; e12; e13];

y11 = x;
y12 = 3*x+2;
y13 = x.^3 + 5*x - 1;
test_polynomials = [y11; y12; y13];

testing_input_matrix = [test_sinusoids; test_exponentials; test_polynomials];
testing_output_matrix = [1*ones(size(test_sinusoids, 1), 1);...
                         2*ones(size(test_exponentials, 1), 1);... 
                         3*ones(size(test_polynomials, 1), 1)];
                     
save('fn_classification_test.mat', 'testing_input_matrix', 'testing_output_matrix');


