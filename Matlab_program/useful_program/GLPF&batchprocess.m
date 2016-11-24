clear 
clc
fid = fopen('/media/scw4750/25a01ed5-a903-4298-87f2-a5836dcb6888/WHOI-MVCO/103_train_origin/103train.txt');
SetInfo = textscan(fid,'%s%d');
fclose(fid);
SetInfo = SetInfo{1,1};
SetNum = length(SetInfo);
TemplateResult = ('/media/scw4750/25a01ed5-a903-4298-87f2-a5836dcb6888/WHOI-MVCO/aaaGHPF');
for i = 1:SetNum
    imageNameNum = strfind(SetInfo{i,1},'/');
    classname = SetInfo{i,1}((imageNameNum(1,6)+1):(imageNameNum(1,7)-1));
    filename = strcat(TemplateResult,'/',classname);
    if ~exist(filename)
        mkdir(filename);
    end
    imgname = SetInfo{i,1}((imageNameNum(1,7)+1):end);
    impath = SetInfo{i,1};
    f = imread(impath);
    f = mat2gray(f,[0 255]);
    [M,N] = size(f);
    P = 2*M;
    Q = 2*N;
    fc = zeros(M,N);

    for x = 1:1:M
        for y = 1:1:N
            fc(x,y) = f(x,y) * (-1)^(x+y);
        end
    end
    F = fft2(fc,P,Q);
    H_1 = zeros(P,Q);
    for x = (-P/2):1:(P/2)-1
        for y = (-Q/2):1:(Q/2)-1
            D = (x^2 + y^2)^(0.5);
             D_0 = 30;
            H_1(x+(P/2)+1,y+(Q/2)+1) = 1- exp(-(D*D)/(2*D_0*D_0));   
        end
    end

    G_1 = H_1 .* F;

    g_1 = real(ifft2(G_1));
    g_1 = g_1(1:1:M,1:1:N);        

    for x = 1:1:M
        for y = 1:1:N
            g_1(x,y) = g_1(x,y) * (-1)^(x+y);
        end
    end
    resultimg = [TemplateResult '/' classname '/' imgname];
    imwrite(g_1,resultimg);
end  
