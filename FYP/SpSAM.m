
[filename, pathname]=uigetfile('*.*','Select a image');
  if isequal(filename,0) || isequal(pathname,0)
    fn='C:\Users\Naveen Raj\Downloads\multispec.jpg';
  else
    fn = fullfile(pathname, filename);
  end
  
  
a=imread(fn);
imshow(a);
[m1,n1,o1]=size(a);
mapsize=input('Enter size of the mapping window :');
m2=m1*mapsize;
n2=n1*mapsize;

outmap=zeros(m2,n2);


outmapp1=zeros(m2,n2);
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


spsam=zeros(m2,n2);
x1=1;
y1=1;
attraction=zeros(m1,n1);
up=0;down=0;left=0;right=0;upleft=0;upright=0;downleft=0;downright=0;
final_attraction=zeros(1,8);
xx=1;
yy=1;
for iii=1:m1
    for jjj=1:n1
        u=1;
        %finging the fraction of class present in neighbouring pixels
        attraction(iii,jjj)=0;
        up=0;down=0;left=0;right=0;upleft=0;upright=0;downleft=0;downright=0;
        if(((iii-1)<1)&&((jjj-1)<1))
                up=1;upleft=1;upright=1;downleft=1;left=1;
                 %fprintf('a(%d,%d)1,1',iii,jjj); 
                 %display(a(iii,jjj));                
        elseif(((iii+1)>m1)&&((jjj-1)<1))
                left=1;down=1;downleft=1;downright=1;upleft=1;
                %fprintf('a(%d,%d)3,1',iii,jjj); 
                %display(a(iii,jjj));
        elseif(((iii-1)<1)&&((jjj+1)>n1))
                right=1;downright=1;upright=1;up=1;upleft=1;
                %fprintf('a(%d,%d)1,3',iii,jjj); 
                %display(a(iii,jjj));
        elseif(((iii+1)>m1)&&((jjj+1)>n1))
                right=1;down=1;downleft=1;downright=1;upright=1;
                %fprintf('a(%d,%d)3,3',iii,jjj); 
                %display(a(iii,jjj));
        elseif(((iii-1)<1))
                up=1;upleft=1;upright=1;
                %fprintf('a(%d,%d)1,2',iii,jjj); 
                %display(a(iii,jjj));
        elseif(((jjj-1)<1))
                left=1;upleft=1;downleft=1;
                %fprintf('a(%d,%d)2,1',iii,jjj); 
                %display(a(iii,jjj));
        elseif(((iii+1)>m1))
                down=1;downright=1;downleft=1;
                %fprintf('a(%d,%d)3,2',iii,jjj); 
                %display(a(iii,jjj));
        elseif(((jjj+1)>n1))
                right=1;downright=1;upright=1;
                %fprintf('a(%d,%d)2,3',iii,jjj); 
                %display(a(iii,jjj));
        else
                up=0;down=0;left=0;right=0;upleft=0;upright=0;downleft=0;downright=0;
                %fprintf('a(%d,%d)',iii,jjj); 
                %display(a(iii,jjj));
        end
               % fprintf('\n for %d \n',a(iii,jjj));
        if(left==0)
             % fprintf('+%d \n',a(iii,jjj-1));
             attraction(iii,jjj)=attraction(iii,jjj)+b(iii,jjj-1);
             final_attraction(1,u)=b(iii,jjj-1);
             u=u+1;
        else
             final_attraction(1,u)=0;
             u=u+1;
        end
        if(upleft==0)
             % fprintf('+%d \n',a(iii-1,jjj-1));
             attraction(iii,jjj)=attraction(iii,jjj)+b(iii-1,jjj-1);
             final_attraction(1,u)=b(iii-1,jjj-1);
             u=u+1;
        else
             final_attraction(1,u)=0;
             u=u+1;
        end
        if(up==0)
             % fprintf('+%d \n',a(iii-1,jjj));
              attraction(iii,jjj)=attraction(iii,jjj)+b(iii-1,jjj);
              final_attraction(1,u)=b(iii-1,jjj);
              u=u+1;
        else
              final_attraction(1,u)=0;
              u=u+1;
        end
        if(upright==0)
               % fprintf('+%d \n',a(iii-1,jjj+1));
               attraction(iii,jjj)=attraction(iii,jjj)+b(iii-1,jjj+1);
               final_attraction(1,u)=b(iii-1,jjj+1);
               u=u+1;
        else
               final_attraction(1,u)=0;
               u=u+1;
        end
             
        if(right==0)
               % fprintf('+%d \n',a(iii,jjj+1));
               attraction(iii,jjj)=attraction(iii,jjj)+b(iii,jjj+1);
               final_attraction(1,u)=b(iii,jjj+1);
               u=u+1;
        else
               final_attraction(1,u)=0;
               u=u+1;
        end
              
        if(downright==0)
              % fprintf('+%d \n',a(iii+1,jjj+1));
               attraction(iii,jjj)=attraction(iii,jjj)+b(iii+1,jjj+1);
               final_attraction(1,u)=b(iii+1,jjj+1);
               u=u+1;
        else
               final_attraction(1,u)=0;
               u=u+1;
        end
        if(down==0)
               % fprintf('+%d \n',a(iii+1,jjj));
               attraction(iii,jjj)=attraction(iii,jjj)+b(iii+1,jjj);
               final_attraction(u)=b(iii+1,jjj);
               u=u+1;
        else
              final_attraction(1,u)=0;
               u=u+1;
        end
              
        if(downleft==0)
               % fprintf('+%d \n',a(iii+1,jjj-1));
               attraction(iii,jjj)=attraction(iii,jjj)+b(iii+1,jjj-1);
               final_attraction(1,u)=b(iii+1,jjj-1);
               u=u+1;
        else
               final_attraction(1,u)=0;
               u=u+1;
        end
        
        %Calculating the Center point of neighbouring pixels.
        nx=zeros(1,8);
        ny=zeros(1,8);
        
        if(jjj-1>=1)
            nx(1,1)=((jjj-2)*mapsize)+1+floor(mapsize/2);
            ny(1,1)=((iii-1)*mapsize)+1+floor(mapsize/2);
        end
        if(iii-1>=1 && jjj-1>=1)
             nx(1,2)=((jjj-2)*mapsize)+1+floor(mapsize/2);
             ny(1,2)=((iii-2)*mapsize)+1+floor(mapsize/2);
         end
         if(iii-1>=1)
             nx(1,3)=((jjj-1)*mapsize)+1+floor(mapsize/2);
             ny(1,3)=((iii-2)*mapsize)+1+floor(mapsize/2);
         end
         if(iii-1>=1 && jjj+1<=n1)
             nx(1,4)=((jjj)*mapsize)+1+floor(mapsize/2);
             ny(1,4)=((iii-2)*mapsize)+1+floor(mapsize/2);
         end
         if(jjj+1<=m1)
             nx(1,5)=((jjj)*mapsize)+1+floor(mapsize/2);
             ny(1,5)=((iii-1)*mapsize)+1+floor(mapsize/2);
         end
         if(iii+1<=m1 && jjj+1<=n1)
             nx(1,6)=((jjj)*mapsize)+1+floor(mapsize/2);
             ny(1,6)=((iii)*mapsize)+1+floor(mapsize/2);
         end
         if(iii+1<=m1)
             nx(1,7)=((jjj-1)*mapsize)+1+floor(mapsize/2);
             ny(1,7)=((iii)*mapsize)+1+floor(mapsize/2);
         end
         if(iii+1<=m1 && jjj-1>=1)
             nx(1,8)=((jjj-2)*mapsize)+1+floor(mapsize/2);
             ny(1,8)=((iii)*mapsize)+1+floor(mapsize/2);
         end
         
         modify_attraction=zeros(m2,n2);
         %display(final_attraction);
         for ii=xx:xx+2
             for jj=yy:yy+2
                 modify_attraction(ii,jj)=attraction(iii,jjj);
                 attr=0;
                 lambda=0;
                 lambdainv=0;
%                  fprintf('\n\n\n\n');
%                  display(final_attraction);
%                  display(nx);
%                  display(ny);
                 for k=1:8
                     if nx(1,k)==0 && ny(1,k)==0
                         continue;
                     end
                     lambdainv=sqrt(((ii-nx(1,k))*(ii-nx(1,k)))+((jj-ny(1,k))*(jj-ny(1,k))));
                     
                     %fprintf('(%d,%d) and (%d,%d)',ii,jj,nx(1,k),ny(1,k));
                      
                     lambda=1/lambdainv;
                       
                     
                     display(lambda);
                     attr=attr+(final_attraction(1,k)*lambda);
                 end
                 spsam(ii,jj)=attr;
             end
         end
         yy=yy+3;
         if(yy>n2)
             yy=1;
             xx=xx+3
         end
    end
end

display(spsam);

sort_array=zeros(1,mapsize*mapsize);
sort_position_x=zeros(1,mapsize*mapsize);
sort_position_y=zeros(1,mapsize*mapsize);

for i=1:3:m2
    for j=1:3:n2
        k=1;
        for ii=i:i+2
            for jj=j:j+2
                sort_array(1,k)=spsam(ii,jj);
                sort_position_x(1,k)=ii;
                sort_position_y(1,k)=jj;
                k=k+1;
            end
        end
        fprintf('%d %d\n',i,j);
        display(sort_array);
        display(sort_position_x);
        display(sort_position_y);
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
        display(sort_array);
        display(spsam);
        proportion=round((b(ceil(i/3),ceil(j/3))/100)*(mapsize*mapsize));
        for k=1:proportion
           spsam(sort_position_x(1,k),sort_position_y(1,k))=1.0; 
        end
        for ii=i:i+2
            for jj=j:j+2
                if spsam(ii,jj)~=1.0
                    spsam(ii,jj)=0.0;
                end
            end
        end
    end
end

