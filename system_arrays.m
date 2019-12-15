function [arrays] = system_arrays()
    arrays = struct;
    params = system_parameters();
    arrays.T = 0 : params.step : params.t_end;
    %% Iapp and record video
    arrays.T_Iapp = [0.02, 0.0205; 0.025, 0.0255; 0.03, 0.0305; 0.035, 0.0355; 0.04, 0.0405; 0.045, 0.0455;...
         0.05, 0.0505; 0.055, 0.0555; 0.06, 0.0605; 0.065, 0.0655; 0.8, 0.82];
%      arrays.T_Iapp = [0.02, 0.0205; 0.025, 0.0255; 0.03, 0.0305; 0.035, 0.0355; 0.04, 0.0405; 0.045, 0.0455;...
%          0.05, 0.0505; 0.055, 0.0555; 0.06, 0.0605; 0.065, 0.0655; ...
%          0.07, 0.0705; 0.075, 0.0755; 0.08, 0.0805; 0.085, 0.0855; 0.09, 0.0905; 0.095, 0.0955; 0.1, 0.1005;...
%          0.105, 0.1055; 0.11, 0.1105; 0.115, 0.1155;...
%          0.12, 0.1205; 0.125, 0.1255; 0.13, 0.1305; 0.135, 0.1355; 0.14, 0.1405; 0.145, 0.1455; 0.15, 0.1505;...
%          0.155, 0.1555; 0.16, 0.1605; 0.165, 0.1655;...
%          0.17, 0.1705; 0.175, 0.1755; 0.18, 0.1805; 0.185, 0.1855; 0.19, 0.1905; 0.195, 0.1955; 0.2, 0.2005;...
%          0.205, 0.2055; 0.21, 0.2105; 0.215, 0.2155;...
%          0.22, 0.2205; 0.225, 0.2255; 0.23, 0.2305; 0.235, 0.2355; 0.24, 0.2405; 0.245, 0.2455; 0.25, 0.2505;...
%          0.255, 0.2555; 0.26, 0.2605; 0.265, 0.2655;...
%          1.0, 1.02; 1.12, 1.14; 1.24, 1.26; 1.36, 1.38; 1.48, 1.5];
    arrays.T_Iapp = fix( arrays.T_Iapp ./ params.step);
    arrays.T_record(:,1) = arrays.T_Iapp(:,1) - 1;
    arrays.T_record(:,2) = arrays.T_Iapp(:,2) + 200;
    arrays.T_Iapp_met = zeros(1, params.n, 'int8');
    arrays.T_record_met = zeros(1, params.n, 'int8');
    arrays.Iapp = zeros(params.mneuro, params.nneuro, size(arrays.T_Iapp,2));
    arrays.Iapp_v_full = zeros(params.mneuro, params.nneuro, params.n);
    
    %% Zone
    arrays.Zone_syn_relation = zeros(1, params.quantity_connections, 'int8');
    arrays.Line_index = zeros(1, params.quantity_connections, 'int8');
    
    %% Neurons
    arrays.V_line = zeros(params.quantity_neurons, params.n);
    arrays.V_line(:, 1) = params.v_0;
    arrays.U_line = zeros(params.quantity_neurons, params.n);
    arrays.Isyn_line = zeros(params.quantity_neurons, 1);
    arrays.Is_active_line = zeros(params.quantity_neurons, 1);
    arrays.N_spikes_line = zeros(params.quantity_neurons, 1);
    arrays.Met_line = zeros(params.quantity_neurons, params.n, 'logical');
    arrays.Iastro_neuron_line = zeros(params.quantity_neurons, params.n);
    arrays.Gsync_line = zeros(params.quantity_connections,1);
    arrays.Gsync_sum = zeros(params.quantity_neurons, params.n);
    arrays.Mask_line = zeros(1, params.quantity_neurons);
    
    %% neuron_activity
    arrays.Neurons_activity = zeros(params.mastro, params.nastro, params.n);
    arrays.Spike = zeros(params.mastro, params.nastro, params.n);
    
    %% astro
    arrays.Ineuro = zeros(params.mastro, params.nastro, params.n);
    arrays.Iastro_neuron = zeros(params.mastro, params.nastro, params.n, 'logical');
    arrays.Make_n_spikes_zeros = zeros(params.mastro, params.nastro);
    arrays.Ca = zeros(params.mastro, params.nastro, params.n);
    arrays.Ca_size_neuros = zeros(params.mneuro, params.nneuro, params.n);
    arrays.H = zeros(params.mastro, params.nastro, params.n);
    arrays.IP3 = zeros(params.mastro, params.nastro, params.n);
    arrays.Ca(:,:,1) = params.ca_0;
    arrays.H(:,:,1) = params.h_0;
    arrays.IP3(:,:,1) = params.ip3_0;
    arrays.Make_n_spikes_zeros_line = zeros(1, params.quantity_neurons);
  
end