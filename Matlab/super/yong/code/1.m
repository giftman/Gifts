K='AAAAA'
K1=K(1);
K2=K(2);
K3=K(3);
K4=K(4);
K5=K(5);
K12=bitxor(uint8(dec2bin(K1,8))-48,uint8(dec2bin(K2,8))-48)%前两位异或
K123=bitxor(K12,uint8(dec2bin(K3,8))-48);%前两位异或后再与第三位异或
K1234=bitxor(K123,uint8(dec2bin(K4,8))-48);%把以上的结果再与第四位异或
K12345=bitxor(K1234,uint8(dec2bin(K5,8))-48);%把得到的结果再与第五位异或
