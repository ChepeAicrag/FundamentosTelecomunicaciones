clear;
clear all;
%bits = [0 1 0 0 1 1 1 0];
bits = [1 0 1 1 1 1 0 1 0 0 0 1 1 0 0];
nbits = length(bits);
valTrans = [];
% Verificamos si hay transición al principio
if bits(1) == 0
   transicion = [-1 1];
   arriba = true;
else 
   transicion = [1 -1];
end
valTrans = [ valTrans transicion];
k = 2;
for i = 2 : nbits
    if bits(i) == 0
        tran = [valTrans(k - 1) valTrans(k)];
    else
        tran = [valTrans(k) valTrans(k - 1)];
    end
    k = k + 2;
    valTrans = [ valTrans tran];
end

k = 1;
l = 0.5;
T = 0 : 0.01 : length(bits);
for j = 1: length(T)
    y(j) = valTrans(k);
    if T(j) > l
       k = k + 1; 
       l = l + 0.5;
    end   
end

plot(T,y)
axis([0 nbits -2 2]);


