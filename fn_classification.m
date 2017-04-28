
% ========================== Initialize ==================================
clear; close all; clc;

% ======================= Desired Function ===============================

load ('fn_classification_train.mat');

% ========================= Network Model ================================

window_size  = 100;                                                        
step_size    = 10;

input_layer  = window_size;
hidden_layer = 75;
output_layer = 3;

% ====================== Network Parameters ===============================

a = 1.7159;
b = 2/3;

% ===================== Initializing Weights ==============================

w1 = sela_random_weights(input_layer, hidden_layer);
w2 = zeros(output_layer, hidden_layer+1);

lambda = 10^-6;
p = 1/lambda * eye(hidden_layer+1);

% ================ Sequential Extreme Learning ===========================

for i = 1 : (size(input_matrix, 1)-3)
    
    signal = input_matrix(i, :)';
    signal_length = length(signal);
    last_integer = signal_length - window_size + (2*step_size);
    
    nn_signal = [zeros(step_size, 1);...                                  
                 signal ;...                                                 
                 zeros((signal_length + step_size) - last_integer, 1)];
             
    norm_nn_signal = (mapminmax(nn_signal'))';
    
    y = output_matrix(i);
    yd = ((1 : output_layer) == y)';
    
    for j = 1 : step_size : last_integer
        
        x = norm_nn_signal(j : (j + window_size - 1))';
        
        x1 = [1, x]';
        v1 = w1 * x1;
        y1 = a * tanh(b * v1);
    
        x2 = [1; y1];
    
        p  = p - (p * (x2 * x2') * p) ./ (1 + (x2' * p * x2));
        w2 = w2 + ((yd - (w2 * x2)) * (x2' * p));
        
    end
    
end

%save('sela_weights.mat', 'w1', 'w2');
% =========================================================================

sela_predict_fn(window_size, step_size, a, b, w1, w2);

