function [neurons_activity, Spike] = Neuro_active(G, Mask_line)
params = system_parameters();
M = zeros(1,params.quantity_neurons);
for j = 1: params.quantity_neurons
    if (G(j,1) >= 0.1)
        M(1,j) = 1;
    end
end
mask1 = reshape(Mask_line, params.mneuro, params.nneuro);
Met1 = reshape(M,params.mneuro, params.nneuro);
neurons_activity = zeros(params.mastro, params.nastro);
Spike = zeros(params.mastro, params.nastro);
km = 0;
for j = 1 : params.az : (params.mneuro - params.az)
    kmm = 0;
    for k = 1 : params.az : (params.nneuro - params.az)
        neurons_activity(j - km, k - kmm) = sum (sum (Met1(j : j + params.az, k : k + params.az)));
        Spike (j - km, k - kmm) = sum(sum(mask1(j : j + params.az, k : k + params.az)));
        kmm = kmm + 2;
    end
    km = km + 2;
end
end