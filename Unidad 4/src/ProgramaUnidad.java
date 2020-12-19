import java.util.*;

public class ProgramaUnidad {

    private static ArrayList<Estacion> estacions; // Array de estaciones
    private static int numEstaciones; // Numero de estaciones
    static Scanner sc = new Scanner(System.in);

    public static void main(String[] args){
        System.out.print("Introduce el numero de estaciones: ");
        numEstaciones = sc.nextInt();
        crearEstaciones();
        rellenarEstaciones();
        System.out.println(getMaxCaracter());
        System.out.println("********************* Trama Generada ***********************");
        System.out.println(mostrarTrama());
        System.out.println("************************************************************");
        System.out.println("Número de bits transmitidos: " + getBitsTransmitidos());
        System.out.println("Número de bits utiles: " + getBitsUtiles());
    }

    public static void crearEstaciones(){
        estacions = new ArrayList<>(numEstaciones);
        System.out.println("************************************************************");
        for(int i = 1; i <= numEstaciones; i++){
            System.out.print("Cantidad de caracteres a transmitir la estación ["+ i + "] = ");
            estacions.add(new Estacion(sc.nextInt(),i));
        }
        System.out.println("************************************************************");
    }

    public static String mostrarTrama(){
        String tramas = "", trama = "";
        for(int t = 0; t < getMaxCaracter(); t++){
            trama = "[";
            for(int i = 0; i < numEstaciones; i++){
                ArrayList<Character> datos = estacions.get(i).getData();
                try {
                    trama += " " + datos.get(t) + " |";
                }catch (Exception error){
                    trama += " " + "_" + " |";
                }
            }
            trama = trama.substring(0 ,trama.length() - 1);
            tramas += trama + "] --- ";
        }
        return tramas;
    }

    public static void rellenarEstaciones(){
        estacions.stream().forEach(estacion -> estacion.addCaracters());
    }

    public static int getBitsTransmitidos(){
        return getBitsUtiles() + (8 * numEstaciones);
    }

    public static int getBitsUtiles(){
        return  estacions.stream().mapToInt(Estacion::getBits).sum();
    }

    public static int getMaxCaracter(){
        int max = 0;
        for (Estacion e: estacions) {
            int value = e.getNumCaracter();
            if (value > max)
                max = value;
        }
        return max;
    }
}


class Estacion{

    private ArrayList<Character> data; // Información que transmite
    private int bits, // Cantidad de bits que transmite
                numCaracter, // Número de caracteres de la estacion
                id; // Identificador

    public Estacion(int numCaracter, int id){
        this.id = id;
        this.data = new ArrayList<>();
        this.numCaracter = numCaracter;
        bits = numCaracter * 8;
    }

    public void addCaracters(){
        Scanner sc = new Scanner(System.in);
        System.out.println("Caracteres de Estación " + id);
        for(int i = 0; i < numCaracter; i++){
            System.out.printf("Caracter [" + (i + 1) + "] = ");
            data.add(new Character(sc.next().charAt(0)));
        }
        System.out.println("------------");
    }

    public int getNumCaracter(){
        return numCaracter;
    }

    public int getBits(){
        return bits;
    }

    public int getId(){
        return id;
    }

    public ArrayList<Character> getData(){
        return data;
    }
}