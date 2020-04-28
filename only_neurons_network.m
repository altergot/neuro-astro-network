close all; clearvars;
tic
%parameters
step = 0.0001;
mneuro = 79;
nneuro = 79;
quantity_neurons = mneuro * nneuro;

t_end = 0.8;
u2 = step / 2;
u6 = step / 6;
n = fix(t_end / step);

variance_learn = 0.05;
variance_test = 0.2;

max_syn_relation = 100;%40;
quantity_connections = mneuro * nneuro * max_syn_relation;
lambda = 7;

aa = 0.1; %FS
p_b = 0.2;
c = -65;
d = 2;

ksyn = 0.2;
beta = 450;
gsyn = 200; %150
koef = 0.01;
tao = 150;

%arrays
t_Iapp = [0.02, 0.0205; 0.025, 0.0255; 0.03, 0.0305; 0.035, 0.0355; 0.04, 0.0405; 0.045, 0.0455;...
    0.05, 0.0505; 0.055, 0.0555; 0.06, 0.0605; 0.065, 0.0655;...
    0.07, 0.0705; 0.075, 0.0755; 0.08, 0.0805; 0.085, 0.0855; 0.09, 0.0905; 0.095, 0.0955; 0.1, 0.1005;...
    0.105, 0.1055; 0.11, 0.1105; 0.115, 0.1155;...
    0.5, 0.504; 0.74, 0.744];
t_Iapp = fix(t_Iapp ./ step);
t_record(:,1) = t_Iapp(:,1) - 1;
t_record(:,2) = t_Iapp(:,2) + 200;

V_line = zeros(quantity_neurons, n);
V_line(:, 1) = -70;
U_line = zeros(quantity_neurons, n);
Isyn_line = zeros(quantity_neurons, n);
array_is_active = zeros ( quantity_neurons, n);
array_gsync = zeros (quantity_connections, 1);%n);
array_gsync(:, 1)= 0.005;
GSYNC_SUM = zeros(mneuro, nneuro, n);
Iapp_v_full = zeros(mneuro, nneuro, n);

Image = imread('one1.jpg');
Image0 = imread('zero1.jpg');
I = size(t_Iapp, 1);
Iapp = zeros(mneuro, nneuro, I);
for i = 1 : 10
    Image1 = Image(1 : mneuro, 1 : nneuro) < 127;
    p = randperm(quantity_neurons);
    b = p(1 : uint16(quantity_neurons * variance_learn));
    Image1(b)= abs(Image1(b) - 1);
    Iapp(:,:,i) = Image1 .*80;
end
for i = 11 : 20
    Image1 = Image0(1 : mneuro, 1 : nneuro) < 127;
    p = randperm(quantity_neurons);
    b = p(1 : uint16(quantity_neurons * variance_learn));
    Image1(b)= abs(Image1(b) - 1);
    Iapp(:,:,i) = Image1 .*80;
end
Iapp = Iapp(:,:,randperm(size(Iapp(:,:,1:20),3)));
Image1 = Image(1 : mneuro, 1 : nneuro) < 127;
p = randperm(quantity_neurons);
b = p(1 : uint16(quantity_neurons * variance_test));
Image1(b)= abs(Image1(b) - 1);
Iapp(:,:,21) = Image1 .* 80;
Image1 = Image0(1 : mneuro, 1 : nneuro) < 127;
p = randperm(quantity_neurons);
b = p(1 : uint16(quantity_neurons * variance_test));
Image1(b)= abs(Image1(b) - 1);
Iapp(:,:,22) = Image1 .* 80;

t_Iapp_met = zeros(1, n, 'int8');
t_record_met = zeros(1, n, 'int8');
for i = 1 : size(Iapp, 3)
    t_Iapp_met(t_Iapp(i, 1) : t_Iapp(i, 2)) = i;
    t_record_met(t_record(i, 1) : t_record(i, 2)) = i;
end

Zone_syn_relation = zeros(mneuro, nneuro, max_syn_relation);
Zone_syn_relation_for_one = zeros(mneuro, nneuro);
ties_stock = 1000 * max_syn_relation;
for i = 1 : mneuro
    for j = 1 : nneuro
        XY = zeros(2, ties_stock, 'int8');
        R = random('exp', lambda, 1, ties_stock);
        fi = 2 * pi * rand(1, ties_stock);
        XY(1,:) = fix(R .* cos(fi));
        XY(2,:) = fix(R .* sin(fi));
        XY1 = unique(XY', 'row','stable');
        XY = XY1';
        n1 = 1;
        for k = 1 : ties_stock
            x = i + XY(1, k);
            y = j + XY(2, k);
            if (i == x && j == y)
                pp = 1;
            else pp = 0;
            end
            if (x > 0 && y > 0 && x <= mneuro && y <= nneuro && pp == 0)
                Zone_syn_relation(i,j,n1) = sub2ind(size(Zone_syn_relation_for_one), x, y);
                n1 = n1 + 1;
            end
            if n1 > max_syn_relation
                break
            end
        end
    end
end
Zone_syn_relation2 = permute(Zone_syn_relation, [3 1 2]);
Zone = Zone_syn_relation2(:)';
k = 1;
for i = 1 : max_syn_relation : size(Zone, 2)
    line_index(i : i + max_syn_relation - 1) = k;
    k = k + 1;
end

for i = 1 : n
    if t_Iapp_met(1,i) == 0
        Iapp_t = zeros(mneuro, nneuro);
    else
        Iapp_t = Iapp(:, :, t_Iapp_met(1,i));
    end
    Iapp_v_full(:,:,i) = Iapp_t;
    Iapp_line = Iapp_t(:);
    V = V_line(:,i);
    U = U_line(:,i);
    Isyn = Isyn_line(:, i);
    is_active = array_is_active(:,i);
    gsync = array_gsync(:,1);
    
    fired = find(V >= 30);
    V(fired) = c;
    U(fired) = U(fired) + d;
    V = V + step .* 1000 .* (0.04 .* V .^ 2 + 5 .* V + 140 + Iapp_line + Isyn - U);
    U = U + step .* 1000 .* aa .* (p_b .* V - U);
    V (V > 30) = 30;
    S = 1 ./ (1 + exp(( - V ./ ksyn)));
    Isyn = zeros ( quantity_neurons, 1);
    mask = zeros ( quantity_neurons, 1);
    mask(V > 29) = 1;
    is_active = (1 - step * beta) .* is_active;
    is_active = min(1, is_active + 0.2) .* mask + is_active .* ~mask;
    gsync_sum = zeros (1, quantity_neurons);
    
    delta_gsync = gsyn .* is_active(Zone) .* is_active(line_index);
    %delta_gsync_brake =  0.00002 .* gsyn .* max(is_active(Zone),is_active(line_index)) ./  (min(is_active(Zone),is_active(line_index)) + 0.0001);
    delta_gsync_brake =  koef .* is_active(Zone) ./  (is_active(line_index) + 0.0001);
    gsync = gsync + delta_gsync .* step - delta_gsync_brake .* step - gsync .* is_active(Zone) .* step .* tao;
    gsync = min(gsync, 0.1);
    gsync = max(gsync, -0.3);
    
    Isync = gsync .* S(line_index) .* ( - V(Zone));
    for q = 1 : quantity_connections
        gsync_sum(Zone(q)) = gsync_sum(Zone(q)) + gsync(q);
        Isyn(Zone(q)) = Isyn(Zone(q)) + Isync(q);
    end
    GSYNC_SUM(:,:,i+1) = reshape(gsync_sum, mneuro, nneuro);
    V_line(:,i+1) = V;
    U_line(:,i+1) = U;
    array_is_active(:,i+1) = is_active;
    Isyn_line(:, i + 1) = Isyn;
    array_gsync(:,1) = gsync;
end
toc;

window = 30;
shift_window = 1;
n_tests = 2;
n_frames_since_start = 350;
accuracy = zeros(n_tests * n_frames_since_start + n_tests * 10, 2);
Image1 = imread('one1.jpg');
Image0 = imread('zero1.jpg');
Image1 = Image1(1 : mneuro, 1 : nneuro) < 127;
Image0 = Image0(1 : mneuro, 1 : nneuro) < 127;
Image1_line = Image1(:);
Image0_line = Image0(:);
background1 = sum(Image1_line == 0);
pattern1 = sum(Image1_line == 1);
background0 = sum(Image0_line == 0);
pattern0 = sum(Image0_line == 1);
k = 2;
for i = 5000 : shift_window : 5000 + n_frames_since_start
    n_true_background1 = 0;
    n_true_pattern1 = 0;
    n_true_background0 = 0;
    n_true_pattern0 = 0;
    mask = zeros (quantity_neurons, 1);
    for j = 1 : quantity_neurons
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
            n_true_background0 = n_true_background0 + 1;
        end
        if (Image0_line(j) == 1)&&(mask(j, 1) == 1)
            n_true_pattern0 = n_true_pattern0 + 1;
        end
    end
    accuracy(k, 1) = (n_true_background1 / background1 + n_true_pattern1 /pattern1) / 2;
    accuracy(k, 2) = (n_true_background0 / background0 + n_true_pattern0 /pattern0) / 2;
    k = k+1;
end
k=k+9;
for i = 7400 : shift_window : 7400 + n_frames_since_start
    n_true_background1 = 0;
    n_true_pattern1 = 0;
    n_true_background0 = 0;
    n_true_pattern0 = 0;
    mask = zeros (quantity_neurons, 1);
    for j = 1 : quantity_neurons
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
            n_true_background0 = n_true_background0 + 1;
        end
        if (Image0_line(j) == 1)&&(mask(j, 1) == 1)
            n_true_pattern0 = n_true_pattern0 + 1;
        end
    end
    accuracy(k, 1) = (n_true_background1 / background1 + n_true_pattern1 /pattern1) / 2;
    accuracy(k, 2) = (n_true_background0 / background0 + n_true_pattern0 /pattern0) / 2;
    k = k+1;
end

V = reshape(V_line, mneuro, nneuro, []);
Iapp_v_full = Iapp_v_full ./ 10;
V = V ./ 100;
V_v = V(:,:,t_record_met ~= 0);
Iapp_v = Iapp_v_full(:,:,t_record_met ~= 0);
video = horzcat(Iapp_v, V_v);
handle = implay(video,10);
cmap = jet(256);
handle.Visual.ColorMap.Map = cmap;
handle.Visual.ColorMap.UserRangeMin = -0.8;
handle.Visual.ColorMap.UserRangeMax = 0.3;
