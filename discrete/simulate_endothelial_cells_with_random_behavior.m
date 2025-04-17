function simulate_endothelial_cells_with_random_behavior()
    % ����
    D = 0.00035;
    alpha = 0.6;
    chi = 0.38;
    rho = 0.34;
    beta = 0.05;
    gamma = 0.1;
    eta = 0.1;
    k = 0.001;  % ʱ�䲽��
    h = 1/200;  % ������

    [c, f, n, X, Y, Nx, Ny] = initialize_cell_simulation();

    % ģ�����
    T = 1;          % ��ģ��ʱ��
    num_steps = round(T / k);  % ��������

    % ����ͼ�δ��ڲ���ʼ�����ӻ�����
    ax1 = subplot(1, 3, 1); % ��ͼ 1
    surf_n = surf(ax1, X, Y, n);
    title(ax1, 'n(x, y)');
    xlabel(ax1, 'x'); ylabel(ax1, 'y'); zlabel(ax1, 'n');
    shading interp;
    axis equal;

    ax2 = subplot(1, 3, 2); % ��ͼ 2
    surf_c = surf(ax2, X, Y, c);
    title(ax2, 'c(x, y)');
    xlabel(ax2, 'x'); ylabel(ax2, 'y'); zlabel(ax2, 'c');
    shading interp;
    axis equal;

    ax3 = subplot(1, 3, 3); % ��ͼ 3
    surf_f = surf(ax3, X, Y, f);
    title(ax3, 'f(x, y)');
    xlabel(ax3, 'x'); ylabel(ax3, 'y'); zlabel(ax3, 'f');
    shading interp;
    axis equal;

    % ʱ�����
    for q = 1:num_steps
        % ���� c �� f ���ݶȣ����� P0 �� P4
        
        % �������������
        for l = 2:Nx-1
            for m = 2:Ny-1
                % ���ݸ����Ĺ�ʽ���� P0 �� P4
                P0 = 1 - (4 * k * D) / h^2 + (k * alpha * chi / (4 * h^2 * (1 + alpha * c(l,m)))) * ...
                    ((c(l+1,m) - c(l-1,m))^2 + (c(l,m+1) - c(l,m-1))^2) - ...
                    (k * chi / h^2) * (c(l+1,m) + c(l-1,m) - 4 * c(l,m) + c(l,m+1) + c(l,m-1)) - ...
                    (k * rho / h^2) * (f(l+1,m) + f(l-1,m) - 4 * f(l,m) + f(l,m+1) + f(l,m-1));

                P1 = (k * D) / h^2 - (k / (4 * h^2)) * (chi * (c(l+1,m) - c(l-1,m)) + rho * (f(l+1,m) - f(l-1,m)));
                P2 = (k * D) / h^2 + (k / (4 * h^2)) * (chi * (c(l+1,m) - c(l-1,m)) + rho * (f(l+1,m) - f(l-1,m)));
                P3 = (k * D) / h^2 - (k / (4 * h^2)) * (chi * (c(l,m+1) - c(l,m-1)) + rho * (f(l,m+1) - f(l,m-1)));
                P4 = (k * D) / h^2 + (k / (4 * h^2)) * (chi * (c(l,m+1) - c(l,m-1)) + rho * (f(l,m+1) - f(l,m-1)));

                % ���� R0 �� R4���ۻ����ʣ�
                R1 = P0;
                R2 = R1 + P1;
                R3 = R2 + P2;
                R4 = R3 + P3;
                R_final = R4 + P4;

                % ����һ���������������Ϊ
                rand_num = rand() * R_final;
                
                % �����������ֵ�ж��˶���Ϊ
                if rand_num < R1
                    % R0�����ֲ���
                    n(l,m) = n(l,m); 
                elseif rand_num < R2
                    % R1�������ƶ�
                    if l > 1
                        n(l-1,m) = n(l-1,m) + n(l,m);
                        n(l,m) = 0;  % ��յ�ǰλ��
                    end
                elseif rand_num < R3
                    % R2�������ƶ�
                    if l < Nx
                        n(l+1,m) = n(l+1,m) + n(l,m);
                        n(l,m) = 0;
                    end
                elseif rand_num < R4
                    % R3�������ƶ�
                    if m < Ny
                        n(l,m+1) = n(l,m+1) + n(l,m);
                        n(l,m) = 0;
                    end
                else
                    % R4�������ƶ�
                    if m > 1
                        n(l,m-1) = n(l,m-1) + n(l,m);
                        n(l,m) = 0;
                    end
                end
                
                % ���� f ��
                f(l,m) = f(l,m) * (1 - k * gamma * n(l,m)) + k * beta * n(l,m);

                % ���� c ��
                c(l,m) = c(l,m) * (1 - k * eta * n(l,m));
            end
        end
        
        % ���¿��ӻ����ݣ�ÿ100������һ��
        if mod(q, 100) == 0 || q == num_steps
            set(surf_n, 'ZData', n); % ����n��
            set(surf_c, 'ZData', c); % ����c��
            set(surf_f, 'ZData', f); % ����f��
            drawnow;  % ǿ��ˢ����ʾ
        end
    end
end
