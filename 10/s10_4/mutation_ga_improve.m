function v1=mutation_ga_improve(c1,k)
    
    %��������,ǰ0.02����0.03����0.02
    
    if k<=30
        pm=0.02;
    elseif k>30 & k<=50
        pm=0.03;
    else
        pm=0.02;
    end
        
   
    format long;
    
    population=10;
    
    
    for i=1:population
        for j=1:8
            r=rand(1);
            if r>pm
                temp(i,j)=c1(i,j);
            else
                tt=not(str2num(c1(i,j)));
                temp(i,j)=num2str(tt);
            end
        end
    end
    
    v1=temp;
    
    