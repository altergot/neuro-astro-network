function [neurons_activity, spike] = neurons_activity_fun(Met, mask)
params = system_parameters();
Met1 = reshape(Met,params.mneuro, params.nneuro);
mask1 = reshape(mask,params.mneuro, params.nneuro);
neurons_activity = zeros(params.mastro, params.nastro);
spike = zeros(params.mastro, params.nastro);
km = 0;
for j = 1 : params.az : (params.mneuro - params.az)
    kmm = 0;
    for k = 1 : params.az : (params.nneuro - params.az)
        neurons_activity(j - km, k - kmm) = sum (sum (Met1(j : j + params.az, k : k + params.az)));
        spike (j - km, k - kmm) = sum(sum(mask1(j : j + params.az, k : k + params.az)));
        kmm = kmm + 2;
    end
    km = km + 2;
end
end
