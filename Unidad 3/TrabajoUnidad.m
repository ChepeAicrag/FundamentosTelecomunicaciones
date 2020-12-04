clear;
clear all;
bits = [0 1 0 0 1 1 1 0];
nbits = length(bits);
valTrans = []; 
for i = 1 : nbits
    if bits(i) == 0
       transicion = [1 -1];
    else
       transicion = [-1 1];
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

recta = 1;
plot(T,y)
axis([0 nbits -2 2]);
hold on
plot(recta)
title('Manchester');


