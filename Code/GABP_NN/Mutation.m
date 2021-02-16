function ret=Mutation(pmutation,lenchrom,chrom,sizepop,num,maxgen,bound)
for i=1:sizepop
    pick=rand;
    while pick==0
        pick=rand;
    end
    index=ceil(pick*sizepop);
    pick=rand;
    if pick>pmutation
        continue;
    end
    flag=0;
    while flag==0
        pick=rand;
        while pick==0      
            pick=rand;
        end
        pos=ceil(pick*sum(lenchrom));
    
        pick=rand;
        fg=(rand*(1-num/maxgen))^2;
        if pick>0.5
            chrom(index,pos)=chrom(index,pos)+(bound(pos,2)-chrom(index,pos))*fg;
        else
            chrom(index,pos)=chrom(index,pos)-(chrom(index,pos)-bound(pos,1))*fg;
        end
        flag=test(chrom(index,:));
    end
end
ret=chrom;
