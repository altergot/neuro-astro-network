function [V, U, is_active, n_spikes, Met, gsync_sum, Isyn, mask,Iapp, gsync] = step_Neurons ...
    (V, U, t_Iapp_met, array_Iapp, Isyn, is_active, n_spikes, Met, Zone, line_index,...
    Iastro_neuron,zeros_array_n_spikes_line,gsync)
params = system_parameters();
if t_Iapp_met == 0
    Iapp = zeros(params.mneuro, params.nneuro);
else
    Iapp = array_Iapp(:, :, t_Iapp_met);
end
Iapp_line = Iapp(:);
n_spikes = zeros_array_n_spikes_line' .* n_spikes;
fired = find(V >= 30);
V(fired) = params.c;
U(fired) = U(fired) + params.d;
V = V + params.step .* 1000 .* (0.04 .* V .^ 2 + 5 .* V + 140 + Iapp_line + Isyn - U); 
U = U + params.step .* 1000 .* params.aa .* (params.b .* V - U);
V (V > 30) = 30;
S = 1 ./ (1 + exp(( - V ./ params.ksyn)));
Isyn = zeros ( params.quantity_neurons, 1);
mask = zeros ( params.quantity_neurons, 1);
mask(V > 29) = 1;
is_active = (1 - params.step * params.beta) .* is_active;
is_active = min(1, is_active + 0.1) .* mask + is_active .* ~mask;
n_spikes = n_spikes + mask;
Met (n_spikes >= params.min_n_spikes) = 1;
gsync_sum = zeros (1, params.quantity_neurons);
if (params.regime == 1) || (params.regime == 3)
delta_gsync = params.gsyn .* is_active(Zone) .* is_active(line_index);
gsync = gsync + delta_gsync .* params.step - gsync .* V(Zone) .* params.step ./ params.tao;
gsync = min(gsync, 0.05);
elseif params.regime == 2 
gsync = params.gsyn;
end
gsync = gsync + Iastro_neuron(Zone).* params.aep;
Isync = gsync .* S(line_index) .* (params.Esyn - V(Zone));
for i = 1 : params.quantity_connections
    gsync_sum(Zone(i)) = gsync_sum(Zone(i)) + gsync(i);
    Isyn(Zone(i)) = Isyn(Zone(i)) + Isync(i);
end
end