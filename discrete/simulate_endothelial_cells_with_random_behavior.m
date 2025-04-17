function simulate_endothelial_cells_with_random_behavior()
    % 参数
    D = 0.00035;
    alpha = 0.6;
    chi = 0.38;
    rho = 0.34;
    beta = 0.05;
    gamma = 0.1;
    eta = 0.1;
    k = 0.001;  % 时间步长
    h = 1/200;  % 网格间距

    [c, f, n, X, Y, Nx, Ny] = initialize_cell_simulation();

    % 模拟参数
    T = 1;          % 总模拟时间
    num_steps = round(T / k);  % 迭代次数

    % 创建图形窗口并初始化可视化对象
    ax1 = subplot(1, 3, 1); % 子图 1
    surf_n = surf(ax1, X, Y, n);
    title(ax1, 'n(x, y)');
    xlabel(ax1, 'x'); ylabel(ax1, 'y'); zlabel(ax1, 'n');
    shading interp;
    axis equal;

    ax2 = subplot(1, 3, 2); % 子图 2
    surf_c = surf(ax2, X, Y, c);
    title(ax2, 'c(x, y)');
    xlabel(ax2, 'x'); ylabel(ax2, 'y'); zlabel(ax2, 'c');
    shading interp;
    axis equal;

    ax3 = subplot(1, 3, 3); % 子图 3
    surf_f = surf(ax3, X, Y, f);
    title(ax3, 'f(x, y)');
    xlabel(ax3, 'x'); ylabel(ax3, 'y'); zlabel(ax3, 'f');
    shading interp;
    axis equal;

    % 时间迭代
    for q = 1:num_steps
        % 计算 c 和 f 的梯度，用于 P0 到 P4
        
        % 遍历所有网格点
        for l = 2:Nx-1
            for m = 2:Ny-1
                % 根据给定的公式计算 P0 到 P4
                P0 = 1 - (4 * k * D) / h^2 + (k * alpha * chi / (4 * h^2 * (1 + alpha * c(l,m)))) * ...
                    ((c(l+1,m) - c(l-1,m))^2 + (c(l,m+1) - c(l,m-1))^2) - ...
                    (k * chi / h^2) * (c(l+1,m) + c(l-1,m) - 4 * c(l,m) + c(l,m+1) + c(l,m-1)) - ...
                    (k * rho / h^2) * (f(l+1,m) + f(l-1,m) - 4 * f(l,m) + f(l,m+1) + f(l,m-1));

                P1 = (k * D) / h^2 - (k / (4 * h^2)) * (chi * (c(l+1,m) - c(l-1,m)) + rho * (f(l+1,m) - f(l-1,m)));
                P2 = (k * D) / h^2 + (k / (4 * h^2)) * (chi * (c(l+1,m) - c(l-1,m)) + rho * (f(l+1,m) - f(l-1,m)));
                P3 = (k * D) / h^2 - (k / (4 * h^2)) * (chi * (c(l,m+1) - c(l,m-1)) + rho * (f(l,m+1) - f(l,m-1)));
                P4 = (k * D) / h^2 + (k / (4 * h^2)) * (chi * (c(l,m+1) - c(l,m-1)) + rho * (f(l,m+1) - f(l,m-1)));

                % 计算 R0 到 R4（累积概率）
                R1 = P0;
                R2 = R1 + P1;
                R3 = R2 + P2;
                R4 = R3 + P3;
                R_final = R4 + P4;

                % 生成一个随机数来决定行为
                rand_num = rand() * R_final;
                
                % 根据随机数的值判断运动行为
                if rand_num < R1
                    % R0：保持不动
                    n(l,m) = n(l,m); 
                elseif rand_num < R2
                    % R1：向左移动
                    if l > 1
                        n(l-1,m) = n(l-1,m) + n(l,m);
                        n(l,m) = 0;  % 清空当前位置
                    end
                elseif rand_num < R3
                    % R2：向右移动
                    if l < Nx
                        n(l+1,m) = n(l+1,m) + n(l,m);
                        n(l,m) = 0;
                    end
                elseif rand_num < R4
                    % R3：向上移动
                    if m < Ny
                        n(l,m+1) = n(l,m+1) + n(l,m);
                        n(l,m) = 0;
                    end
                else
                    % R4：向下移动
                    if m > 1
                        n(l,m-1) = n(l,m-1) + n(l,m);
                        n(l,m) = 0;
                    end
                end
                
                % 更新 f 场
                f(l,m) = f(l,m) * (1 - k * gamma * n(l,m)) + k * beta * n(l,m);

                % 更新 c 场
                c(l,m) = c(l,m) * (1 - k * eta * n(l,m));
            end
        end
        
        % 更新可视化内容，每100步更新一次
        if mod(q, 100) == 0 || q == num_steps
            set(surf_n, 'ZData', n); % 更新n场
            set(surf_c, 'ZData', c); % 更新c场
            set(surf_f, 'ZData', f); % 更新f场
            drawnow;  % 强制刷新显示
        end
    end
end
