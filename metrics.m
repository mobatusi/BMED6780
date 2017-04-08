comm1=zeros(512,512);
comm2=zeros(512,512);
comm3=zeros(512,512);
for i=1:512
    for j=1:512
        if c1(i,j)==cr1(i,j)
            if cr1(i,j)==1
                comm1(i,j)=1;
            end
        end
    end
end
for i=1:512
    for j=1:512
        if c2(i,j)==cr2(i,j)
            if cr2(i,j)==2
                comm2(i,j)=1;
            end
        end
    end
end
for i=1:512
    for j=1:512
        if c3(i,j)==cr3(i,j)
            if cr3(i,j)==3
                comm3(i,j)=1;
            end
        end
    end
end
r1=nnz(comm1)/nnz(cr1);
r2=nnz(comm2)/nnz(cr2);
r3=nnz(comm3)/nnz(cr3);
