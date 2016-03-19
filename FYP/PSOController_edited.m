
flag=true;
classes=input('Enter the number of Classes');
for i=1:classes
    if flag
        [mapsize,fn] = mapwindow();
        a=imread(fn);
        [m1,n1,o1]=size(a);
        m2=m1*mapsize;
        n2=n1*mapsize;
        mixed_matrix=zeros(m2,n2);
        pso_matrix=zeros(m2,n2,classes);
        flag=false
    else
        [mapsize,fn] = mapwindow();
    end
    
    pso_matrix(:,:,i)=pso2(fn,i,mapsize);
    imwrite(pso_matrix(:,:,i),strcat(int2str(i),'Class.jpg'));
    display(pso_matrix(:,:,i));
    for z=1:m2
        for y=1:n2
            if pso_matrix(z,y,i)~=0
                mixed_matrix(z,y)=(mixed_matrix(z,y)*10)+pso_matrix(z,y,i);
            end
        end
    end
end

display(mixed_matrix);

rcolor=zeros(50);
gcolor=zeros(50);
bcolor=zeros(50);
rcolor(1,1)=45;
bcolor(1,1)=241;
gcolor(1,1)=12;
rcolor(2,2)=241;
bcolor(2,2)=104;
gcolor(2,2)=12;
rcolor(3,3)=18;
gcolor(3,3)=44;
bcolor(3,3)=242;
rcolor(1,3)=193;
gcolor(1,3)=199;
bcolor(1,3)=245;
rcolor(2,3)=50;
gcolor(2,3)=56;
bcolor(2,3)=101;
rcolor(1,2)=150;
gcolor(1,2)=151;
bcolor(1,2)=154;
rcolor(1,23)=105;
gcolor(1,23)=111;
bcolor(1,23)=155;
final_matrix=zeros(m2,n2);
for i=1:m2
    for j=1:n2
        if(mixed_matrix(i,j)~=0)
        if(mixed_matrix(i,j)<10)
            final_matrix(i,j,1)=rcolor(mixed_matrix(i,j),mixed_matrix(i,j));
            final_matrix(i,j,2)=gcolor(mixed_matrix(i,j),mixed_matrix(i,j));
            final_matrix(i,j,3)=0;
        elseif(mixed_matrix(i,j)<100)
             fir_index=mixed_matrix(i,j)/10;
             fir_index=round(fir_index);
             sec_index=mod(mixed_matrix(i,j),10);
             final_matrix(i,j,1)=rcolor(fir_index,sec_index);
             final_matrix(i,j,2)=gcolor(fir_index,sec_index);
             final_matrix(i,j,3)=0;
        else
             final_matrix(i,j,1)=rcolor(1,23);
             final_matrix(i,j,2)=gcolor(1,23);
             final_matrix(i,j,3)=0;  
        end
        end
    end
end
display(final_matrix);
