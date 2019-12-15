function [Iapp, t_Iapp_met, t_record_met]  = create_Iapp(t_Iapp,t_record)
params = system_parameters();
Image = imread('one1.jpg');
Image0 = imread('zero1.jpg');
Image2 = imread('two1.jpg');
Image3 = imread('three1.jpg');
Image4 = imread('four1.jpg');
I = size(t_Iapp, 1);
Iapp = zeros(params.mneuro, params.nneuro, I);
for i = 1 : 10
    Image1 = imnoise(Image,'salt & pepper', params.variance_learn);
    Image1 = Image1(1 : params.mneuro, 1 : params.nneuro) < 127;
    Iapp(:,:,i) = Image1 .*80;
end
% for i = 11 : 20
%     Image1 = imnoise(Image0,'salt & pepper', params.variance_learn);
%     Image1 = Image1(1 : params.mneuro, 1 : params.nneuro) < 127;
%     Iapp(:,:,i) = Image1 .*80;
% end
% for i = 21 : 30
%     Image1 = imnoise(Image2,'salt & pepper', params.variance_learn);
%     Image1 = Image1(1 : params.mneuro, 1 : params.nneuro) < 127;
%     Iapp(:,:,i) = Image1 .*80;
% end
% for i = 31 : 40
%     Image1 = imnoise(Image3,'salt & pepper', params.variance_learn);
%     Image1 = Image1(1 : params.mneuro, 1 : params.nneuro) < 127;
%     Iapp(:,:,i) = Image1 .*80;
% end
% for i = 41 : 50
%     Image1 = imnoise(Image4,'salt & pepper', params.variance_learn);
%     Image1 = Image1(1 : params.mneuro, 1 : params.nneuro) < 127;
%     Iapp(:,:,i) = Image1 .*80;
% end

%Iapp = Iapp(:,:,randperm(size(Iapp(:,:,1:50),3)));

Image1 = imnoise(Image, 'salt & pepper', params.variance_test);
Image1 = Image1(1 : params.mneuro, 1 : params.nneuro) < 127;
Iapp(:,:,11) = Image1 .* 8;

% Image1 = imnoise(Image0, 'salt & pepper', params.variance_test);
% Image1 = Image1(1 : params.mneuro, 1 : params.nneuro) < 127;
% Iapp(:,:,52) = Image1 .* 8;
% 
% Image1 = imnoise(Image2, 'salt & pepper', params.variance_test);
% Image1 = Image1(1 : params.mneuro, 1 : params.nneuro) < 127;
% Iapp(:,:,53) = Image1 .* 8;
% 
% Image1 = imnoise(Image3, 'salt & pepper', params.variance_test);
% Image1 = Image1(1 : params.mneuro, 1 : params.nneuro) < 127;
% Iapp(:,:,54) = Image1 .* 8;
% 
% Image1 = imnoise(Image4, 'salt & pepper', params.variance_test);
% Image1 = Image1(1 : params.mneuro, 1 : params.nneuro) < 127;
% Iapp(:,:,55) = Image1 .* 8;


%Iapp = Iapp .* params.amplitude_Iapp;
t_Iapp_met = zeros(1, params.n, 'int8');
t_record_met = zeros(1, params.n, 'int8');
for i = 1 : size(Iapp, 3)
    t_Iapp_met(t_Iapp(i, 1) : t_Iapp(i, 2)) = i;
    t_record_met(t_record(i, 1) : t_record(i, 2)) = i;
end
end
