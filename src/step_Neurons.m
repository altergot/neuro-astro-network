function [V, U, G, Isyn, mask,Iapp] = step_Neurons(V, U, G, t_Iapp_met, array_Iapp, ...
    Isyn, Post, Pre, Iastro_neuron)
params = system_parameters();
if t_Iapp_met == 0
    Iapp = zeros(params.mneuro, params.nneuro);
else
    Iapp = array_Iapp(:, :, t_Iapp_met);
end
Iapp_line = Iapp(:);
fired = find(V >= 30);
V(fired) = params.c;
U(fired) = U(fired) + params.d;
V = V + params.step .* 1000 .* (0.04 .* V .^ 2 + 5 .* V + 140 + Iapp_line + Isyn - U);
U = U + params.step .* 1000 .* params.aa .* (params.b .* V - U);
V (V > 30) = 30;
del = zeros(params.quantity_neurons,1);
del(V == 30) = 1;
G = G - params.step .* (params.alf .* G - params.k  .* del);
S = 1 ./ (1 + exp(( - V ./ params.ksyn)));
Isyn = zeros ( params.quantity_neurons, 1);
mask = zeros ( params.quantity_neurons, 1);
mask(V > 29) = 1;
gsync = params.gsyn + Iastro_neuron(Post).* params.aep;
Isync = gsync .* S(Pre) .* (params.Esyn - V(Post));
for i = 1 : params.quantity_connections
    Isyn(Post(i)) = Isyn(Post(i)) + Isync(i);
end
end