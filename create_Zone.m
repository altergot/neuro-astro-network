function [Zone_syn_relation_1dimensional,line_index] = create_Zone()
params = system_parameters();
Zone_syn_relation = zeros(params.mneuro, params.nneuro, params.max_syn_relation);
Zone_syn_relation_for_one = zeros(params.mneuro, params.nneuro);
ties_stock = 20 * params.max_syn_relation;
for i = 1 : params.mneuro
    for j = 1 : params.nneuro
        XY = zeros(2, ties_stock, 'int8');
        R = random('exp', params.lambda, 1, ties_stock);
        R = fix(R);
        fi = 2 * pi * rand(1, ties_stock);
        XY(1,:) = fix(R .* cos(fi));
        XY(2,:) = fix(R .* sin(fi));
        n = 1;
        for k = 1 : ties_stock
            x = i + XY(1, k);
            y = j + XY(2, k);
            if (x > 0 && y > 0 && x <= params.mneuro && y <= params.nneuro ...
                    && x ~= i && y ~= j)
                Zone_syn_relation(i,j,n) = sub2ind(size(Zone_syn_relation_for_one), x, y);
                n = n + 1;
            end
            if n > params.max_syn_relation
                break
            end
        end
    end
end
Zone_syn_relation2 = permute(Zone_syn_relation, [3 1 2]);
Zone_syn_relation_1dimensional = Zone_syn_relation2(:)';
k = 1;
for i = 1 : params.max_syn_relation : size(Zone_syn_relation_1dimensional, 2)
    line_index(i : i + params.max_syn_relation - 1) = k;
    k = k + 1;
end
end