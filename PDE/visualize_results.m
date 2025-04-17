function visualize_results(X, Y, n, c, f, t)
    % ���ӻ�����ĺ���
    % X, Y: ��������
    % n, c, f: ��Ҫ���ӻ��ĳ�����
    % t: ��ǰʱ�䲽

    clf; % �����ǰͼ��
    subplot(1, 3, 1);
    surf(X, Y, n);
    title(['n(x, y) at step ', num2str(t)]);
    xlabel('x'); ylabel('y'); zlabel('n');
    shading interp;
    axis equal; % ���� x �� y �������ͬ
    view(2);

    subplot(1, 3, 2);
    surf(X, Y, c);
    title(['c(x, y) at step ', num2str(t)]);
    xlabel('x'); ylabel('y'); zlabel('c');
    shading interp;
    axis equal; % ���� x �� y �������ͬ

    subplot(1, 3, 3);
    surf(X, Y, f);
    title(['f(x, y) at step ', num2str(t)]);
    xlabel('x'); ylabel('y'); zlabel('f');
    shading interp;
    axis equal; % ���� x �� y �������ͬ

    pause(0.1); % ��ͣ�Ա��ڹ۲�
end
