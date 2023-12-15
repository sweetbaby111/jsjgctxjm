function BitEncryptionImg = PlaneEncryption(PlainImg)
    % ��ȡͼ���С
    [rows, cols] = size(PlainImg);

    % ��ͼ�����λƽ��ֽ�
    I_bitPlanes = zeros(rows, cols, 8);
    I_bitPlanes(:,:,1) = bitget(PlainImg, 1); % λƽ��ֽ⣬�õ���СΪ rows x cols x 8 ��λƽ�����
    I_bitPlanes(:,:,2) = bitget(PlainImg, 2);
    I_bitPlanes(:,:,3) = bitget(PlainImg, 3);
    I_bitPlanes(:,:,4) = bitget(PlainImg, 4);
    I_bitPlanes(:,:,5) = bitget(PlainImg, 5);
    I_bitPlanes(:,:,6) = bitget(PlainImg, 6);
    I_bitPlanes(:,:,7) = bitget(PlainImg, 7);
    I_bitPlanes(:,:,8) = bitget(PlainImg, 8);
%     for i = 1:8
%     figure;
%         imshow(I_bitPlanes(:,:,i));
%     end
%     disp(I_bitPlanes);
    % ���û���ϵͳ����������λƽ�棩
    a_high = 14; b_high = 0.5; c_high = 2; d_high = 2; l_high = 6;f_high=4.5; h_high=3; j_high=0.5; p_high=15; k_high=0.423;
    % ���û���ϵͳ����������λƽ�棬�߼�ӳ�䣩
    a_low = 4; b_low = 0.3; c_low = 1.5; d_low = 1;

    % ��ʼ��������Կ������������λƽ��
    key_high = zeros(rows * cols, 4);
    key_low = zeros(rows * cols, 4);
    
    % ��ʼ������ϵͳ״̬����������λƽ�棩
    x_high = 1; y_high = 0.25; z_high = 2; w_high = -1;v_high = 1.5;

    % ��ʼ������ϵͳ״̬����������λƽ�棬�߼�ӳ�䣩
    x_low = 0.1; y_low = 0.2;

    % ���ɻ����������ڼ��ܣ�����λƽ�棩
    for i = 1:rows * cols * 4
        x_high_new = a_high * y_high - b_high * x_high + c_high * y_high * z_high + y_high * z_high * w_high;
        y_high_new = d_high * x_high + l_high * y_high - x_high * z_high - f_high * v_high - x_high * z_high * w_high;
        z_high_new = -h_high * z_high + y_high^2 + x_high * y_high * w_high;
        w_high_new = -j_high * y_high * z_high - p_high * w_high + x_high * y_high * z_high;
        v_high_new = k_high * (x_high + v_high);

        x_high = mod(x_high_new, 1);
        y_high = mod(y_high_new, 1);
        z_high = mod(z_high_new, 1);
        w_high = mod(w_high_new, 1);
        v_high = mod(v_high_new, 1);

        % ����������ӳ�䵽 [0, 1] ���䣬�õ���Կ���󣨸���λƽ�棩
        key_high(i) = (x_high + y_high + z_high + w_high + v_high) / 4;
    end

    % ���ɻ����������ڼ��ܣ�����λƽ�棬�߼�ӳ�䣩
    for i = 1:rows * cols * 4
        x_low_new = a_low * x_low * (1 - x_low);
        y_low_new = b_low * x_low;
        
        x_low = mod(x_low_new, 1);
        y_low = mod(y_low_new, 1);

        % ����������ӳ�䵽 [0, 1] ���䣬�õ���Կ���󣨵���λƽ�棬�߼�ӳ�䣩
        key_low(i) = (x_low + y_low) / 2;
    end
    
    % ����Կ����任Ϊ��λƽ�������ͬ��С�ľ��󣬱�������
    key_matrix_high = reshape(key_high, rows, cols, 4);
    key_matrix_low = reshape(key_low, rows, cols, 4);
    
    % ���Ҹ���λƽ��
    for i = 5:8
        I_bitPlanes(:,:,i) = bitxor(I_bitPlanes(:,:,i), logical(key_matrix_high(:,:,i-4)));
        
    end
    
    % ���ҵ���λƽ�棨�߼�ӳ�䣩
    for i = 1:4
        I_bitPlanes(:,:,i) = bitxor(I_bitPlanes(:,:,i), logical(round(key_matrix_low(:,:,i))));
    end
    
    % �����ܺ��λƽ��ϲ�Ϊͼ��
    BitEncryptionImg = uint8(0);
    for i = 1:8
        BitEncryptionImg = bitor(BitEncryptionImg, uint8(I_bitPlanes(:,:,i)) * 2^(i-1));
    end
end
