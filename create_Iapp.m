function [Iapp, t_Iapp_met, t_record_met]  = create_Iapp(t_Iapp,t_record)
params = system_parameters();
Image = imread('one.jpg');
Image0 = imread('zero.jpg');
Image2 = imread('two.jpg');
Image3 = imread('three.jpg');
Image4 = imread('four.jpg');
I = size(t_Iapp, 1);
Iapp = zeros(params.mneuro, params.nneuro, I);
for i = 1 : 10
    Image1 = Image(1 : params.mneuro, 1 : params.nneuro) < 127;
    p = randperm(params.quantity_neurons);
    b = p(1 : uint16(params.quantity_neurons * params.variance_learn));
    Image1(b)= abs(Image1(b) - 1);
    Iapp(:,:,i) = Image1 .* params.Iapp_learn;
end
for i = 11 : 20
    Image1 = Image0(1 : params.mneuro, 1 : params.nneuro) < 127;
    p = randperm(params.quantity_neurons);
    b = p(1 : uint16(params.quantity_neurons * params.variance_learn));
    Image1(b)= abs(Image1(b) - 1);
    Iapp(:,:,i) = Image1 .* params.Iapp_learn;
end
for i = 21 : 30
    Image1 = Image2(1 : params.mneuro, 1 : params.nneuro) < 127;
    p = randperm(params.quantity_neurons);
    b = p(1 : uint16(params.quantity_neurons *params.variance_learn));
    Image1(b)= abs(Image1(b) - 1);
    Iapp(:,:,i) = Image1 .* params.Iapp_learn;
end
for i = 31 : 40
    Image1 = Image3(1 : params.mneuro, 1 : params.nneuro) < 127;
    p = randperm(params.quantity_neurons);
    b = p(1 : uint16(params.quantity_neurons * params.variance_learn));
    Image1(b)= abs(Image1(b) - 1);
    Iapp(:,:,i) = Image1 .* params.Iapp_learn;
end
for i = 41 : 50
    Image1 = Image4(1 : params.mneuro, 1 : params.nneuro) < 127;
    p = randperm(params.quantity_neurons);
    b = p(1 : uint16(params.quantity_neurons * params.variance_learn));
    Image1(b)= abs(Image1(b) - 1);
    Iapp(:,:,i) = Image1 .* params.Iapp_learn;
end
Iapp = Iapp(:,:,randperm(size(Iapp(:,:,1:50),3)));

Image1 = Image(1 : params.mneuro, 1 : params.nneuro) < 127;
p = randperm(params.quantity_neurons);
b = p(1 : uint16(params.quantity_neurons * params.variance_test));
Image1(b)= abs(Image1(b) - 1);
Iapp(:,:,51) = Image1 .*  params.Iapp_test;

Image1 = Image0(1 : params.mneuro, 1 : params.nneuro) < 127;
p = randperm(params.quantity_neurons);
b = p(1 : uint16(params.quantity_neurons * params.variance_test));
Image1(b)= abs(Image1(b) - 1);
Iapp(:,:,52) = Image1 .* params.Iapp_test;

Image1 = Image2(1 : params.mneuro, 1 : params.nneuro) < 127;
p = randperm(params.quantity_neurons);
b = p(1 : uint16(params.quantity_neurons * params.variance_test));
Image1(b)= abs(Image1(b) - 1);
Iapp(:,:,53) = Image1 .* params.Iapp_test;

Image1 = Image3(1 : params.mneuro, 1 : params.nneuro) < 127;
p = randperm(params.quantity_neurons);
b = p(1 : uint16(params.quantity_neurons * params.variance_test));
Image1(b)= abs(Image1(b) - 1);
Iapp(:,:,54) = Image1 .* params.Iapp_test;

Image1 = Image4(1 : params.mneuro, 1 : params.nneuro) < 127;
p = randperm(params.quantity_neurons);
b = p(1 : uint16(params.quantity_neurons * params.variance_test));
Image1(b)= abs(Image1(b) - 1);
Iapp(:,:,55) = Image1 .* params.Iapp_test;

t_Iapp_met = zeros(1, params.n, 'int8');
t_record_met = zeros(1, params.n, 'int8');
for i = 1 : size(Iapp, 3)
    t_Iapp_met(t_Iapp(i, 1) : t_Iapp(i, 2)) = i;
    t_record_met(t_record(i, 1) : t_record(i, 2)) = i;
end
end