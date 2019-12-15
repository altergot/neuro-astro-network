function [Ca, h, IP3, Iastro_neuron, array_I_neuro, zeros_array_n_spikes]...
    = step_Astro (neurons_activity, spike, array_I_neuro, i, Ca, h, IP3, Iastro_neuron)
params = system_parameters();
zeros_array_n_spikes = ones( params.mastro, params.nastro);
for j = 1 : params.mastro
    for k = 1 : params.nastro
        if neurons_activity(j, k) > params.min_neurons_activity
            array_I_neuro(j, k, i : i + params.t_neuro / params.step - 1) = params.amplitude_neuro;
            zeros_array_n_spikes(j, k) = 0;
        end
        
        if (j == 1) && (k == 1)
            sum_Ca = Ca(j + 1, k) + Ca(j,k + 1) - 2 * Ca(j,k);
            sum_IP3 = IP3(j + 1, k) + IP3(j,k + 1) - 2 * IP3(j,k);
        elseif (j == 26) && (k == 26)
            sum_Ca = Ca(j - 1, k) + Ca(j,k - 1) - 2 * Ca(j,k);
            sum_IP3 = IP3(j - 1, k) + IP3(j,k - 1) - 2 * IP3(j,k);
        elseif (j == 1) && (k == 26)
            sum_Ca = Ca(j + 1, k) + Ca(j,k - 1) - 2 * Ca(j,k);
            sum_IP3 = IP3(j + 1, k) + IP3(j,k - 1) - 2 * IP3(j,k);
        elseif (j == 26) && (k == 1)
             sum_Ca = Ca(j - 1, k) + Ca(j,k + 1) - 2 * Ca(j,k);
            sum_IP3 = IP3(j - 1, k) + IP3(j,k + 1) - 2 * IP3(j,k);
        elseif j == 1
             sum_Ca = Ca(j + 1, k) + Ca(j, k - 1) + Ca(j,k + 1) - 3 * Ca(j,k);
            sum_IP3 = IP3(j + 1, k) + IP3(j, k - 1) + IP3(j,k + 1) - 3 * IP3(j,k);
        elseif j == 26
             sum_Ca = Ca(j - 1, k) + Ca(j, k - 1) + Ca(j,k + 1) - 3 * Ca(j,k);
            sum_IP3 = IP3(j - 1, k) + IP3(j, k - 1) + IP3(j,k + 1) - 3 * IP3(j,k);
        elseif k == 1
             sum_Ca = Ca(j - 1, k) + Ca(j + 1, k) + Ca(j,k + 1) - 3 * Ca(j,k);
            sum_IP3 = IP3(j - 1, k) + IP3(j + 1, k) + IP3(j,k + 1) - 3 * IP3(j,k);
        elseif k == 26
             sum_Ca = Ca(j - 1, k) + Ca(j + 1, k) + Ca(j,k - 1) - 3 * Ca(j,k);
            sum_IP3 = IP3(j - 1, k) + IP3(j + 1, k) + IP3(j,k - 1) - 3 * IP3(j,k);
        elseif (j > 1) && (j < 26) && (k > 1) && (k < 26)
            sum_Ca = Ca(j - 1, k) + Ca(j + 1, k) + Ca(j, k - 1) + Ca(j,k + 1) - 4 * Ca(j,k);
            sum_IP3 = IP3(j - 1, k) + IP3(j + 1, k) + IP3(j, k - 1) + IP3(j,k + 1) - 4 * IP3(j,k);
        end
        
        X = [Ca(j, k) h(j, k) IP3(j, k)];
        I_neuro = array_I_neuro(j, k, i);
        w1 = runge_astro(0, X,                   I_neuro, sum_Ca, sum_IP3);
        w2 = runge_astro(0, X + params.u2 .*w1', I_neuro, sum_Ca, sum_IP3);
        w3 = runge_astro(0, X + params.u2 .* w2', I_neuro, sum_Ca, sum_IP3);
        w4 = runge_astro(0, X + params.step .* w3', I_neuro, sum_Ca, sum_IP3);
        X = X + params.u6 .* (w1' + 2 .* w2' + 2 .* w3' + w4');
        Ca(j, k) = X(1);
        h(j, k) = X(2);
        IP3(j, k) = X(3);
        bnh = rem(i, params.shift_window_astro_watch);
        if (Ca(j, k) > params.threshold_Ca) && (bnh == 0 )
            Fin = any(spike(j, k, (i - params.window_astro_watch) : i) > params.min_neurons_activity);
            if Fin > 0
                Iastro_neuron(j, k, i : i + params.impact_astro) = 1;
            end
        end
    end
end
end