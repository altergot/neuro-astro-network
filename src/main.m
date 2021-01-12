try
    tic;
    %% Initialization
    close all; clearvars;
    
    rng(42);
    
    params = model_parameters(true);
    model = init_model();
    
    %% Simulation
    [model] = simulate_model(model, params);
    
    %% Visualization of learning and testing processes
    %  Video consist of 3 frames (left to right):
    %  1. input pattern
    %  2. neuron layer
    %  3. astrocyte layer
    [model.video] = make_video(model.Ca_size_neuros, ...
        model.V_line, ...
        model.Iapp_v_full, ...
        model.T_record_met);
    
    show_video(model.video, struct('limits', [0, 255], 'fps', 30));
    
    %% Compute memory performance
    [memory_performance] = ...
        compute_memory_performance(model.images, model.V_line, model.T_Iapp);
    
    fprintf('Mean memory performance: %0.4f\n', memory_performance.mean_performance);
    fmt = repmat(' %0.4f',1,numel(memory_performance.learned_pattern_similarities));
    fprintf(['Memory performance per image: ', fmt, '\n'], ...
        memory_performance.learned_pattern_similarities);
    
    %% Predicted learned images
    show_video(memory_performance.freq_images); % by frequency
    show_video(memory_performance.spike_images_best_thr); % with threshold
    toc;
    
catch ME
    if (strcmp(ME.identifier,'MATLAB:nomem'))
        n = 7;
        if ~ischar(n)
            error('Out of memory. Please, increase the amount of available memory. \nThe minimum required amount of RAM is 16 GB.', class(n));
        end
    else
        rethrow(ME);
    end
end