function visualize_results(X, Y, n, c, f, t)
    % 可视化结果的函数
    % X, Y: 网格坐标
    % n, c, f: 需要可视化的场函数
    % t: 当前时间步

    clf; % 清除当前图形
    subplot(1, 3, 1);
    surf(X, Y, n);
    title(['n(x, y) at step ', num2str(t)]);
    xlabel('x'); ylabel('y'); zlabel('n');
    shading interp;
    axis equal; % 保持 x 和 y 轴比例相同
    view(2);

    subplot(1, 3, 2);
    surf(X, Y, c);
    title(['c(x, y) at step ', num2str(t)]);
    xlabel('x'); ylabel('y'); zlabel('c');
    shading interp;
    axis equal; % 保持 x 和 y 轴比例相同

    subplot(1, 3, 3);
    surf(X, Y, f);
    title(['f(x, y) at step ', num2str(t)]);
    xlabel('x'); ylabel('y'); zlabel('f');
    shading interp;
    axis equal; % 保持 x 和 y 轴比例相同

    pause(0.1); % 暂停以便于观察
end
