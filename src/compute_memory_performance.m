function [performance] = compute_memory_performance(images, V_line, T_Iapp)
    params = model_parameters();
    
    num_learn_patterns = length(params.learn_order);
    pattern_shift = num_learn_patterns;
    
    learned_patterns = unique(params.learn_order);
    num_learned_patterns = length(learned_patterns);
    
    test_patterns = params.test_order;
    
    spike_count = zeros(params.quantity_neurons, num_learned_patterns);
    for j = 1:num_learned_patterns
        pattern_id = find(test_patterns == learned_patterns(j));
        for i = 1:params.quantity_neurons
            be = T_Iapp(pattern_shift + pattern_id,1);
            en = be + params.impact_astro;
            spike_count(i,j) = sum(V_line(i, be:en) > params.neuron_fired_thr - 1);
        end
    end
    
    spike_images = reshape(spike_count, params.mneuro, params.nneuro, []);
    mean_similarities = zeros(params.max_spikes_thr,1);
    spikes_thrs = (1:params.max_spikes_thr);
    for i = 1:params.max_spikes_thr
        spike_images_thr = spike_images > spikes_thrs(i);
        pattern_similarity = ...
            compute_images_similarity(images, spike_images_thr, learned_patterns);
        mean_similarities(i) = mean(pattern_similarity);
    end
    
    performance.spike_images = spike_images;
    [performance.mean_performance, id_best_thr] = max(mean_similarities);
    performance.best_thr = spikes_thrs(id_best_thr);
    performance.spike_images_best_thr = spike_images > performance.best_thr;
    performance.best_thr_freq = performance.best_thr / (params.impact_astro * params.step);
    performance.freq_images = spike_images / (params.impact_astro * params.step);
    
    performance.learned_pattern_similarities = ...
        compute_images_similarity(images, ...
            performance.spike_images_best_thr, ...
            learned_patterns);
end

function similarity = compute_image_similarity(true_image, estimated_image)
    pattern_mask = true_image == 1;
    background_mask = true_image == 0;
    n_pattern = sum(pattern_mask, 'all');
    n_background = sum(background_mask, 'all');
    n_true_pattern = sum(true_image(pattern_mask) == estimated_image(pattern_mask));
    n_true_background = sum(true_image(background_mask) == estimated_image(background_mask));
    similarity = (n_true_background / n_background + n_true_pattern / n_pattern) / 2;
end

function similarity = compute_images_similarity(images, spike_images, test_patterns)
    similarity = zeros(length(test_patterns), 1);
    for k = 1:length(test_patterns)
        estimated_image = spike_images(:,:,k);
        true_image = images{test_patterns(k)} < 127;
        similarity(k) = compute_image_similarity(true_image, estimated_image);
    end
end