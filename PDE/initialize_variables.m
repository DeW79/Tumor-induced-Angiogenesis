function [n, c, f, X, Y, Nx, Ny, Nt, dx, dy, dt] = initialize_variables()
    % ��ʼ����������

    % ����
    epsilon1 = 0.45;
    epsilon2 = 0.45;
    epsilon3 = 0.001;
    k = 0.75;
    Nx = 200; % x�����������
    Ny = 200; % y�����������

    % ����Χ�ͼ��
    x = linspace(0, 1, Nx);
    y = linspace(0, 1, Ny);
    [X, Y] = meshgrid(x, y);
    
    % ʱ��&�ռ�
    dt = 0.0001; % ʱ�䲽��
    T = input('��������ʱ�� T ��ֵ: '); % �û�������ʱ��
    Nt = round(T / dt);
    dx = 1 / Nx;
    dy = 1 / Ny;

    % �û�ѡ��c��ȡֵ��ʽ
    choice = input('��ѡ�� c ��ȡֵ��ʽ��1: ֱ����, 2: Բ�Σ�: ');
    
    if choice == 1
        % ֱ����
        c = exp(-(1 - X).^2 / epsilon1);
    elseif choice == 2
        % Բ��
        c = calculate_c(X, Y); % �����µļ��㺯��
    else
        error('��Ч��ѡ�����������в�ѡ��1��2��');
    end
    
    f = k * exp(-X.^2 / epsilon2);
    n = exp(-X.^2 / epsilon3) .* sin(3 * pi * Y).^2;

    % �������г�ʼ����������
        fprintf('����������ʼ����ɡ�\n');
end