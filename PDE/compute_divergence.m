function div_result = compute_divergence(expression_x, expression_y, dx, dy)
    % ������ʽ��ɢ��
    % ���������
    % expression_x: x����ı��ʽ
    % expression_y: y����ı��ʽ
    % dx, dy: ���񲽳�

    % ����x�����ɢ��
    [div_x, ~] = gradient(expression_x, dx, dy);
    
    % ����y�����ɢ��
    [~, div_y] = gradient(expression_y, dx, dy);
    
    % �ܵ�ɢ��
    div_result = div_x + div_y;
end
