clc; clear; close all; warning off all;


folder_name = 'testing latest';
file_name = dir(fullfile(folder_name,'*.jpg'));
total_file = numel(file_name);

test_cr = zeros(total_file,4);

% menginisiliasi variabel ciri_merah


%menginisialisasikan variabel ciri_latih
for n = 1:total_file
    %membaca file citra rgb
    Img = imread(fullfile(folder_name,file_name(n).name))
    Img_gray = rgb2gray(Img);
    bw = imbinarize(Img_gray,.9);

    bw = imcomplement(bw);
    bw = bwareaopen(bw,100);
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
 test_cr(n,1) = Red;
 test_cr(n,2) = Green;
 test_cr(n,3) = Blue;
end 
class_test = cell(total_file,1);

for k = 1:8
    class_test{k} = 'Almond London';
end

for k = 9:16
    class_test{k} = 'Bahulu';
end
for k = 17:24
    class_test{k} = 'Ketupat Palas';
end
for k = 25:32
    class_test{k} = 'Lemang';
end
for k = 33:40
   class_test{k} = 'Tart Nenas';
end
load Mdl
class_output = predict(Mdl,test_cr);
correct_num = 0;
for k = 1:total_file
    if isequal(class_output{k},class_test{k})
        correct_num = correct_num+1;
    end
end
testing_accuracy = correct_num/total_file*100
