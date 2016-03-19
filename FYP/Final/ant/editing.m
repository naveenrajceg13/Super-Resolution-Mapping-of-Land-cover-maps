function pso = pso2(class_number)
[mapsize,fn]=mapwindow();
a=imread(fn);
imshow(a);
[m1,n1,o1]=size(a);
m2=m1*mapsize;
n2=n1*mapsize;

xmatrix=zeros(m2,n2);


count=zeros(m2,n2);
inmatrix=zeros(mapsize,mapsize);

a=double(a);

b=zeros(m1,n1);

%find class proportions for each pixel and store in b matrix
for i=1:m1
    for j=1:n1
    temp=a(i,j); 
   
    b(i,j)=(temp/255)*100;
    b(i,j)=round(b(i,j));
    end
end
display(b);
bindex_i=1;
bindex_j=1;
max=mapsize*mapsize;
ants=randi([1,max]);
onecount=1;
for bindex_i=1:m1
    for bindex_j=1:n1
          uposition=1;
          vposition=1;
           shouldbe=round(((b(bindex_i,bindex_j)*mapsize*mapsize)/100));
             for lopvar=1:ants
                  for it=onecount:shouldbe
                           %getting some random number and finding
                           %upositiona and vposition
                           position=randi([1,max]);
                           if(mod(position,mapsize)==0)
                               
                                    uposition=ceil(position/mapsize);
                                    vposition=mapsize;
                               
                           else
                               
                                    uposition=ceil((position/mapsize))+1;
                                    vposition=mod(position,mapsize);
                               
                           end
                           
                           if(xmatrix(uposition,vposition)==class_number)
                                   it=it-1;
                                   continue;
                           end
                   
                 xmatrix(uposition,vposition)=class_number;
                 %counting the occurance of the class_number 
                 %to get the places that more ants visited 
                 count(uposition,vposition)=count(uposition,vposition)+1;
                 xmatrix=zeros(m2,n2);
                  end
             end             
     end
end

sort_array=zeros(1,mapsize*mapsize);
sort_position_x=zeros(1,mapsize*mapsize);
sort_position_y=zeros(1,mapsize*mapsize);

%Find the top sub-pixels with the highest attraction

for i=1:mapsize:m2
    for j=1:mapsize:n2
        k=1;
        for ii=i:i+(mapsize-1)
            for jj=j:j+(mapsize-1)
                sort_array(1,k)=count(ii,jj);
                sort_position_x(1,k)=ii;
                sort_position_y(1,k)=jj;
                k=k+1;
            end
        end
%         fprintf('%d %d\n',i,j);
%         display(sort_array);
%         display(sort_position_x);
%         display(sort_position_y);
        for k=1:8
            for l=k:8
                if(sort_array(1,k)<sort_array(1,l))
                    temp=sort_array(1,k);
                    sort_array(1,k)=sort_array(1,l);
                    sort_array(1,l)=temp;
                    
                    
                    temp=sort_position_x(1,k);
                    sort_position_x(1,k)=sort_position_x(1,l);
                    sort_position_x(1,l)=temp;
                    
                    
                    temp=sort_position_y(1,k);
                    sort_position_y(1,k)=sort_position_y(1,l);
                    sort_position_y(1,l)=temp;
                end
            end
         end
%         display(sort_array);
%         display(spsam);
        proportion=round((b(ceil(i/mapsize),ceil(j/mapsize))/100)*(mapsize*mapsize));
        for k=1:proportion
           xmatrix(sort_position_x(1,k),sort_position_y(1,k))=1.0; 
        end
        for ii=i:i+(mapsize-1)
            for jj=j:j+(mapsize-1)
                if xmatrix(ii,jj)~=1.0
                    xmatrix(ii,jj)=0.0;
                end
            end
        end
    end
end         
         
display(xmatrix);
imwrite(xmatrix,'ant_sample.jpg','jpeg');
%display(mixed_matrix);