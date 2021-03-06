clear
clc

TrainingSetInfo = importdata('./result/KaggleSquare.txt');

TrainingSetNum = length(TrainingSetInfo.data);
NonoiseResultName='../../Kaggle_image_preprocessed/'
 BinaryResultName = './result/KaggleBinary/';


for i = 1:TrainingSetNum
    
    imageNameNum = strfind(TrainingSetInfo.textdata{i, 1},'/');
    if ~isempty(imageNameNum)
        imageName=TrainingSetInfo.textdata{i, 1}((imageNameNum(1,4)+1):end);
        classifyName=TrainingSetInfo.textdata{i, 2};%TrainingSetInfo.textdata{i, 1}((classifyNameNum(1)):imageNameNum(1));
        mkdir(strcat(NonoiseResultName,classifyName));
        mkdir(strcat(BinaryResultName,classifyName));
    end
    
    img = imread(TrainingSetInfo.textdata{i, 1});
    img = 255-img;
%     imgbw = logical(img);
    imgbw = im2bw(img,3/255);
    L = bwareaopen(imgbw, 5);
    binaryName = [BinaryResultName classifyName '/' imageName];
    imwrite(L,binaryName);
    result = double(img) .* double(L);
    img5 = uint8(255-result);
%     imshow(img5);
    noNoiseName = [NonoiseResultName classifyName '/' imageName];
    imwrite(img5,noNoiseName);
end