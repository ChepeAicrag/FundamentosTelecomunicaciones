clear;
clear all;
bits = [0 1 0 0 1 1 1 0];
nbits = length(bits);
arriba = false;
valTrans = [];
% Verificamos si hay transición al principio
if bits(1) == 0
   transicion = [-1 1];
   arriba = true;
else 
   transicion = [-1 1];
end
valTrans = [ valTrans transicion];

for i = 2 : nbits
    if bits(i) == 1
       if arriba
            transicion = [1 -1];
            arriba = false;
       else 
            transicion = [-1 1];
            arriba = true;
       end    
    else % Si hablamos del 0 le aplicamos transacción
        if arriba == true 
            transicion = [-1 1]; 
        else
            transicion = [1 -1];
        end    
    end
    valTrans = [ valTrans transicion];
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

