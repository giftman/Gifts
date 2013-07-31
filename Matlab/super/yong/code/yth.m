K3='A$%^$^^A';
r_k=K3(1);
r_k=dec2bin(r_k,8);
r_k=uint8(r_k)-48;
for i_k=2:length(K3)
         temp=K3(i_k);
         temp=dec2bin(temp,8);
         temp=uint8(temp)-48;
   r_k=bitxor(r_k,temp);
end
r_k