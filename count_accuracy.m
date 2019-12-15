function [accuracy] = count_accuracy (V_line)
params = system_parameters();
window = 30; % n steps for find spike
shift_window = 1;
n_tests = 5;
n_frames_since_start = 350;
accuracy = zeros(n_tests * n_frames_since_start + n_tests * 10, 1);
Image1 = imread('one1.jpg');
Image0 = imread('zero1.jpg');
Image2 = imread('two1.jpg');
Image3 = imread('three1.jpg');
Image4 = imread('four1.jpg');
Image1 = Image1(1 : params.mneuro, 1 : params.nneuro) < 127;
Image0 = Image0(1 : params.mneuro, 1 : params.nneuro) < 127;
Image2 = Image2(1 : params.mneuro, 1 : params.nneuro) < 127;
Image3 = Image3(1 : params.mneuro, 1 : params.nneuro) < 127;
Image4 = Image4(1 : params.mneuro, 1 : params.nneuro) < 127;
Image1_line = Image1(:);
Image0_line = Image0(:);
Image2_line = Image2(:);
Image3_line = Image3(:);
Image4_line = Image4(:);
background1 = sum(Image1_line == 0);
pattern1 = sum(Image1_line == 1);
background0 = sum(Image0_line == 0);
pattern0 = sum(Image0_line == 1);
background2 = sum(Image2_line == 0);
pattern2 = sum(Image2_line == 1);
background3 = sum(Image3_line == 0);
pattern3 = sum(Image3_line == 1);
background4 = sum(Image4_line == 0);
pattern4 = sum(Image4_line == 1);
k = 2;
for i = 10000 : shift_window : 10000 + n_frames_since_start
    n_true_background1 = 0;
n_true_pattern1 = 0;
    mask = zeros ( params.quantity_neurons, 1);
    for j = 1 : params.quantity_neurons
        if any(V_line(j, i - window : i) > 0)
            mask(j, 1) = 1;
        end
        if (Image1_line(j) == 0)&&(mask(j, 1) == 0)
            n_true_background1 = n_true_background1 + 1;
        end
        if (Image1_line(j) == 1)&&(mask(j, 1) == 1)
            n_true_pattern1 = n_true_pattern1 + 1;
        end
    end
    accuracy(k, 1) = (n_true_background1 / background1 + n_true_pattern1 /pattern1) / 2;
    k = k + 1;
end
k = k + 9;
for i = 11200 : shift_window : 11200 + n_frames_since_start
    n_true_background0 = 0;
n_true_pattern0 = 0;
    mask = zeros ( params.quantity_neurons, 1);
    for j = 1 : params.quantity_neurons
        if any(V_line(j, i - window : i) > 0)
            mask(j, 1) = 1;
        end
        if (Image0_line(j) == 0)&&(mask(j, 1) == 0)
            n_true_background0 = n_true_background0 + 1;
        end
        if (Image0_line(j) == 1)&&(mask(j, 1) == 1)
            n_true_pattern0 = n_true_pattern0 + 1;
        end
    end
    accuracy(k, 1) = (n_true_background0 / background0 + n_true_pattern0 /pattern0) / 2;
    k = k + 1;
end
k = k + 9;
for i = 12400 : shift_window : 12400 + n_frames_since_start
    n_true_background2 = 0;
n_true_pattern2 = 0;
    mask = zeros ( params.quantity_neurons, 1);
    for j = 1 : params.quantity_neurons
        if any(V_line(j, i - window : i) > 0)
            mask(j, 1) = 1;
        end
        if (Image2_line(j) == 0)&&(mask(j, 1) == 0)
            n_true_background2 = n_true_background2 + 1;
        end
        if (Image2_line(j) == 1)&&(mask(j, 1) == 1)
            n_true_pattern2 = n_true_pattern2 + 1;
        end
    end
    accuracy(k, 1) = (n_true_background2 / background2 + n_true_pattern2 /pattern2) / 2;
    k = k + 1;
end
k = k + 9;
for i = 13600 : shift_window : 13600 + n_frames_since_start
    n_true_background3 = 0;
n_true_pattern3 = 0;
    mask = zeros ( params.quantity_neurons, 1);
    for j = 1 : params.quantity_neurons
        if any(V_line(j, i - window : i) > 0)
            mask(j, 1) = 1;
        end
        if (Image3_line(j) == 0)&&(mask(j, 1) == 0)
            n_true_background3 = n_true_background3 + 1;
        end
        if (Image3_line(j) == 1)&&(mask(j, 1) == 1)
            n_true_pattern3 = n_true_pattern3 + 1;
        end
    end
    accuracy(k, 1) = (n_true_background3 / background3 + n_true_pattern3 /pattern3) / 2;
    k = k + 1;
end
k = k + 9;
for i = 14800 : shift_window : 14800 + n_frames_since_start
    n_true_background4 = 0;
n_true_pattern4 = 0;
    mask = zeros ( params.quantity_neurons, 1);
    for j = 1 : params.quantity_neurons
        if any(V_line(j, i - window : i) > 0)
            mask(j, 1) = 1;
        end
        if (Image4_line(j) == 0)&&(mask(j, 1) == 0)
            n_true_background4 = n_true_background4 + 1;
        end
        if (Image4_line(j) == 1)&&(mask(j, 1) == 1)
            n_true_pattern4 = n_true_pattern4 + 1;
        end
    end
    accuracy(k, 1) = (n_true_background4 / background4 + n_true_pattern4 /pattern4) / 2;
    k = k + 1;
end
end
