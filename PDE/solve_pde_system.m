function [n, c, f] = solve_pde_system()

    [n, c, f, X, Y, Nx, Ny, Nt, dx, dy, dt] = initialize_variables();

    % ���̲���
    D = 0.00035;
    chi = 0.38;
    alpha = 0.6;
    rho = 0.34;
    beta = 0.01;
    gamma = 0.1;
    eta = 0.1;
    
    mode = input('��ѡ����ӻ�ģʽ��1: ����ʱ��ʾ, 2: ������ʾ��: ');

    % ʱ�䲽
    for t = 1:Nt      
        % �ڲ������Ķ��׵������ݶ�
        n_laplacian = del2(n, dx, dy);
        [c_x, c_y] = gradient(c, dx, dy);
        [f_x, f_y] = gradient(f, dx, dy);

        chemotaxis_x = (chi ./ (1 + alpha * c)) .* c_x .* n;
        chemotaxis_y = (chi ./ (1 + alpha * c)) .* c_y .* n;
        div_chemotaxis = compute_divergence(chemotaxis_x, chemotaxis_y, dx, dy);
        
        haptotaxis_x = rho .* n .* f_x;
        haptotaxis_y = rho .* n .* f_y;
        div_haptotaxis = compute_divergence(haptotaxis_x, haptotaxis_y, dx, dy);
                     
        % ����n�ı仯�ʣ�\nabla^2 n - ��ѧ�ݶ� - �����ݶ�
        dn_dt = D * n_laplacian - div_chemotaxis - div_haptotaxis;
        
        % ���·���
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
            % ��ÿ100���������һ��ͼ��
            visualize_results(X, Y, n, c, f, t);
        end
    end
    
    % ���ѡ���˽���ʱ��ʾ�������һ����ʾ���
    if mode == 1
        visualize_results(X, Y, n, c, f, t);
    end
    
    return;
end
