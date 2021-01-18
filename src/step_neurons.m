function [V, U, G, Isyn, mask,Iapp] = step_neurons(V, U, G, t_Iapp_met, array_Iapp, ...
    Isyn, Post, Pre, Iastro_neuron, I_poisson_noise)
    params = model_parameters();
    Iastro_neuron = double(Iastro_neuron);
    I_poisson_noise = double(I_poisson_noise);
    %% Input image as rectangle function of applied current to neuronal layer
    if t_Iapp_met == 0
        Iapp = zeros(params.mneuro, params.nneuro, 'uint8');
    else
        Iapp = array_Iapp(:, :, t_Iapp_met);
    end
    
    %% Izhikevich neuron model
    Iapp_line = Iapp(:);
    Iapp_line = double(Iapp_line);
    fired = find(V >= params.neuron_fired_thr);
    V(fired) = params.c;
    U(fired) = U(fired) + params.d;
    I_sum = Iapp_line + Isyn + I_poisson_noise;
    I_sum = min(I_sum, params.I_input_thr);
    V = V + params.step .* 1000 .* (0.04 .* V .^ 2 + 5 .* V + 140 + I_sum - U);
    U = U + params.step .* 1000 .* params.aa .* (params.b .* V - U);
    V = min(V, params.neuron_fired_thr);
    
    %% Glutamate (neurotransmitter model)
    del = zeros(params.quantity_neurons,1);
    del(V == params.neuron_fired_thr) = 1;
    G = G - params.step .* (params.alf .* G - params.k  .* del);
    
    %% Neuron synaptic currents
    S = 1 ./ (1 + exp((-V ./ params.ksyn)));
    Isyn = zeros(params.quantity_neurons, 1, 'double');
    mask = zeros(params.quantity_neurons, 1, 'logical');
    mask(V > params.neuron_fired_thr - 1) = 1;
    gsync = params.gsyn + Iastro_neuron(Post).* params.aep;
    Isync = gsync .* S(Pre) .* (params.Esyn - V(Post));
    for i = 1 : params.quantity_connections
        Isyn(Post(i)) = Isyn(Post(i)) + Isync(i);
    end
end
