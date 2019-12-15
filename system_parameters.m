function [params] = system_parameters(need_set)
    persistent params_p
    if nargin < 1 || ~need_set
        params = params_p;
        return;
    end
    params = struct;
    params.regime = 2; % 1 - astro && hebb
                     % 2 - only astro
                     % 3 - only hebb
    
    %% Runge-Kutta
    params.step = 0.0001;
    params.t_end = 1;
    params.u2 = params.step / 2;
    params.u6 = params.step / 6;
    params.n = fix(params.t_end / params.step);
    
    %% Network size
    params.mneuro = 79;
    params.nneuro = 79;
    params.quantity_neurons = params.mneuro * params.nneuro;
    params.mastro = 26;
    params.nastro = 26;
    az = 4; % astrosyte zone
    params.az = az-1;
    
    %% Initial conditions
    params.v_0 = -70;
    params.ca_0 = 0.072495;
    params.h_0 = 0.886314;
    params.ip3_0 = 0.820204;
    
    %% mode of neurons
    params.aa = 0.1; %FS
    params.b = 0.2;
    params.c = -65;
    params.d = 2;
    
    %% synaptic connection parameters
    params.max_syn_relation = 40; %maximum number of connections between neurons
    params.quantity_connections = params.quantity_neurons * params.max_syn_relation;
    params.lambda = 10; %average exponential distribution 10
    params.beta = 5;
    if params.regime == 1
        params.gsyn = 0.25;  %1 %10 %0.01 Ranshe
        params.aep = 0.25; %astrocyte effect parameter
    elseif params.regime == 2
        params.gsyn = 0.025;
        params.aep = 0.25; %astrocyte effect parameter
    elseif params.regime == 3
        params.gsyn = 10;
        params.aep = 0; %astrocyte effect parameter
    end
    params.Esyn = 0;
    params.ksyn = 0.2;
    
    params.tao = 0.5;
    %% Iapp
    params.variance_learn = 0.1;
    params.variance_test = 0.4;
    params.amplitude_Iapp = 80;
    
    %% I
    params.dCa = 0.05;
    params.dIP3 = 0.05;
    params.min_n_spikes = 7;
    params.min_neurons_activity = 8;
    params.t_neuro = 0.06;
    params.amplitude_neuro = 5;
    params.threshold_Ca = 0.15;
    window_astro_watch = 0.005; % t(sec)
    shift_window_astro_watch = 0.001; % t(sec)
    impact_astro = 0.020; % t(sec)
    params.impact_astro = impact_astro / params.step;
    params.window_astro_watch = window_astro_watch / params.step;
    params.shift_window_astro_watch = shift_window_astro_watch / params.step;
      
    params_p = params;
end