function O = edge_detect(I, mode, options)
%   Detailed explanation goes here
    if strcmp(mode,'sobel')
        Fx = [-1 0 1;-2 0 2;-1 0 1];
        Fy = [-1 -2 -1; 0 0 0; 1 2 1];
        n_conv = 2;
    elseif strcmp(mode, 'prewitt')
        Fx = [1 0 -1;1 0 -1;1 0 -1];
        Fy = [1 1 1;0 0 0;-1 -1 -1];
        n_conv = 2;
    elseif strcmp(mode, 'LoG')
        sigma_square = options(1);
        if (sigma_square >= 3); gs = 7; else; gs = 5; end
        F = fspecial('log', gs, sqrt(sigma_square));
        n_conv = 1;
    end
    
    if n_conv==1
        O = lin_img_conv(I,F);
    elseif n_conv==2
        Gx = lin_img_conv(I, Fx);
        Gy = lin_img_conv(I, Fy);
        O = uint8(sqrt(Gx.^2 + Gy.^2));
    end
end
