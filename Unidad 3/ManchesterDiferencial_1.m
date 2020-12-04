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
    valTrans = [valTrans transicion];
end    