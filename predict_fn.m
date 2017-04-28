% ======================= Predict Function ===============================
%clear; close all; clc;
function sela_predict_fn(window_size, step_size, a, b, w1, w2)

load('fn_classification_test.mat');

func = [];
rand_num = randperm(size(testing_input_matrix, 1))    

for i = 1 : size(testing_input_matrix, 1);
    signal = testing_input_matrix(rand_num(i), :)';                           
    signal_length = length(signal);                                       
    last_integer = signal_length - window_size + (2*step_size);           

    nn_signal = [zeros(step_size, 1);...                                  
                 signal ;...                                                 
                 zeros((signal_length + step_size) - last_integer, 1)];   

    norm_nn_signal = (mapminmax(nn_signal'))';
    y = testing_output_matrix(rand_num(i));

    output = [];
    for j = 1 : step_size : last_integer                                  
            x = norm_nn_signal(j : (j + window_size - 1))';
            m = size(x, 1);
            h1 = a * tanh(b * ([ones(m, 1) x] * w1'));
            h2 = ([ones(m, 1) h1] * w2');
            output = [output; h2];
    end

    for k = 1 : size(output, 2)
        predict(k, :) = mean(output(:, k))
    end
    
    predict_max = max(predict);

    for l = 1 : length(predict)
        if (predict(l) == predict_max)
            predicted_class = l;
        end
    end

    func = [func; [y, predicted_class, (y==predicted_class)]];
end
func
testing_accuracy = mean(func(:, 3))*100
% ========================================================================