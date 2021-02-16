function flag=test(code)
f1=isempty(find(code>3, 1));
f2=isempty(find(code<-3, 1));

if f1*f2==0
    flag=0;
else
    flag=1;
end
