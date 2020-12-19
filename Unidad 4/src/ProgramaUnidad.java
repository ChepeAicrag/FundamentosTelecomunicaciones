/**
 * Programa de Unidad 4 y 5
 * @author: García García José Ángel
 * @version: 19/12/2020
 *
 * */
import java.util.*;

public class ProgramaUnidad {

    private static ArrayList<Estacion> estaciones; // Array de estaciones
    private static int numEstaciones; // Número de estaciones
    static Scanner sc = new Scanner(System.in); // Scanner para leer de teclado

    /**
     * Función principal del programa para ejecutar todos las fucniones
     * */
    public static void main(String[] args){
        System.out.print("Introduce el numero de estaciones: ");
        numEstaciones = sc.nextInt(); // Lectura del número de estaciones
        crearEstaciones(); // Creamos las estaciones
        rellenarEstaciones(); // Rellenamos las estaciones
        mostrarTrama(); // Obtenemos y mostramos la trama

        System.out.println(getBitsTransmitidos() + " = " + getMaxCaracter()
                + " tramas/segundo x " + (8 * numEstaciones + 1) + " bits/trama");

        System.out.println(getBitsTransmitidos() + " = " + numEstaciones + " x " + getBitsUtiles()
                + " bps + " + (getBitsTransmitidos() - getBitsUtiles()) + " bps de sincronización");

        System.out.println("\nNúmero de bits transmitidos: " + getBitsTransmitidos()); // Información de bits transmitidos
        System.out.println("Número de bits utiles transmitidos: " + getBitsUtiles()); // Información de bits utiles



    }

    /**
     * Crear las estaciones con su respectivo número de caracteres a transmitir
     * */
    public static void crearEstaciones(){
        estaciones = new ArrayList<>(numEstaciones);
        System.out.println("\n************************************************************\n");
        for(int i = 1; i <= numEstaciones; i++) {
            System.out.print("Cantidad de caracteres a transmitir la estación [" + i + "] = ");
            estaciones.add(new Estacion(sc.nextInt(), i));
        }
        System.out.println("\n************************************************************\n");
    }

    /**
     * Genera la trama a partir de las estaciones
     * @return String - La trama generada
     * */
    public static String generarTrama(){
        String tramas = "", trama = "";
        for(int t = getMaxCaracter() - 1; t >= 0; t--){
            trama = "[";
            for(int i = numEstaciones - 1; i >= 0; i--){
                ArrayList<Character> datos = estaciones.get(i).getData(); // Obtenemos e caracter de la estación
                try {
                    trama += " " + datos.get(t) + " |"; // Lo colocamos en la trama si es que tiene
                }catch (Exception error){
                    trama += " " + "_" + " |"; // Colocamos un _ si no tiene caracter para transmitir
                }
            }
            trama = trama.substring(0 ,trama.length() - 1); // Quitar el | al final de cada trama
            tramas += trama + "] --- "; // Concatenamos a las tramas
        }
        return tramas;
    }

    /**
     * Permite mostrar la trama generado con un separador
     * */
    public static void mostrarTrama(){
        System.out.println("TRAMA GENERADA: \n");
        String trama = generarTrama(); // Generamos la trama
        for(int i = 0; i < trama.length(); i++)
            System.out.printf("*");
        System.out.println("\n\n" + trama + "\n"); // Mostramos la trama
        for(int i = 0; i < trama.length(); i++)
            System.out.printf("*");
        System.out.println();
    }

    /**
     * Rellena todas las estaciones ejecutando su método para agregar caracteres de cada estación
     * */
    public static void rellenarEstaciones(){
        estaciones.stream().forEach(estacion -> estacion.addCaracters());
    }

    /**
     * Calcula y devuelve los bits que se han transmitido
     * */
    public static int getBitsTransmitidos(){
        return getBitsUtiles() + (8 * numEstaciones);
    }

    /**
     * Calcula y devuelve los bits transmitidos los que son utiles
     * */
    public static int getBitsUtiles(){
        return  estaciones.stream().mapToInt(Estacion::getBits).sum();
    }

    /**
     * Calcula y devuelve el mayor número de caracteres que envía una estación, para saber cuantas tramas se generan
     * */
    public static int getMaxCaracter(){
        return estaciones.stream().mapToInt(Estacion::getNumCaracter).max().getAsInt();
    }
}

/**
 * Clase utilizada como una abstracción de una estación
 * */
class Estacion{

    private ArrayList<Character> data; // Información que transmite
    private int bits, // Cantidad de bits que transmite
                numCaracter, // Número de caracteres de la estacion
                id; // Identificador

    /**
     * Constructor de una estación
     * */
    public Estacion(int numCaracter, int id){
        this.id = id;
        this.data = new ArrayList<>();
        this.numCaracter = numCaracter;
        bits = numCaracter * 8;
    }

    /**
     * Permite agregar un caracter a transmitir a la estación
     * */
    public void addCaracters(){
        Scanner sc = new Scanner(System.in);
        System.out.println("Caracteres de Estación " + id);
        for(int i = 0; i < numCaracter; i++){
            System.out.printf("Caracter [" + (i + 1) + "] = ");
            data.add(new Character(sc.next().charAt(0)));
        }
        System.out.println("-------------------------------------");
    }

    /**
     * Devuelve el número de caracteres que envía la estación
     * */
    public int getNumCaracter(){
        return numCaracter;
    }

    /**
     * Devuelve el total de bits que envía la estación
     * */
    public int getBits(){
        return bits;
    }

    /**
     * Devuelve el array de caracteres que envía la estación
     * */
    public ArrayList<Character> getData(){
        return data;
    }
}