function O = edge_detect(I, mode, options)
%UNTITLED3 Summary of this function goes here
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
        F = Gaussian_Filter(sigma_square,5);
        n_conv=1;
        
        
    end
    
    if n_conv==1
        O = lin_img_conv(I,F);
    elseif n_conv==2
        Gx = lin_img_conv(I, Fx);
        Gy = lin_img_conv(I, Fy);
        O = uint8(sqrt(Gx.^2 + Gy.^2));
    end
end

function F = Gaussian_Filter(sigma_square, sz)
    % Extra Credit for creating our own LoG filter!
    F = zeros(sz);
    vals = (-floor(sz/2):floor(sz/2));
    for F_row = 1:size(F,1)
        for F_col = 1:size(F,2)
            x = vals(F_row);
            y = vals(F_col);
            F(F_row,F_col) = Gaussian(x, y, sigma_square);
        end
    end
    % Normalize the matrix
    F = F.*(1/sum(F, 'all'));
    
end

function G = Gaussian(x,y,sigma_square)
    % Extra Credit for creating our own Gaussian generator!
    G = (1/(2*pi*sigma_square)*exp(-(x*x+y*y)/(2*sigma_square)));
end