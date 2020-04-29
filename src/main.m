close all; clearvars;
params = system_parameters(true);
arrays = system_arrays();
[arrays.Iapp, arrays.T_Iapp_met, arrays.T_record_met]  = ...
    create_Iapp(arrays.T_Iapp, arrays.T_record);
[arrays.Post, arrays.Pre] = create_connections();

for i = 1 : params.n
    [arrays.V_line(:,i + 1), arrays.U_line(:,i + 1), arrays.G(:,i + 1), arrays.Isyn_line, arrays.Mask_line,...
        arrays.Iapp_v_full(:,:,i)] = step_Neurons(arrays.V_line(:,i), arrays.U_line(:,i), arrays.G(:,i), ...
        arrays.T_Iapp_met(i), arrays.Iapp, arrays.Isyn_line, arrays.Post, arrays.Pre, arrays.Iastro_neuron_line(:,i));
    
    [arrays.Neurons_activity(:,:,i), arrays.Spike(:,:,i)] = Neuro_active(arrays.G(:,i), arrays.Mask_line);
    
    [arrays.Ca(:,:,i + 1), arrays.H(:,:,i + 1), arrays.IP3(:,:,i + 1), arrays.Iastro_neuron, arrays.Ineuro] = ...
        step_Astro (arrays.Neurons_activity(:,:,i), arrays.Spike, arrays.Ineuro, i, arrays.Ca(:,:,i), arrays.H(:,:,i), ...
        arrays.IP3(:,:,i), arrays.Iastro_neuron);
    
    [arrays.Iastro_neuron_line(:,i+1), arrays.Ca_size_neuros(:,:,i)] = change_dimension (arrays.Ca(:,:,i), ...
        arrays.Iastro_neuron(:,:,i));
end

[arrays.video] = make_video (arrays.Ca_size_neuros, arrays.V_line, arrays.Iapp_v_full, arrays.T_record_met);
handle = implay(arrays.video,10);
cmap = jet(256);
handle.Visual.ColorMap.Map = cmap;
handle.Visual.ColorMap.UserRangeMin = -0.8;
handle.Visual.ColorMap.UserRangeMax = 0.3;

[accuracy, Acc] = count_accuracy(arrays.V_line, 3);
