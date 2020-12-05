function test()
    bits = [0 1 0 0 1 1 1 0]
    figure 
    title('Manchester');
    graficar(bits, Manchester(bits));
    figure
    title('Manchester Diferencial');
    graficar(bits, ManchesterDiferencial(bits));
end

function g = graficar(bits, valTrans)
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
    axis([0 length(bits) -2 2]);
end

function m = Manchester(bits)
    valTrans = []; 
    for i = 1 : length(bits)
        if bits(i) == 0
            transicion = [1 -1];
        else
            transicion = [-1 1];
        end
        valTrans = [ valTrans transicion];
    end
    m = valTrans;
end

function md = ManchesterDiferencial(bits)
    valTrans = [];
    if bits(1) == 0
        transicion = [-1 1];
    else 
        transicion = [1 -1];
    end
    valTrans = [ valTrans transicion];
    k = 2;
    for i = 2 : length(bits)
        if bits(i) == 0
            tran = [valTrans(k - 1) valTrans(k)];
        else
            tran = [valTrans(k) valTrans(k - 1)];
        end
        k = k + 2;
        valTrans = [valTrans tran];
    end
    md = valTrans;
end

