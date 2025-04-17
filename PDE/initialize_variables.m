function [n, c, f, X, Y, Nx, Ny, Nt, dx, dy, dt] = initialize_variables()
    % 初始化环境变量

    % 参数
    epsilon1 = 0.45;
    epsilon2 = 0.45;
    epsilon3 = 0.001;
    k = 0.75;
    Nx = 200; % x方向网格点数
    Ny = 200; % y方向网格点数

    % 网格范围和间距
    x = linspace(0, 1, Nx);
    y = linspace(0, 1, Ny);
    [X, Y] = meshgrid(x, y);
    
    % 时间&空间
    dt = 0.0001; % 时间步长
    T = input('请输入总时间 T 的值: '); % 用户输入总时间
    Nt = round(T / dt);
    dx = 1 / Nx;
    dy = 1 / Ny;

    % 用户选择c的取值方式
    choice = input('请选择 c 的取值方式（1: 直线形, 2: 圆形）: ');
    
    if choice == 1
        % 直线形
        c = exp(-(1 - X).^2 / epsilon1);
    elseif choice == 2
        % 圆形
        c = calculate_c(X, Y); % 调用新的计算函数
    else
        error('无效的选择。请重新运行并选择1或2。');
    end
    
    f = k * exp(-X.^2 / epsilon2);
    n = exp(-X.^2 / epsilon3) .* sin(3 * pi * Y).^2;

    % 返回所有初始化环境变量
        fprintf('环境变量初始化完成。\n');
end