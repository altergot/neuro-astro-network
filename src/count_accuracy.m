function [accuracy, Acc] = count_accuracy (V_line,wind)
params = system_parameters();
window = wind * 10; % n steps for find spike
shift_window = 1;
n_tests = 5;
n_frames_since_start = 350;
accuracy = zeros(n_tests * n_frames_since_start + n_tests * 10, 5);
Image1 = imread('one.jpg');
Image0 = imread('zero.jpg');
Image2 = imread('two.jpg');
Image3 = imread('three.jpg');
Image4 = imread('four.jpg');
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
    n_true_background10 = 0;
    n_true_pattern10 = 0;
    n_true_background12 = 0;
    n_true_pattern12 = 0;
    n_true_background13 = 0;
    n_true_pattern13 = 0;
    n_true_background14 = 0;
    n_true_pattern14 = 0;
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
        if (Image0_line(j) == 0)&&(mask(j, 1) == 0)
            n_true_background10 = n_true_background10 + 1;
        end
        if (Image0_line(j) == 1)&&(mask(j, 1) == 1)
            n_true_pattern10 = n_true_pattern10 + 1;
        end
        if (Image2_line(j) == 0)&&(mask(j, 1) == 0)
            n_true_background12 = n_true_background12 + 1;
        end
        if (Image2_line(j) == 1)&&(mask(j, 1) == 1)
            n_true_pattern12 = n_true_pattern12 + 1;
        end
        if (Image3_line(j) == 0)&&(mask(j, 1) == 0)
            n_true_background13 = n_true_background13 + 1;
        end
        if (Image3_line(j) == 1)&&(mask(j, 1) == 1)
            n_true_pattern13 = n_true_pattern13 + 1;
        end
        if (Image4_line(j) == 0)&&(mask(j, 1) == 0)
            n_true_background14 = n_true_background14 + 1;
        end
        if (Image4_line(j) == 1)&&(mask(j, 1) == 1)
            n_true_pattern14 = n_true_pattern14 + 1;
        end
    end
    accuracy(k, 1) = (n_true_background1 / background1 + n_true_pattern1 /pattern1) / 2;
    accuracy(k, 2) = (n_true_background10 / background0 + n_true_pattern10 /pattern0) / 2;
    accuracy(k, 3) = (n_true_background12 / background2 + n_true_pattern12 /pattern2) / 2;
    accuracy(k, 4) = (n_true_background13 / background3 + n_true_pattern13 /pattern3) / 2;
    accuracy(k, 5) = (n_true_background14 / background4 + n_true_pattern14 /pattern4) / 2;
    k = k + 1;
end
k = k + 9;
for i = 11200 : shift_window : 11200 + n_frames_since_start
    n_true_background1 = 0;
    n_true_pattern1 = 0;
    n_true_background10 = 0;
    n_true_pattern10 = 0;
    n_true_background12 = 0;
    n_true_pattern12 = 0;
    n_true_background13 = 0;
    n_true_pattern13 = 0;
    n_true_background14 = 0;
    n_true_pattern14 = 0;
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
        if (Image0_line(j) == 0)&&(mask(j, 1) == 0)
            n_true_background10 = n_true_background10 + 1;
        end
        if (Image0_line(j) == 1)&&(mask(j, 1) == 1)
            n_true_pattern10 = n_true_pattern10 + 1;
        end
        if (Image2_line(j) == 0)&&(mask(j, 1) == 0)
            n_true_background12 = n_true_background12 + 1;
        end
        if (Image2_line(j) == 1)&&(mask(j, 1) == 1)
            n_true_pattern12 = n_true_pattern12 + 1;
        end
        if (Image3_line(j) == 0)&&(mask(j, 1) == 0)
            n_true_background13 = n_true_background13 + 1;
        end
        if (Image3_line(j) == 1)&&(mask(j, 1) == 1)
            n_true_pattern13 = n_true_pattern13 + 1;
        end
        if (Image4_line(j) == 0)&&(mask(j, 1) == 0)
            n_true_background14 = n_true_background14 + 1;
        end
        if (Image4_line(j) == 1)&&(mask(j, 1) == 1)
            n_true_pattern14 = n_true_pattern14 + 1;
        end
    end
    accuracy(k, 1) = (n_true_background1 / background1 + n_true_pattern1 /pattern1) / 2;
    accuracy(k, 2) = (n_true_background10 / background0 + n_true_pattern10 /pattern0) / 2;
    accuracy(k, 3) = (n_true_background12 / background2 + n_true_pattern12 /pattern2) / 2;
    accuracy(k, 4) = (n_true_background13 / background3 + n_true_pattern13 /pattern3) / 2;
    accuracy(k, 5) = (n_true_background14 / background4 + n_true_pattern14 /pattern4) / 2;
    k = k + 1;
end
k = k + 9;
for i = 12400 : shift_window : 12400 + n_frames_since_start
    n_true_background1 = 0;
    n_true_pattern1 = 0;
    n_true_background10 = 0;
    n_true_pattern10 = 0;
    n_true_background12 = 0;
    n_true_pattern12 = 0;
    n_true_background13 = 0;
    n_true_pattern13 = 0;
    n_true_background14 = 0;
    n_true_pattern14 = 0;
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
        if (Image0_line(j) == 0)&&(mask(j, 1) == 0)
            n_true_background10 = n_true_background10 + 1;
        end
        if (Image0_line(j) == 1)&&(mask(j, 1) == 1)
            n_true_pattern10 = n_true_pattern10 + 1;
        end
        if (Image2_line(j) == 0)&&(mask(j, 1) == 0)
            n_true_background12 = n_true_background12 + 1;
        end
        if (Image2_line(j) == 1)&&(mask(j, 1) == 1)
            n_true_pattern12 = n_true_pattern12 + 1;
        end
        if (Image3_line(j) == 0)&&(mask(j, 1) == 0)
            n_true_background13 = n_true_background13 + 1;
        end
        if (Image3_line(j) == 1)&&(mask(j, 1) == 1)
            n_true_pattern13 = n_true_pattern13 + 1;
        end
        if (Image4_line(j) == 0)&&(mask(j, 1) == 0)
            n_true_background14 = n_true_background14 + 1;
        end
        if (Image4_line(j) == 1)&&(mask(j, 1) == 1)
            n_true_pattern14 = n_true_pattern14 + 1;
        end
    end
    accuracy(k, 1) = (n_true_background1 / background1 + n_true_pattern1 /pattern1) / 2;
    accuracy(k, 2) = (n_true_background10 / background0 + n_true_pattern10 /pattern0) / 2;
    accuracy(k, 3) = (n_true_background12 / background2 + n_true_pattern12 /pattern2) / 2;
    accuracy(k, 4) = (n_true_background13 / background3 + n_true_pattern13 /pattern3) / 2;
    accuracy(k, 5) = (n_true_background14 / background4 + n_true_pattern14 /pattern4) / 2;
    k = k + 1;
end
k = k + 9;
for i = 13600 : shift_window : 13600 + n_frames_since_start
    n_true_background1 = 0;
    n_true_pattern1 = 0;
    n_true_background10 = 0;
    n_true_pattern10 = 0;
    n_true_background12 = 0;
    n_true_pattern12 = 0;
    n_true_background13 = 0;
    n_true_pattern13 = 0;
    n_true_background14 = 0;
    n_true_pattern14 = 0;
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
        if (Image0_line(j) == 0)&&(mask(j, 1) == 0)
            n_true_background10 = n_true_background10 + 1;
        end
        if (Image0_line(j) == 1)&&(mask(j, 1) == 1)
            n_true_pattern10 = n_true_pattern10 + 1;
        end
        if (Image2_line(j) == 0)&&(mask(j, 1) == 0)
            n_true_background12 = n_true_background12 + 1;
        end
        if (Image2_line(j) == 1)&&(mask(j, 1) == 1)
            n_true_pattern12 = n_true_pattern12 + 1;
        end
        if (Image3_line(j) == 0)&&(mask(j, 1) == 0)
            n_true_background13 = n_true_background13 + 1;
        end
        if (Image3_line(j) == 1)&&(mask(j, 1) == 1)
            n_true_pattern13 = n_true_pattern13 + 1;
        end
        if (Image4_line(j) == 0)&&(mask(j, 1) == 0)
            n_true_background14 = n_true_background14 + 1;
        end
        if (Image4_line(j) == 1)&&(mask(j, 1) == 1)
            n_true_pattern14 = n_true_pattern14 + 1;
        end
    end
    accuracy(k, 1) = (n_true_background1 / background1 + n_true_pattern1 /pattern1) / 2;
    accuracy(k, 2) = (n_true_background10 / background0 + n_true_pattern10 /pattern0) / 2;
    accuracy(k, 3) = (n_true_background12 / background2 + n_true_pattern12 /pattern2) / 2;
    accuracy(k, 4) = (n_true_background13 / background3 + n_true_pattern13 /pattern3) / 2;
    accuracy(k, 5) = (n_true_background14 / background4 + n_true_pattern14 /pattern4) / 2;
    k = k + 1;
end
k = k + 9;
for i = 14800 : shift_window : 14800 + n_frames_since_start
    n_true_background1 = 0;
    n_true_pattern1 = 0;
    n_true_background10 = 0;
    n_true_pattern10 = 0;
    n_true_background12 = 0;
    n_true_pattern12 = 0;
    n_true_background13 = 0;
    n_true_pattern13 = 0;
    n_true_background14 = 0;
    n_true_pattern14 = 0;
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
        if (Image0_line(j) == 0)&&(mask(j, 1) == 0)
            n_true_background10 = n_true_background10 + 1;
        end
        if (Image0_line(j) == 1)&&(mask(j, 1) == 1)
            n_true_pattern10 = n_true_pattern10 + 1;
        end
        if (Image2_line(j) == 0)&&(mask(j, 1) == 0)
            n_true_background12 = n_true_background12 + 1;
        end
        if (Image2_line(j) == 1)&&(mask(j, 1) == 1)
            n_true_pattern12 = n_true_pattern12 + 1;
        end
        if (Image3_line(j) == 0)&&(mask(j, 1) == 0)
            n_true_background13 = n_true_background13 + 1;
        end
        if (Image3_line(j) == 1)&&(mask(j, 1) == 1)
            n_true_pattern13 = n_true_pattern13 + 1;
        end
        if (Image4_line(j) == 0)&&(mask(j, 1) == 0)
            n_true_background14 = n_true_background14 + 1;
        end
        if (Image4_line(j) == 1)&&(mask(j, 1) == 1)
            n_true_pattern14 = n_true_pattern14 + 1;
        end
    end
    accuracy(k, 1) = (n_true_background1 / background1 + n_true_pattern1 /pattern1) / 2;
    accuracy(k, 2) = (n_true_background10 / background0 + n_true_pattern10 /pattern0) / 2;
    accuracy(k, 3) = (n_true_background12 / background2 + n_true_pattern12 /pattern2) / 2;
    accuracy(k, 4) = (n_true_background13 / background3 + n_true_pattern13 /pattern3) / 2;
    accuracy(k, 5) = (n_true_background14 / background4 + n_true_pattern14 /pattern4) / 2;
    k = k + 1;
end
A1 = max(accuracy(160:240,1));
A2 = max(accuracy(520:600,2));
A3 = max(accuracy(880:960,3));
A4 = max(accuracy(1240:1320,4));
A5 = max(accuracy(1600:1670,5));
Acc = (A1+A2+A3+A4+A5)/5;
end