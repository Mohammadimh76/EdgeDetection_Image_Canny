clear; clc; close all; warning off;

I=imread('siahosefid.bmp');
I=imnoise(I, 'gaussian', 0, 0.001);
figure(1)
imshow(I);

A=filter2(fspecial('average',3),I)/255; 
figure(2)
imshow(A);

gauss_I=I;
Isize=size(I);
ans=zeros(size(I));
dir=zeros(size(I));
I=double(I);
gauss_I=double(gauss_I);
fx=0;
fy=0;
for i=2:Isize(1)-1
    for j=2:Isize(2)-1
        fx=gauss_I(i,j)+gauss_I(i,j+1)-gauss_I(i+1,j)-gauss_I(i+1,j+1);
        fy=gauss_I(i,j)+gauss_I(i+1,j)-gauss_I(i,j+1)-gauss_I(i+1,j+1);
        ans(i,j)=sqrt(fx*fx+fy*fy);
        dir(i,j)=atan(fy/fx);
    end
end
figure(3)
imshow(ans)

for i=2:Isize(1)-1
    for j=2:Isize(2)-1
        if dir(i,j)>=-pi/8 & dir(i,j)<pi/8
            if ans(i,j)<=ans(i,j-1) | ans(i,j)<=ans(i,j+1)
                ans(i,j)=0;
            end
        end
        if dir(i,j)>=pi/8 & dir(i,j)<3*pi/8
            if ans(i,j)<=ans(i-1,j+1) | ans(i,j)<=ans(i+1,j-1)
                ans(i,j)=0;
            end
        end
        if dir(i,j)>=3*pi/8 | dir(i,j)<-3*pi/8
            if ans(i,j)<=ans(i-1,j) | ans(i,j)<=ans(i+1,j)
                ans(i,j)=0;
            end
        end
        if dir(i,j)<-pi/8 & dir(i,j)>=3*pi/8
            if ans(i,j)<=ans(i-1,j-1) | ans(i,j)<=ans(i+1,j+1)
                ans(i,j)=0;
            end
        end
        if ans(i,j)<40
            ans(i,j)=0;
        else
            ans(i,j)=255;
        end
    end
end
figure(4)
imshow(ans)