clc; clear; close all; warning off all;


folder_name = 'trainingg';
file_name = dir(fullfile(folder_name,'*.jpg'));
total_file = numel(file_name);

train_cr = zeros(total_file,4);

for n = 1:total_file
    Img = imread(fullfile(folder_name,file_name(n).name))
    Img_gray = rgb2gray(Img);
    bw = imbinarize(Img_gray,.9);

    bw = imcomplement(bw);

    bw = bwareaopen(bw,200);

    R = Img(:,:,1);
    G = Img(:,:,2);
    B = Img(:,:,3);
    R(~bw) = 0;
    G(~bw) = 0;
    B(~bw) = 0;
    RGB = cat(3,R,G,B);

 Red = sum(sum(R))/sum(sum(bw));
 Green = sum(sum(G))/sum(sum(bw));
 Blue = sum(sum(B))/sum(sum(bw));
 %mengisi ciri_merah dengan ciri hasil ekstraksi
 train_cr(n,1) = Red;
 train_cr(n,2) = Green;
 train_cr(n,3) = Blue;
end 

class_train = cell(total_file,1);


for k = 1:40
    class_train{k} = 'Almond London';
end

for k = 41:80
    class_train{k} = 'Bahulu';
end
for k = 81:120
    class_train{k} = 'Ketupat Palas';
end
for k = 121:160
    class_train{k} = 'Lemang';
end
for k = 161:200
    class_train{k} = 'Tart Nenas';
end
t = templateSVM('Standardize',true)
Mdl = fitcecoc(train_cr,class_train,'Learners',t,...
    'ClassNames',{'Almond London','Bahulu','Ketupat Palas','Lemang','Tart Nenas'});
%Mdl = fitcecoc(train_cr, class_train,'Learners',t...)
class_output = predict(Mdl,train_cr);

correct_num = 0;
for k = 1:total_file
    if isequal(class_output{k},class_train{k})
        correct_num = correct_num+1;
    end
end
training_accuracy = correct_num/total_file*100

save Mdl Mdl
