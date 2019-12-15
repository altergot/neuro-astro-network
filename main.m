close all; clearvars;
params = system_parameters(true);
arrays = system_arrays();
[arrays.Iapp, arrays.T_Iapp_met, arrays.T_record_met]  =...
    create_Iapp(arrays.T_Iapp,arrays.T_record);
[arrays.Zone_syn_relation, arrays.Line_index] = create_Zone();
tic
for i = 1 : params.n
    [arrays.V_line(:,i + 1), arrays.U_line(:,i + 1), arrays.Is_active_line, arrays.N_spikes_line,...
        arrays.Met_line(:,i), arrays.Gsync_sum(:,i + 1), arrays.Isyn_line, arrays.Mask_line,...
        arrays.Iapp_v_full(:,:,i),arrays.Gsync_line] = step_Neurons(arrays.V_line(:,i),...
        arrays.U_line(:,i), arrays.T_Iapp_met(i), arrays.Iapp, arrays.Isyn_line, ...
        arrays.Is_active_line, arrays.N_spikes_line, arrays.Met_line(:,i), arrays.Zone_syn_relation,...
        arrays.Line_index, arrays.Iastro_neuron_line(:,i), arrays.Make_n_spikes_zeros_line, arrays.Gsync_line);
    
    [arrays.Neurons_activity(:,:,i), arrays.Spike(:,:,i)] = neurons_activity_fun(arrays.Met_line(:,i),...
        arrays.Mask_line);
    
    [arrays.Ca(:,:,i + 1), arrays.H(:,:,i + 1), arrays.IP3(:,:,i + 1), arrays.Iastro_neuron, ...
        arrays.Ineuro, arrays.Make_n_spikes_zeros] = step_Astro (arrays.Neurons_activity(:,:,i),...
        arrays.Spike, arrays.Ineuro, i, arrays.Ca(:,:,i), arrays.H(:,:,i), arrays.IP3(:,:,i), arrays.Iastro_neuron);
    
    [arrays.Iastro_neuron_line(:,i+1), arrays.Ca_size_neuros(:,:,i), arrays.Make_n_spikes_zeros_line] = ...
        change_dimension (arrays.Ca(:,:,i), arrays.Iastro_neuron(:,:,i), arrays.Make_n_spikes_zeros);
    
    if rem(i, 100) == 0
        toc;
    end
end
[arrays.video] = make_video (arrays.Ca_size_neuros, arrays.V_line, arrays.Iapp_v_full, arrays.T_record_met);
handle = implay(arrays.video,10);
cmap = jet(256);
handle.Visual.ColorMap.Map = cmap;
handle.Visual.ColorMap.UserRangeMin = -0.8;
handle.Visual.ColorMap.UserRangeMax = 0.3;
toc;
% [arrays.accuracy] = count_accuracy(arrays.V_line);
% toc;
% plot(arrays.accuracy);