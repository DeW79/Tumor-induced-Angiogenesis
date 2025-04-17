function [c, f, n, X, Y, Nx, Ny] = initialize_cell_simulation()
    % ��ʼ����������

    % ����
    epsilon1 = 0.45; % TAFŨ�ȳ� c �Ĳ���
    epsilon2 = 0.45; % ��������Ũ�ȳ� f �Ĳ���
    k = 0.75;        % ��������Ũ�ȳ� f �ĳ���
    Nx = 200;        % x�����������
    Ny = 200;        % y�����������

    % ����Χ�ͼ��
    x = linspace(0, 1, Nx);
    y = linspace(0, 1, Ny);
    [X, Y] = meshgrid(x, y);
    
    % TAFŨ�ȳ� c ����ɢ��ʽ
    c = exp(-(1 - X).^2 / epsilon1); % c(x, y, 0)

    % ��������Ũ�ȳ� f ����ɢ��ʽ
    f = k * exp(-X.^2 / epsilon2);   % f(x, y, 0)

    % ��ʼ��Ƥϸ��λ�ã��� y ���ϵ�λ�ã�
    cell_positions = [0.17, 0.3, 0.5, 0.65, 0.84]; % ��Ƥϸ���� y ���ϵ�λ��
    num_cells = length(cell_positions);
    
    % ��ʼ����Ƥϸ���� n
    n = zeros(Ny, Nx); % ����һ��ȫ��ľ�����Ϊ��Ƥϸ����

    % ��ϸ��λ���ϳ�ʼ��Ũ��
    for i = 1:num_cells
        y_position = cell_positions(i);
        % ȷ�� y_position �� [0, 1] ��Χ��
        if y_position >= 0 && y_position <= 1
            % ��Ӧ�� y ����
            y_index = round(Ny * y_position);
            % �� y ���ϵĶ�Ӧ x ֵ������������ѡ��һ���̶�ֵ���� x=0.5��
            x_index = 2; % ������ x=0.5 ��
            % ��ʼ����Ƥϸ��Ũ�ȣ�������Ϊ 1
            n(y_index, x_index) = 1; % ������Ҫ�趨��ʼŨ��
        end
    end

    fprintf('Ѫ����Ƥϸ��ģ�⻷��������ʼ����ɡ�\n');
end
