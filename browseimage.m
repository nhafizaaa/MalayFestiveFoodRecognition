clc; clear; close all; warning off all;

% memanggil menu "browse file"
[file_name,folder_name]= uigetfile('*.jpg');
total_file = numel(file_name);

%jika ada nama file yang dipilih maka akan mengeksekusi
%ini
test_cr = zeros(total_file,4);

if ~isequal(file_name,0)
    %membaca file citra rgb
    Img = imread(fullfile(folder_name,file_name));
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

 test_cr(1,1) = Red;
 test_cr(1,2) = Green;
 test_cr(1,3) = Blue;


 load Mdl

 %memanggil kelas keluaran hasil pengujian 

class_output = predict(Mdl,test_cr);
 figure, imshow(Img)
 title({['File name: ',file_name],['Name:',class_output{1}]})

 if isequal(class_output{1},"almond london")
     cal = 110;
 elseif isequal(class_output{1},"bahulu")
     cal = 72;
 elseif isequal(class_output{1},"ketupat")
     cal = 124;
 elseif isequal(class_output{1},"lemang")
     cal = 80;
 elseif isequal(class_output{1},"tart nenas")
     cal = 70;

 disp(cal)
 end


else
    return
end