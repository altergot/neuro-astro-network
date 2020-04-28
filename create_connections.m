function [Post_line,Pre] = create_connections()
params = system_parameters();
Post = zeros(params.mneuro, params.nneuro, params.N_connections);
Post_for_one = zeros(params.mneuro, params.nneuro);
ties_stock = 1000 * params.N_connections;
for i = 1 : params.mneuro
    for j = 1 : params.nneuro
        XY = zeros(2, ties_stock, 'int8');
        R = random('exp', params.lambda, 1, ties_stock);
        fi = 2 * pi * rand(1, ties_stock);
        XY(1,:) = fix(R .* cos(fi));
        XY(2,:) = fix(R .* sin(fi));
        XY1 = unique(XY', 'row','stable');
        XY = XY1';
        n = 1;
        for k = 1 : ties_stock
            x = i + XY(1, k);
            y = j + XY(2, k);
            if (i == x && j == y)
                pp = 1;
            else pp = 0;
            end
            if (x > 0 && y > 0 && x <= params.mneuro && y <= params.nneuro && pp == 0)
                Post(i,j,n) = sub2ind(size(Post_for_one), x, y);
                n = n + 1;
            end
            if n > params.N_connections
                break
            end
        end
    end
end
Post2 = permute(Post, [3 1 2]);
Post_line = Post2(:)';
k = 1;
for i = 1 : params.N_connections : size(Post_line, 2)
    Pre(i : i + params.N_connections - 1) = k;
    k = k + 1;
end
end