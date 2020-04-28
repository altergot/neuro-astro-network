function [params] = system_parameters(need_set)
persistent params_p
if nargin < 1 || ~need_set
    params = params_p;
    return;
end
params = struct;

%% Runge-Kutta
params.step = 0.0001;
params.t_end = 1.6;
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
params.alf = 50;
params.k = 600;

%% synaptic connection parameters
params.N_connections = 40; %maximum number of connections between neurons
params.quantity_connections = params.quantity_neurons * params.N_connections;
params.lambda = 7; %average exponential distribution 10
params.beta = 5;
params.gsyn = 0.025;
params.aep = 0.25; %astrocyte effect parameter
params.Esyn = 0;
params.ksyn = 0.2;

%% Iapp
params.variance_learn = 0.05;
params.variance_test = 0.2;
params.Iapp_learn = 80;
params.Iapp_test = 8;

%% I
params.dCa = 0.05;
params.dIP3 = 0.05;
params.enter_astro = 8;
params.min_neurons_activity = 12;
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