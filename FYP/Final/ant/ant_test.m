class_number=1;
[mapsize,fn]=mapwindow();
a=imread(fn);
imshow(a);
[m1,n1,o1]=size(a);
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
%attraction=zeros(m1,n1);
%up=0;down=0;left=0;right=0;upleft=0;upright=0;downleft=0;downright=0;
%final_attraction=zeros(1,8);
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
         for ii=xx:xx+(mapsize-1)
             for jj=yy:yy+(mapsize-1)
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
                       
%                      
%                      display(lambda);
                     attr=attr+(final_attraction(1,k)*lambda);
                 end
                 spsam(ii,jj)=attr;
             end
         end
         yy=yy+mapsize;
         if(yy>n2)
             yy=1;
             xx=xx+mapsize;
         end
    end
end

display(spsam);

sort_array=zeros(1,mapsize*mapsize);
sort_position_x=zeros(1,mapsize*mapsize);
sort_position_y=zeros(1,mapsize*mapsize);

%Find the top sub-pixels with the highest attraction

for i=1:mapsize:m2
    for j=1:mapsize:n2
        k=1;
        for ii=i:i+(mapsize-1)
            for jj=j:j+(mapsize-1)
                sort_array(1,k)=spsam(ii,jj);
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
           spsam(sort_position_x(1,k),sort_position_y(1,k))=1.0; 
        end
        for ii=i:i+(mapsize-1)
            for jj=j:j+(mapsize-1)
                if spsam(ii,jj)~=1.0
                    spsam(ii,jj)=0.0;
                end
            end
        end
    end
end
spsam1=spsam;
u=1;
v=1;
xmatrix=zeros(mapsize,mapsize);
vmatrix=zeros(mapsize,mapsize);
pmatrix=zeros(mapsize,mapsize);
vnewmatrix=zeros(mapsize,mapsize);
vmin=-3;
vmax=3;
%display(xmatrix);
 %       display(pmatrix);
  %      display(vmatrix);

        %display(spsam1);
        %display(h);
        
       
        
        %hard codind Q and R value as 3
        R=0;
        Q=0;
for qqqq=1:Q     
        bindex_i=1;
        bindex_j=1;
for z=1:mapsize:m2
    for y=1:mapsize:n2
        u=1;
        v=1;
        counter=0;
        flag=0;
         % iteration begins
        %Average of the sourrounding sub pixels
        % while counter<=5       

        %calculating attraction for every R ittration
        R=0;
        Q=0;
  for r=1:R
        for i=1:m2
            for j=1:n2
                if(((i-1)>0) && ((j-1)>0)&& ((i+1)<m2) && ((j+1)<n2) )
                    temp1=0.0;
                    for k=i-1:i+1
                        for l=j-1:j+1
                            temp1=temp1+spsam1(k,l);
                        end
                    end
                    temp1=(temp1-spsam1(i,j))/8;


                elseif(((i-1)<1) && ((j-1)<1))
                    temp1=0.0;
                    for k=i:i+1
                        for l=j:j+1
                            temp1=temp1+spsam1(k,l);
                        end
                    end
                    temp1=(temp1-spsam1(i,j))/3;

                elseif(((i+1)>m2) && ((j-1)<1))
                    temp1=0.0;
                    for k=i-1:i
                        for l=j:j+1
                            temp1=temp1+spsam1(k,l);
                        end
                    end
                    temp1=(temp1-spsam1(i,j))/3;


                elseif(((i-1)<1) && ((j+1)>n2))
                    temp1=0.0;
                    for k=i:i+1
                        for l=j-1:j
                            temp1=temp1+spsam1(k,l);
                        end
                    end
                    temp1=(temp1-spsam1(i,j))/3;


                elseif(((i+1)>m2) && ((j+1)>n2))
                    temp1=0.0;
                    for k=i-1:i
                        for l=j-1:j
                            temp1=temp1+spsam1(k,l);
                        end
                    end
                    temp1=(temp1-spsam1(i,j))/3;


                elseif((j-1)<1)
                    temp1=0.0;
                    for k=i-1:i+1
                        for l=j:j+1
                            temp1=temp1+spsam1(k,l);
                        end
                    end
                    temp1=(temp1-spsam1(i,j))/5;


                elseif( (j+1)>n2)
                    temp1=0.0;
                    for k=i-1:i+1
                        for l=j-1:j
                            temp1=temp1+spsam1(k,l);
                        end
                    end
                    temp1=(temp1-spsam1(i,j))/5;


                elseif( (i-1)<1 )
                    temp1=0.0;
                    for k=i:i+1
                        for l=j-1:j +1
                            temp1=temp1+spsam1(k,l);
                        end
                    end
                    temp1=(temp1-spsam1(i,j))/5;



                elseif( (i+1)>m2 )
                    temp1=0.0;
                    for k=i-1:i
                        for l=j-1:j +1
                            temp1=temp1+spsam1(k,l);
                        end
                    end
                    temp1=(temp1-spsam1(i,j))/5;
                end

              h(i,j)=temp1;

            end
        end

        %taking each pixel and applying PSO     
         G=0;
          %G is global maximum (fitest)
        for zz=z:z+(mapsize-1)
            for yy=y:y+(mapsize-1)
                %display(ii);
                %display(jj);
                
                %intilizing x,p,v matrix 
                if(flag==0)
                xmatrix(u,v)=spsam1(zz,yy);
                end
                pmatrix(u,v)=h(zz,yy);
                if(pmatrix(u,v)>G)
                    G=pmatrix(u,v);
                end
                if(flag==0)
                vmatrix(u,v)=randi([vmin,vmax]);
                end
                flag=1;
                v=v+1;
                if(v>mapsize)
                    v=1;
                    u=u+1;
                end
            end
        end
        
        %applying PSO formula 
        
        c1=rand(1);
        c2=randi(1);
        
        for u=1:mapsize
            for v=1:mapsize
                vnewmatrix(u,v)=vmatrix(u,v)+c1*randi([-5,(round(pmatrix(u,v)-xmatrix(u,v)))])+c2*randi([-5,round((G-xmatrix(u,v)))]);
                vnewmatrix(u,v)=1/(1+exp(-(vnewmatrix(u,v))));
                if(vnewmatrix(u,v)>vmax)
                    vnewmatrix=vmax;
                elseif(vnewmatrix(u,v)<vmin)
                    vnewmatrix=vmin;
                end
            end
        end
  
        %display(vmatrix);
        %display(vnewmatrix);
        
        %changin X matrix according to new V matrix 
        
        random=rand(1);
        
        %display(rand);
        onecount=0;
              %Xmatrix is updated 
        for u=1:mapsize
            for v=1:mapsize
                if(random<vnewmatrix(u,v))
                    xmatrix(u,v)=class_number;
                    onecount=onecount+1;
                else
                    xmatrix(u,v)=0;
                end
            end
        end
        
       %number of 1's in the pixel is calculated and converted into
       %percentage
       
       shouldbe=round(((b(bindex_i,bindex_j)*mapsize*mapsize)/100));
       
       %display(shouldbe);
       
       %the spectral percentage of the pixel will be extracted from
       %b[bindex]
       
       %numbers of 1's is added to the xmatrix according to b[bindex]
       
       uposition=1;
       vposition=1;
         if(onecount<shouldbe)
            for it=onecount:shouldbe
                position=randi([1,9]);
                     if(position<=3)
                         uposition=1;
                         vposition=position;
                     elseif(position<=6)
                         uposition=2;
                         vposition=position-3;
                     elseif(position<=9)
                         uposition=3;
                         vposition=position-6;
                     end
                 if(xmatrix(uposition,vposition)==class_number)
                     it=it-1;
                     continue;
                 end
                 xmatrix(uposition,vposition)=class_number;
            end
         end
         
         %if number of 1 is greater required number of 0's are added 
         
         if(onecount>shouldbe)
             for it=shouldbe:onecount
                position=randi([1,9]);
                     if(position<=3)
                         uposition=1;
                         vposition=position;
                     elseif(position<=6)
                         uposition=2;
                         vposition=position-3;
                     elseif(position<=9)
                         uposition=3;
                         vposition=position-6;
                     end
                 if(xmatrix(uposition,vposition)==0)
                     it=it-1;
                     continue;
                 end
                 xmatrix(uposition,vposition)=0;
            end
         end
       
         %old velocity is updated
       vmatrix=vnewmatrix;
       u=1;
       v=1;
       
       
       %display(xmatrix);
       %display(spsam1);
       
       %xmatrix changes are applied to spsam 
       
       for zzzz=z:z+(mapsize-1)
           for yyyy=y:y+(mapsize-1)
               spsam1(zzzz,yyyy)=xmatrix(u,v);
               v=v+1;
               if(v>mapsize)
                   v=1;
                   u=u+1;
               end
           end
       end
       
       
        %display(spsam1);
        %display(vnewmatrix);
        %display(vmatrix);
        %display(xmatrix);
        %display(pmatrix);
        
        %display(i);
        %display(j);
        %display(m2);
        %display(n2);
  end
    bindex_j=bindex_j+1;
    
    %reposition bmatrix index 
    
                if(bindex_j>n1)
                    bindex_i=bindex_i+1;
                    bindex_j=1;
                end
    end
end
end

for i=1:m2
    for j=1:n2
        if spsam(i,j)==1
            spsam(i,j)=class_number;
        end
    end
end

pso=spsam;
%imwrite(spsam,strcat(filename,'-1spsam.jpg'),'jpeg');


