function y=ksw(t,mingrayvalue,maxgrayvalue,hist1,HT)
   
    %�������ֱ��ͼ�أ�KSW�أ�
    
    Pt=0;
    for i=mingrayvalue:t
        Pt=Pt+hist1(i+1);
    end
    
    Ht=0;
    for i=mingrayvalue:t
        if hist1(i+1)==0
           temp=0;
        else
           temp=hist1(i+1)*log(1/hist1(i+1));
        end
        Ht=Ht+temp;
    end
    
    if Pt==0 | Pt==1           %   or(Pt==0,Pt==1)
        temp1=0;
    else 
        temp1=log(Pt*(1-Pt))+Ht/Pt+(HT-Ht)/(1-Pt);
    end
    
    if temp1 < 0
        H=0;
    else
        H=temp1;
    end
        
    
    y=H;

