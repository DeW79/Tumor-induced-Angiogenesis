function div_result = compute_divergence(expression_x, expression_y, dx, dy)
    % 计算表达式的散度
    % 输入参数：
    % expression_x: x方向的表达式
    % expression_y: y方向的表达式
    % dx, dy: 网格步长

    % 计算x方向的散度
    [div_x, ~] = gradient(expression_x, dx, dy);
    
    % 计算y方向的散度
    [~, div_y] = gradient(expression_y, dx, dy);
    
    % 总的散度
    div_result = div_x + div_y;
end
