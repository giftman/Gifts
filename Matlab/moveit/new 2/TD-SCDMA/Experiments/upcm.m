
%%%%% project 3 complement function %%%%%%%%
function [snr_q, a_quan, code]=upcm(a,n)
amax=max(abs(a));
a_quan=a/amax;
b_quan=a_quan;
d=2/n;
q=d.*[0:n-1]-(n-1)/2*d;
 for i=1:n
     index = find((q(i)-d/2<=a_quan)&(a_quan<=q(i)+d/2));
     a_quan(index)=q(i).*ones(1,length(index));
     b_quan(find(a_quan == q(i)))=(i-1).*ones(1,length(find(a_quan==q(i))));
 end
  
 a_quan = a_quan*amax;
 nu = ceil(log2(n));
 
 code=zeros(length(a),nu);
 for i=1:length(a)
     for j=nu:-1:0
         if(fix(b_quan(i)/2^j)==1)
             code(i,nu-j)=1;
             b_quan(i)=b_quan(i)-2^j;
         end
     end
 end
 
 snr_q = 20*log10(norm(a)./norm(a-a_quan));