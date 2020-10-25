import java.util.Scanner;

public class ProyectoUnidad2 {

    public static void main(String[] args) {
        ProyectoUnidad2 p = new ProyectoUnidad2();
        p.init();
    }

    public void init(){
        Scanner sc = new Scanner(System.in);
        System.out.println("Introduce el tren de bits o polinomio");
        String entrada = sc.next();
        //if(entrada.isEmpty() || entrada.length() > 8 ) System.out.println("Introduzca correctamente los datos");
        String polinomio = bits_polinomio(entrada.trim());
        System.out.println("El polinomio de " + entrada + " es: " + polinomio);
        System.out.println("El tren de bits de " + polinomio + " es: " + polinomio_bits(polinomio));
    }

    // Entrada tipo x^3+x^2+x+1
    public String polinomio_bits(String entrada){
        String bits = "";
        String data[] = entrada.split("\\+");
        int maxExpo = Integer.parseInt(""+data[0].charAt(data[0].length() - 1)) + 1;
        boolean [] pos = new boolean[maxExpo];
        for(int i = 0; i < maxExpo; i++) {
            try {
                int value = Integer.parseInt("" + data[i].charAt(data[i].length() - 1));
                pos[value] = true;
            }catch (Exception e){
                if(data[data.length - 1].equals("x"))
                    pos[1] = true;
                if(data[data.length - 1].equals("1"))
                    pos[0] = true;
            }
        }
        for(int i = pos.length - 1; i >= 0; i--) bits += pos[i] ? "1" : "0";
        return  bits;
    }
    // Ya validada la entrada 1001 =
    // No acepta vacios o con 0
    public String bits_polinomio(String entrada){
        String polinomio = "";
        int limit = entrada.length() - 1;
        for(int i = 0; i < limit; i++)
            if(entrada.charAt(i) != '0')
                polinomio += (i != limit - 1) ? "x^" + ( limit - i ) + "+" : "x+";
        if(polinomio.isEmpty()) return "1";
        polinomio += entrada.endsWith("1") ? "1+" : "";
        return  polinomio.substring(0, polinomio.length() - 1);
    }
}
