function [Iastro_neuron_size_neurons_line, Ca1, zeros_array_n_spikes_neuro_line] ...
    = change_dimension (Ca, Iastro_neuron, zeros_array_n_spikes)
params = system_parameters();
km = 0;
for j = 1 : params.az : (params.mneuro - params.az)
    kmm = 0;
    for k = 1 : params.az : (params.nneuro - params.az)
        Iastro_neuron_size_neurons(j : j + params.az, k : k + params.az) = Iastro_neuron(j - km, k - kmm);
        Ca1(j : j + params.az, k : k + params.az) = Ca(j - km, k - kmm);
        zeros_array_n_spikes_neuro(j : j + params.az, k : k + params.az) = zeros_array_n_spikes(j - km, k - kmm);
        kmm = kmm + 2;
    end
    km = km + 2;
end
zeros_array_n_spikes_neuro_line = zeros_array_n_spikes_neuro(:)';
Iastro_neuron_size_neurons_line = Iastro_neuron_size_neurons(:)';
end