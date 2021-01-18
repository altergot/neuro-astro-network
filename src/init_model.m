function [model] = init_model()
model = struct;
params = model_parameters();
model.T = 0 : params.step : params.t_end;
model.T = single(model.T);

%% Zone
model.Post = zeros(1, params.quantity_connections, 'int8');
model.Pre  = zeros(1, params.quantity_connections, 'int8');

%% Neurons
model.V_line = zeros(params.quantity_neurons, params.n, 'double');
model.V_line(:, 1) = params.v_0;
model.G = zeros(params.quantity_neurons, 1, 'double');
model.U_line = zeros(params.quantity_neurons, 1, 'double');
model.Isyn_line = zeros(params.quantity_neurons, 1,'double');
model.Iastro_neuron_line = zeros(params.quantity_neurons, 1,'logical');
model.Mask_line = zeros(1, params.quantity_neurons,'logical');

%% Neuron activity
model.neuron_astrozone_activity = zeros(params.mastro, params.nastro, 1,'int8');
model.neuron_astrozone_spikes   = zeros(params.mastro, params.nastro, params.n,'int8');

%% Astrocytes
model.Ineuro = zeros(params.mastro, params.nastro, params.n,'int8');
model.Iastro_neuron = zeros(params.mastro, params.nastro, params.n, 'logical');
model.Ca = zeros(params.mastro, params.nastro, 1,'double');
model.Ca_size_neuros = zeros(params.mneuro, params.nneuro, params.n,'double');
model.H = zeros(params.mastro, params.nastro, 1,'double');
model.IP3 = zeros(params.mastro, params.nastro, 1,'double');
model.Ca(:,:,1) = params.ca_0;
model.H(:,:,1) = params.h_0;
model.IP3(:,:,1) = params.ip3_0;

%% Iapp and record video
%     model.T_Iapp = [
%         0.02, 0.0205; 0.025, 0.0255; 0.03, 0.0305; 0.035, 0.0355; 0.04, 0.0405; 0.045, 0.0455;...
%         0.05, 0.0505; 0.055, 0.0555; 0.06, 0.0605; 0.065, 0.0655; ...
%         0.07, 0.0705; 0.075, 0.0755; 0.08, 0.0805; 0.085, 0.0855; 0.09, 0.0905; 0.095, 0.0955; 0.1, 0.1005;...
%         0.105, 0.1055; 0.11, 0.1105; 0.115, 0.1155;...
%         0.12, 0.1205; 0.125, 0.1255; 0.13, 0.1305; 0.135, 0.1355; 0.14, 0.1405; 0.145, 0.1455; 0.15, 0.1505;...
%         0.155, 0.1555; 0.16, 0.1605; 0.165, 0.1655;...
%         0.17, 0.1705; 0.175, 0.1755; 0.18, 0.1805; 0.185, 0.1855; 0.19, 0.1905; 0.195, 0.1955; 0.2, 0.2005;...
%         0.205, 0.2055; 0.21, 0.2105; 0.215, 0.2155;...
%         0.22, 0.2205; 0.225, 0.2255; 0.23, 0.2305; 0.235, 0.2355; 0.24, 0.2405; 0.245, 0.2455; 0.25, 0.2505;...
%         0.255, 0.2555; 0.26, 0.2605; 0.265, 0.2655;...
%         1.0, 1.02; 1.12, 1.14; 1.24, 1.26; 1.36, 1.38; 1.48, 1.5];
%     model.T_Iapp = fix( model.T_Iapp ./ params.step);
%     model.T_record(:,1) = model.T_Iapp(:,1) - 1;
%     model.T_record(:,2) = model.T_Iapp(:,2) + 200;
%     model.T_Iapp_met = zeros(1, params.n, 'int8');
%     model.T_record_met = zeros(1, params.n, 'int8');
%     model.Iapp = zeros(params.mneuro, params.nneuro, size(model.T_Iapp,2));
     model.Iapp_v_full = zeros(params.mneuro, params.nneuro, params.n,'uint8');

%% Prepare model
[model.images] = load_images();
[model.Iapp, model.T_Iapp, model.T_Iapp_met, model.T_record_met] = ...
    make_experiment(model.images);
[model.Post, model.Pre] = create_connections();
[model.I_poisson_noise] = make_poisson_noise();
    
end