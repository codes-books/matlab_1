function c1=cross_ga(s_code1)
   
   %��������
  
   pc=0.8;       %�������ȡ0.6
   population=10;
   
   %(1,2)/(3,4)/(5,6)���н������㣬(7,8)/(9,10)����
   
   ww=s_code1;
   
   for i=1:(pc*population/2)
       r=abs(round(rand(1)*10)-3);
       for j=(r+1):8
           temp=ww(2*i-1,j);
           ww(2*i-1,j)=ww(2*i,j);
           ww(2*i,j)=temp;
       end
   end
   
   c1=ww;
   
           
           
       
       
   
   
   
   