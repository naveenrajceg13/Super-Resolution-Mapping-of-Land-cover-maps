close all
clear all
clc
% % function simmap1()
[filename, pathname]=uigetfile('*.*','Select a image');
  if isequal(filename,0) || isequal(pathname,0)
    fn='D:\FYP\h1.jpg';
  else
    fn = fullfile(pathname, filename);
  end
  
a=fn;  
imshow(a);
[m1,n1,o1]=size(a);
mapsize=input('Enter the Scale Factor ');
m2=m1*mapsize;
n2=n1*mapsize;

outmap=zeros(m2,n2);
outmapp1=zeros(m2,n2);
inmatrix=zeros(mapsize,mapsize);

a=double(a);

%find class proportions for each pixel and store in b matrix
for i=1:m1
    for j=1:n1
    temp=a(i,j); 
   
    b(i,j)=(temp/255)*100;
    b(i,j)=round(b(i,j));
    end
end
% figure
% imshow(b);

%dividing the pixels in to sub pixels
for ii=1:m1
        for jj=1:n1
        x=(b(ii,jj) /100)*(mapsize*mapsize);
        x=round(x);
                         
        y=(mapsize*mapsize)-x;
               %network initialisation
         if(x==(mapsize*mapsize)) 
                for n = 1:(mapsize*mapsize)
                inmatrix(n) = 1.0;
                end
         else
                   d=magic(mapsize);
                for n = 1:x
                   inmatrix(d(n)) = 1.0;
                end
                for n = x+1:(mapsize*mapsize)
                    inmatrix(d(n))=0.0;
                end
         end
            
               
               
                     for k=1:mapsize
                for l=1:mapsize
                     outmapp1((mapsize*ii)-(mapsize-k),(mapsize*jj)-(mapsize-l))= 255 *( floor( (  1+ tanh(inmatrix(k,l)-0.5))));
                outmap((mapsize*ii)-(mapsize-k),(mapsize*jj)-(mapsize-l))=inmatrix(k,l);
                end
            end
end
end
% figure
% imshow(outmapp1);

counter=0;

 % iteration begins
%Average of the sourrounding sub pixels
% while counter<=5       
for i=1:m2
    for j=1:n2
        if(((i-1)>0) && ((j-1)>0)&& ((i+1)<m2) && ((j+1)<n2) )
            temp1=0.0;
            for k=i-1:i+1
                for l=j-1:j+1
                    temp1=temp1+outmap(k,l);
                end
            end
            temp1=(temp1-outmap(i,j))/8;
            
    
        elseif(((i-1)<1) && ((j-1)<1))
            temp1=0.0;
            for k=i:i+1
                for l=j:j+1
                    temp1=temp1+outmap(k,l);
                end
            end
            temp1=(temp1-outmap(i,j))/3;
            
        elseif(((i+1)>m2) && ((j-1)<1))
            temp1=0.0;
            for k=i-1:i
                for l=j:j+1
                    temp1=temp1+outmap(k,l);
                end
            end
            temp1=(temp1-outmap(i,j))/3;
            
            
        elseif(((i-1)<1) && ((j+1)>n2))
            temp1=0.0;
            for k=i:i+1
                for l=j-1:j
                    temp1=temp1+outmap(k,l);
                end
            end
            temp1=(temp1-outmap(i,j))/3;
            
        
        elseif(((i+1)>m2) && ((j+1)>n2))
            temp1=0.0;
            for k=i-1:i
                for l=j-1:j
                    temp1=temp1+outmap(k,l);
                end
            end
            temp1=(temp1-outmap(i,j))/3;
            
        
        elseif((j-1)<1)
            temp1=0.0;
            for k=i-1:i+1
                for l=j:j+1
                    temp1=temp1+outmap(k,l);
                end
            end
            temp1=(temp1-outmap(i,j))/5;
            
        
        elseif( (j+1)>n2)
            temp1=0.0;
            for k=i-1:i+1
                for l=j-1:j
                    temp1=temp1+outmap(k,l);
                end
            end
            temp1=(temp1-outmap(i,j))/5;
            
            
        elseif( (i-1)<1 )
            temp1=0.0;
            for k=i:i+1
                for l=j-1:j +1
                    temp1=temp1+outmap(k,l);
                end
            end
            temp1=(temp1-outmap(i,j))/5;
            
            
        
        elseif( (i+1)>m2 )
            temp1=0.0;
            for k=i-1:i
                for l=j-1:j +1
                    temp1=temp1+outmap(k,l);
                end
            end
            temp1=(temp1-outmap(i,j))/5;
        end
         
      h(i,j)=temp1;
 
    end
end
coltot=sum(h);
SD=sum(coltot);