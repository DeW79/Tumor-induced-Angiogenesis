function [n, c, f] = solve_pde_system()

    [n, c, f, X, Y, Nx, Ny, Nt, dx, dy, dt] = initialize_variables();

    % 方程参数
    D = 0.00035;
    chi = 0.38;
    alpha = 0.6;
    rho = 0.34;
    beta = 0.01;
    gamma = 0.1;
    eta = 0.1;
    
    mode = input('请选择可视化模式（1: 结束时显示, 2: 连续显示）: ');

    % 时间步
    for t = 1:Nt      
        % 内部网格点的二阶导数和梯度
        n_laplacian = del2(n, dx, dy);
        [c_x, c_y] = gradient(c, dx, dy);
        [f_x, f_y] = gradient(f, dx, dy);

        chemotaxis_x = (chi ./ (1 + alpha * c)) .* c_x .* n;
        chemotaxis_y = (chi ./ (1 + alpha * c)) .* c_y .* n;
        div_chemotaxis = compute_divergence(chemotaxis_x, chemotaxis_y, dx, dy);
        
        haptotaxis_x = rho .* n .* f_x;
        haptotaxis_y = rho .* n .* f_y;
        div_haptotaxis = compute_divergence(haptotaxis_x, haptotaxis_y, dx, dy);
                     
        % 计算n的变化率：\nabla^2 n - 化学梯度 - 基质梯度
        dn_dt = D * n_laplacian - div_chemotaxis - div_haptotaxis;
        
        % 更新方程
        for i = 1:Nx
            for j = 1:Ny
                df_dt = beta * n(i, j) - gamma * n(i, j) * f(i, j);
                dc_dt = -eta * n(i, j) * c(i, j);

                n(i, j) = n(i, j) + dt * dn_dt(i, j);
                f(i, j) = f(i, j) + dt * df_dt;
                c(i, j) = c(i, j) + dt * dc_dt;
            end
        end
        
        if mode == 2 && mod(t, 100) == 0
            % 在每100个步骤更新一次图形
            visualize_results(X, Y, n, c, f, t);
        end
    end
    
    % 如果选择了结束时显示，最后再一次显示结果
    if mode == 1
        visualize_results(X, Y, n, c, f, t);
    end
    
    return;
end
