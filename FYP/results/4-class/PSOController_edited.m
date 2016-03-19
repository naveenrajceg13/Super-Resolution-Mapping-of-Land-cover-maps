
flag=1;
classes=input('Enter the number of Classes');

display('choose the original image');
    if flag==1
       
        [mapsize,fn] = mapwindow();
        a=imread(fn);
        [m1,n1,o1]=size(a);
        m2=m1*mapsize;
        n2=n1*mapsize;
        mixed_matrix=zeros(m2,n2);
        pso_matrix=zeros(m2,n2,classes);
        flag=0;
    end
    
parfor i=1:classes
    pso_matrix(:,:,i)=pso2(i);
    str = int2str(i);
    imwrite(pso_matrix(:,:,i),strcat(str,'-pso.jpg'),'jpeg');
end
for i=1:classes
    for z=1:m2
        for y=1:n2
            if pso_matrix(z,y,i)~=0
                mixed_matrix(z,y)=(mixed_matrix(z,y)*10)+pso_matrix(z,y,i);
            end
        end
    end
    imwrite(mixed_matrix,'Mixed Matrix.jpg');
end

final_mixed_matrix = zeros(m2,n2,3);
div = round(255/classes);
step_value = div/3;

for i=1:m2
    for j=1:n2
        if mixed_matrix(i,j)==1
            final_mixed_matrix(i,j,1)=0;
            final_mixed_matrix(i,j,2)=150;
            final_mixed_matrix(i,j,3)=60;
        elseif mixed_matrix(i,j)==2
            final_mixed_matrix(i,j,1)=40;
            final_mixed_matrix(i,j,2)=0;
            final_mixed_matrix(i,j,3)=240;
        elseif mixed_matrix(i,j)==3
            final_mixed_matrix(i,j,1)=240;
            final_mixed_matrix(i,j,2)=150;
            final_mixed_matrix(i,j,3)=0;
        elseif mixed_matrix(i,j)==4
            final_mixed_matrix(i,j,1)=0;
            final_mixed_matrix(i,j,2)=0;
            final_mixed_matrix(i,j,3)=150;
        elseif mixed_matrix(i,j)==5
            final_mixed_matrix(i,j,1)=150;
            final_mixed_matrix(i,j,2)=0;
            final_mixed_matrix(i,j,3)=0;
        elseif mixed_matrix(i,j)==12
             final_mixed_matrix(i,j,1)=40;
            final_mixed_matrix(i,j,2)=0;
            final_mixed_matrix(i,j,3)=240;
        elseif mixed_matrix(i,j)==13
            final_mixed_matrix(i,j,1)=240;
            final_mixed_matrix(i,j,2)=150;
            final_mixed_matrix(i,j,3)=0;
        elseif mixed_matrix(i,j)==14
            final_mixed_matrix(i,j,1)=0;
            final_mixed_matrix(i,j,2)=0;
            final_mixed_matrix(i,j,3)=150;
        elseif mixed_matrix(i,j)==15
            final_mixed_matrix(i,j,1)=150;
            final_mixed_matrix(i,j,2)=0;
            final_mixed_matrix(i,j,3)=0;
         elseif mixed_matrix(i,j)==23
            final_mixed_matrix(i,j,1)=240;
            final_mixed_matrix(i,j,2)=150;
            final_mixed_matrix(i,j,3)=0;
         elseif mixed_matrix(i,j)==24
            final_mixed_matrix(i,j,1)=0;
            final_mixed_matrix(i,j,2)=0;
            final_mixed_matrix(i,j,3)=150;
         elseif mixed_matrix(i,j)==25
            final_mixed_matrix(i,j,1)=150;
            final_mixed_matrix(i,j,2)=0;
            final_mixed_matrix(i,j,3)=0; 
         elseif mixed_matrix(i,j)==34
            final_mixed_matrix(i,j,1)=0;
            final_mixed_matrix(i,j,2)=0;
            final_mixed_matrix(i,j,3)=150;
         elseif mixed_matrix(i,j)==35
            final_mixed_matrix(i,j,1)=150;
            final_mixed_matrix(i,j,2)=0;
            final_mixed_matrix(i,j,3)=0;
         elseif mixed_matrix(i,j)==45
            final_mixed_matrix(i,j,1)=150;
            final_mixed_matrix(i,j,2)=0;
            final_mixed_matrix(i,j,3)=0;
        elseif mixed_matrix(i,j)==123
            final_mixed_matrix(i,j,1)=240;
            final_mixed_matrix(i,j,2)=150;
            final_mixed_matrix(i,j,3)=0;
        elseif mixed_matrix(i,j)==234
            final_mixed_matrix(i,j,1)=240;
            final_mixed_matrix(i,j,2)=150;
            final_mixed_matrix(i,j,3)=0;
        elseif mixed_matrix(i,j)==345
            final_mixed_matrix(i,j,1)=0;
            final_mixed_matrix(i,j,2)=0;
            final_mixed_matrix(i,j,3)=150;
        elseif mixed_matrix(i,j)==1234
            final_mixed_matrix(i,j,1)=0;
            final_mixed_matrix(i,j,2)=150;
            final_mixed_matrix(i,j,3)=60;
        elseif mixed_matrix(i,j)==2345
            final_mixed_matrix(i,j,1)=240;
            final_mixed_matrix(i,j,2)=150;
            final_mixed_matrix(i,j,3)=0;
        elseif mixed_matrix(i,j)==12345
            final_mixed_matrix(i,j,1)=0;
            final_mixed_matrix(i,j,2)=150;
            final_mixed_matrix(i,j,3)=60;
        end
    end
end

imwrite(final_mixed_matrix,'Final Mixed Matrix.jpg','jpeg');
%display(mixed_matrix);