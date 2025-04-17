function [c, f, n, X, Y, Nx, Ny] = initialize_cell_simulation()
    % 初始化环境变量

    % 参数
    epsilon1 = 0.45; % TAF浓度场 c 的参数
    epsilon2 = 0.45; % 纤连蛋白浓度场 f 的参数
    k = 0.75;        % 纤连蛋白浓度场 f 的常数
    Nx = 200;        % x方向网格点数
    Ny = 200;        % y方向网格点数

    % 网格范围和间距
    x = linspace(0, 1, Nx);
    y = linspace(0, 1, Ny);
    [X, Y] = meshgrid(x, y);
    
    % TAF浓度场 c 的离散形式
    c = exp(-(1 - X).^2 / epsilon1); % c(x, y, 0)

    % 纤连蛋白浓度场 f 的离散形式
    f = k * exp(-X.^2 / epsilon2);   % f(x, y, 0)

    % 初始上皮细胞位置（在 y 轴上的位置）
    cell_positions = [0.17, 0.3, 0.5, 0.65, 0.84]; % 上皮细胞在 y 轴上的位置
    num_cells = length(cell_positions);
    
    % 初始化上皮细胞场 n
    n = zeros(Ny, Nx); % 创建一个全零的矩阵作为上皮细胞场

    % 在细胞位置上初始化浓度
    for i = 1:num_cells
        y_position = cell_positions(i);
        % 确保 y_position 在 [0, 1] 范围内
        if y_position >= 0 && y_position <= 1
            % 对应的 y 索引
            y_index = round(Ny * y_position);
            % 在 y 轴上的对应 x 值的索引（可以选择一个固定值，如 x=0.5）
            x_index = 2; % 假设在 x=0.5 处
            % 初始化上皮细胞浓度，例如设为 1
            n(y_index, x_index) = 1; % 根据需要设定初始浓度
        end
    end

    fprintf('血管上皮细胞模拟环境变量初始化完成。\n');
end
