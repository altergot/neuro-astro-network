function [Iastro_neuron_expanded, Ca_expanded] = expand_astrocytes(Ca, Iastro_neuron)
    % Expands astrocyte calcium concentration and electrical currents 
    % to connected neurons
    params = model_parameters();
    km = 0;
    for j = 1 : params.az : (params.mneuro - params.az)
        kmm = 0;
        for k = 1 : params.az : (params.nneuro - params.az)
            Iastro_neuron_expanded(j : j + params.az, k : k + params.az) = ...
                Iastro_neuron(j - km, k - kmm);
            Ca_expanded(j : j + params.az, k : k + params.az) = ...
                Ca(j - km, k - kmm);
            kmm = kmm + 2;
        end
        km = km + 2;
    end
    Iastro_neuron_expanded = Iastro_neuron_expanded(:)';
end