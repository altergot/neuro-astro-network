function [video] = make_video (Ca, V_line, Iapp, t_record_met)
params = system_parameters();
V = reshape(V_line, params.mneuro, params.nneuro, []);
Iapp = Iapp ./ 10;
V = V ./ 100;
Ca_v = Ca(:,:,t_record_met ~= 0);
V_v = V(:,:,t_record_met ~= 0);
Iapp_v = Iapp(:,:,t_record_met ~= 0);
video = horzcat(Iapp_v, V_v, Ca_v);
end