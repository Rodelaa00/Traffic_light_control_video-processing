clc;
close all;
clear all;

%splitting into frames
a=VideoReader('D:\Rodela\Slides\8th semester\MC Lab\matlab\Project\road.mp4');
for img = 1:a.NumberOfFrames;
    filename=strcat('D:\Rodela\Slides\8th semester\MC Lab\matlab\Project\frame\frames',num2str(img),'.png');
    b = read(a, img);
    imshow(b);
    imwrite(b,filename);
end

a=VideoReader('D:\Rodela\Slides\8th semester\MC Lab\matlab\Project\road2.mp4');
for img = 1:a.NumberOfFrames;
    filename=strcat('D:\Rodela\Slides\8th semester\MC Lab\matlab\Project\frame2\frames2_',num2str(img),'.png');
    b = read(a, img);
    imshow(b);
    imwrite(b,filename);
end

a=VideoReader('D:\Rodela\Slides\8th semester\MC Lab\matlab\Project\road3.mp4');
for img = 1:a.NumberOfFrames;
    filename=strcat('D:\Rodela\Slides\8th semester\MC Lab\matlab\Project\frame3\frames3_',num2str(img),'.png');
    b = read(a, img);
    imshow(b);
    imwrite(b,filename);
end

%image comparing
NumberOfimages=380;
prefix_image='D:\Rodela\Slides\8th semester\MC Lab\matlab\Project\frame\frames';
prefix_image2='D:\Rodela\Slides\8th semester\MC Lab\matlab\Project\frame2\frames2_';
prefix_image3='D:\Rodela\Slides\8th semester\MC Lab\matlab\Project\frame3\frames3_';%change the desired input image name here only
fileformat='.png';  
for num=1:NumberOfimages
  MV = imread(strcat(prefix_image,num2str(num),fileformat));
%MV = imread('D:\Rodela\Slides\8th semester\MC Lab\matlab\Project\test image\6th.png'); %To read image
MV1 = imread('D:\Rodela\Slides\8th semester\MC Lab\matlab\Project\test image\test1.png');
A = double(rgb2gray(MV));%convert to gray
B= double(rgb2gray(MV1));%convert 2nd image to gray
[height width] = size(A); %image size?
h1 = figure(1);
 %Foreground Detection
 thresh=11;
 fr_diff = abs(A-B);
 for j = 1:width
 for k = 1:height
 if (fr_diff(k,j)>thresh)
 fg(k,j) = A(k,j);
 else
 fg(k,j) = 0;
 end
 end
 end
 %subplot(2,2,1) , imagesc(MV), title (['Orignal Frame of road 1']);
 %subplot(2,2,2) , imshow(mat2gray(A)), title ('converted Frame');
 %subplot(2,2,3) , imshow(mat2gray(B)), title ('BACKGND Frame ');
36
 sd=imadjust(fg);% adjust the image intensity values to the color map
 level=graythresh(sd);
 m=imnoise(sd,'gaussian',0,0.025);% apply Gaussian noise
 k=wiener2(m,[5,5]);%filtering using Weiner filter
 bw=im2bw(k,level);
 bw2=imfill(bw,'holes');
 bw3 = bwareaopen(bw2,5000);
 labeled = bwlabel(bw3,8);
 cc=bwconncomp(bw3)
 Densityoftraffic = cc.NumObjects/(size(bw3,1)*size(bw3,2));
 blobMeasurements = regionprops(labeled,'all');
numberofcars1 = size(blobMeasurements, 1);
% subplot(2,2,4) , imagesc(labeled), title (['Foreground']);
 hold off;
 disp(numberofcars1);% display number of cars
 disp(Densityoftraffic);%display number of vehicles
 
 
 NV = imread(strcat(prefix_image2,num2str(num),fileformat));
%MV = imread('D:\Rodela\Slides\8th semester\MC Lab\matlab\Project\test image\6th.png'); %To read image
NV1 = imread('D:\Rodela\Slides\8th semester\MC Lab\matlab\Project\test image\test2.png');
A = double(rgb2gray(NV));%convert to gray
B= double(rgb2gray(NV1));%convert 2nd image to gray
[height width] = size(A); %image size?
h1 = figure(1);
 %Foreground Detection
 thresh=11;
 fr_diff = abs(A-B);
 for j = 1:width
 for k = 1:height
 if (fr_diff(k,j)>thresh)
 fg(k,j) = A(k,j);
 else
 fg(k,j) = 0;
 end
 end
 end
 %subplot(2,2,2) , imagesc(NV), title (['Orignal Frame of road 2']);
 %subplot(2,2,2) , imshow(mat2gray(A)), title ('converted Frame');
 %subplot(2,2,3) , imshow(mat2gray(B)), title ('BACKGND Frame ');
36
 sd=imadjust(fg);% adjust the image intensity values to the color map
 level=graythresh(sd);
 m=imnoise(sd,'gaussian',0,0.025);% apply Gaussian noise
 k=wiener2(m,[5,5]);%filtering using Weiner filter
 bw=im2bw(k,level);
 bw2=imfill(bw,'holes');
 bw3 = bwareaopen(bw2,5000);
 labeled = bwlabel(bw3,8);
 cc=bwconncomp(bw3)
 Densityoftraffic = cc.NumObjects/(size(bw3,1)*size(bw3,2));
 blobMeasurements = regionprops(labeled,'all');
numberofcars2 = size(blobMeasurements, 1);
 %subplot(2,2,4) , imagesc(labeled), title (['Foreground']);
 hold off;
 disp(numberofcars2);% display number of cars
 disp(Densityoftraffic);%display number of vehicles
 
 
 OV = imread(strcat(prefix_image3,num2str(num),fileformat));
%MV = imread('D:\Rodela\Slides\8th semester\MC Lab\matlab\Project\test image\6th.png'); %To read image
OV1 = imread('D:\Rodela\Slides\8th semester\MC Lab\matlab\Project\test image\test3.png');
A = double(rgb2gray(OV));%convert to gray
B= double(rgb2gray(OV1));%convert 2nd image to gray
[height width] = size(A); %image size?
h1 = figure(1);
 %Foreground Detection
 thresh=11;
 fr_diff = abs(A-B);
 for j = 1:width
 for k = 1:height
 if (fr_diff(k,j)>thresh)
 fg(k,j) = A(k,j);
 else
 fg(k,j) = 0;
 end
 end
 end
 %subplot(2,2,3) , imagesc(OV), title (['Orignal Frame of road 3']);
% subplot(2,2,2) , imshow(mat2gray(A)), title ('converted Frame');
 %subplot(2,2,3) , imshow(mat2gray(B)), title ('BACKGND Frame ');
36
 sd=imadjust(fg);% adjust the image intensity values to the color map
 level=graythresh(sd);
 m=imnoise(sd,'gaussian',0,0.025);% apply Gaussian noise
 k=wiener2(m,[5,5]);%filtering using Weiner filter
 bw=im2bw(k,level);
 bw2=imfill(bw,'holes');
 bw3 = bwareaopen(bw2,5000);
 labeled = bwlabel(bw3,8);
 cc=bwconncomp(bw3)
 Densityoftraffic = cc.NumObjects/(size(bw3,1)*size(bw3,2));
 blobMeasurements = regionprops(labeled,'all');
numberofcars3 = size(blobMeasurements, 1);
 %subplot(2,2,4) , imagesc(labeled), title (['Foreground']);
 hold off;
 disp(numberofcars3);% display number of cars
 disp(Densityoftraffic);%display number of vehicles
 
 if numberofcars1>numberofcars2 && numberofcars1>numberofcars3
     subplot(2,2,1) , imagesc(MV), title (['green light on road 1']);
     
  fprintf('green light on road 1\n');
  if numberofcars2>numberofcars3
  fprintf('yellow light on road 2\n');
  fprintf('red light on road 3\n');
  subplot(2,2,2) , imagesc(NV), title (['yellow light on road 2']);
     subplot(2,2,3) , imagesc(OV), title (['red light on road 3']);
  else
      fprintf('yellow light on road 3\n');
      fprintf('red light on road 2\n');
       subplot(2,2,2) , imagesc(OV), title (['yellow light on road 3']);
       subplot(2,2,3) , imagesc(NV), title (['red light on road 2']);
    
  end
 end
if numberofcars2>numberofcars1 && numberofcars2>numberofcars3
   fprintf('green light on road 2\n');
   subplot(2,2,1) , imagesc(NV), title (['green light on road 2']);
  if numberofcars1>numberofcars3
  fprintf('yellow light on road 1\n');
  fprintf('red light on road 3\n');
  subplot(2,2,2) , imagesc(MV), title (['yellow light on road 1']);
     subplot(2,2,3) , imagesc(OV), title (['red light on road 3']);
  else
      fprintf('yellow light on road 3\n');
      fprintf('red light on road 1\n');
      subplot(2,2,2) , imagesc(OV), title (['yellow light on road 3']);
     subplot(2,2,3) , imagesc(MV), title (['red light on road 1']);
  end
end
 if numberofcars3>numberofcars1 && numberofcars3>numberofcars2
   fprintf('green light on road 3\n');
   subplot(2,2,1) , imagesc(OV), title (['green light on road 3']);
   
  if numberofcars2>numberofcars1
  fprintf('yellow light on road 2\n');
  fprintf('red light on road 1\n');
  subplot(2,2,2) , imagesc(NV), title (['yellow light on road 2']);
     subplot(2,2,3) , imagesc(MV), title (['red light on road 1']);
  else
      fprintf('yellow light on road 1\n');
      fprintf('red light on road 2\n');
      subplot(2,2,2) , imagesc(MV), title (['yellow light on road 1']);
     subplot(2,2,3) , imagesc(NV), title (['red light on road 2']);
  end
end
 
end