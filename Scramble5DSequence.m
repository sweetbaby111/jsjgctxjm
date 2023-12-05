function scrambleSequence = Scramble5DSequence(m, n, N)
scrambleSequence=zeros(512,512,8);
    % 参数设置
   a=14; b=0.5; c=2; d=2; l=6; f=4.5; h=3; j=0.5; p=15; k=0.423;
    
    % 初始值设置
    x0 = 0.1;
    y0 = 0.1;
    z0 = 0.1;
    w0 = 0.1;
    v0 = 0.1;
    
    % 初始化矩阵序列和状态变量
    chaosSequences = zeros(m, n, 8, N);
    x = x0 * ones(m, n, 8);
    y = y0 * ones(m, n, 8);
    z = z0 * ones(m, n, 8);
    w = w0 * ones(m, n, 8);
    v = v0 * ones(m, n, 8);
    
    % 生成八个矩阵序列
    for i = 1:N
        chaosSequences(:, :, 1) = x(:, :, 1);
        chaosSequences(:, :, 2) = x(:, :, 2);
        % 同时更新八个状态变量
        x_new = a * y - b * x + c * y .* z + y .* z .* w;
        y_new = d * x + l * y - x .* z - f * v - x .* z .* w;
        z_new = -h * z + y.^2 + x .* y .* w;
        w_new = -j * y .* z - p * w + x .* y .* z;
        v_new = k * (x + v);
        
        x = x_new;
        y = y_new;
        z = z_new;
        w = w_new;
        v = v_new;
    end
end
