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
    public static void main(String[] args) {
        //System.out.print("Introduce el numero de estaciones: ");
        //numEstaciones = sc.nextInt(); // Lectura del número de estaciones
        //crearEstaciones(); // Creamos las estaciones

        int op = sc.nextInt();
        switch (op) {
            case 1:
            test();break;
            case 2:
            test2();break;
            case 3:
            test3();
                break;
            case  4:
            test4();
            break;
        }
        //rellenarEstaciones(); // Rellenamos las estaciones
        mostrarDatos(); // Muestra los datos que se enviarán
        mostrarTramas(); // Obtenemos y mostramos la trama
    }

    public static void test4(){
        numEstaciones = 5;

        estaciones = new ArrayList<>(numEstaciones);

        estaciones.add(new Estacion(6, 1));  // Crea la estación y la Agrega a estaciones
        estaciones.add(new Estacion(3, 2));  // Crea la estación y la Agrega a estaciones
        estaciones.add(new Estacion(4, 3));  // Crea la estación y la Agrega a estaciones
        estaciones.add(new Estacion(4, 4));  // Crea la estación y la Agrega a estaciones
        estaciones.add(new Estacion(4, 5));  // Crea la estación y la Agrega a estaciones

        estaciones.get(0).getData().add('A');
        estaciones.get(0).getData().add('A');
        estaciones.get(0).getData().add('A');
        estaciones.get(0).getData().add('A');
        estaciones.get(0).getData().add('A');
        estaciones.get(0).getData().add('A');

        estaciones.get(1).getData().add('B');
        estaciones.get(1).getData().add('B');
        estaciones.get(1).getData().add('B');

        estaciones.get(2).getData().add('C');
        estaciones.get(2).getData().add('C');
        estaciones.get(2).getData().add('C');
        estaciones.get(2).getData().add('C');

        estaciones.get(3).getData().add('D');
        estaciones.get(3).getData().add('D');
        estaciones.get(3).getData().add('D');
        estaciones.get(3).getData().add('D');

        estaciones.get(4).getData().add('E');
        estaciones.get(4).getData().add('E');
        estaciones.get(4).getData().add('E');
        estaciones.get(4).getData().add('E');
    }

    public static void test3(){
        numEstaciones = 5;

        estaciones = new ArrayList<>(numEstaciones);

        estaciones.add(new Estacion(6, 1));  // Crea la estación y la Agrega a estaciones
        estaciones.add(new Estacion(0, 2));  // Crea la estación y la Agrega a estaciones
        estaciones.add(new Estacion(4, 3));  // Crea la estación y la Agrega a estaciones
        estaciones.add(new Estacion(4, 4));  // Crea la estación y la Agrega a estaciones
        estaciones.add(new Estacion(4, 5));  // Crea la estación y la Agrega a estaciones

        estaciones.get(0).getData().add('A');
        estaciones.get(0).getData().add('A');
        estaciones.get(0).getData().add('A');
        estaciones.get(0).getData().add('A');
        estaciones.get(0).getData().add('A');
        estaciones.get(0).getData().add('A');

        estaciones.get(2).getData().add('C');
        estaciones.get(2).getData().add('C');
        estaciones.get(2).getData().add('C');
        estaciones.get(2).getData().add('C');

        estaciones.get(3).getData().add('D');
        estaciones.get(3).getData().add('D');
        estaciones.get(3).getData().add('D');
        estaciones.get(3).getData().add('D');

        estaciones.get(4).getData().add('E');
        estaciones.get(4).getData().add('E');
        estaciones.get(4).getData().add('E');
        estaciones.get(4).getData().add('E');

    }

    public static void test2(){
        numEstaciones = 4;

        estaciones = new ArrayList<>(numEstaciones);

        estaciones.add(new Estacion(7, 1));  // Crea la estación y la Agrega a estaciones
        estaciones.add(new Estacion(4, 2));  // Crea la estación y la Agrega a estaciones
        estaciones.add(new Estacion(3, 3));  // Crea la estación y la Agrega a estaciones
        estaciones.add(new Estacion(5, 4));  // Crea la estación y la Agrega a estaciones

        estaciones.get(0).getData().add('A');
        estaciones.get(0).getData().add('A');
        estaciones.get(0).getData().add('A');
        estaciones.get(0).getData().add('A');
        estaciones.get(0).getData().add('A');
        estaciones.get(0).getData().add('A');
        estaciones.get(0).getData().add('A');

        estaciones.get(1).getData().add('B');
        estaciones.get(1).getData().add('B');
        estaciones.get(1).getData().add('B');
        estaciones.get(1).getData().add('B');

        estaciones.get(2).getData().add('C');
        estaciones.get(2).getData().add('C');
        estaciones.get(2).getData().add('C');

        estaciones.get(3).getData().add('D');
        estaciones.get(3).getData().add('D');
        estaciones.get(3).getData().add('D');
        estaciones.get(3).getData().add('D');
        estaciones.get(3).getData().add('D');
    }
    public static void test(){
        numEstaciones = 5;

        estaciones = new ArrayList<>(numEstaciones);

        estaciones.add(new Estacion(6, 1));  // Crea la estación y la Agrega a estaciones
        estaciones.add(new Estacion(0, 2));  // Crea la estación y la Agrega a estaciones
        estaciones.add(new Estacion(4, 3));  // Crea la estación y la Agrega a estaciones
        estaciones.add(new Estacion(0, 4));  // Crea la estación y la Agrega a estaciones
        estaciones.add(new Estacion(4, 5));  // Crea la estación y la Agrega a estaciones

        estaciones.get(0).getData().add('A');
        estaciones.get(0).getData().add('A');
        estaciones.get(0).getData().add('A');
        estaciones.get(0).getData().add('A');
        estaciones.get(0).getData().add('A');
        estaciones.get(0).getData().add('A');

        estaciones.get(2).getData().add('C');
        estaciones.get(2).getData().add('C');
        estaciones.get(2).getData().add('C');
        estaciones.get(2).getData().add('C');

        estaciones.get(4).getData().add('E');
        estaciones.get(4).getData().add('E');
        estaciones.get(4).getData().add('E');
        estaciones.get(4).getData().add('E');


    }


    /**

     * Crear las estaciones con su respectivo número de caracteres a transmitir
     * */
    public static void crearEstaciones(){
        estaciones = new ArrayList<>(numEstaciones); // Crea el array para almacenar las estaciones
        System.out.println("\n************************************************************\n");
        for(int i = 1; i <= numEstaciones; i++) {
            System.out.print("Cantidad de caracteres a transmitir la estación [" + i + "] = ");
            estaciones.add(new Estacion(sc.nextInt(), i));  // Crea la estación y la Agrega a estaciones
        }
        System.out.println("\n************************************************************\n");
    }

    /**
     * Genera la trama a partir de las estaciones
     * @return String - La trama generada
     * */
    public static String generarTramaSincrona(){
        String tramas = "", trama = "";
        int bit_tramado = 1;
        for(int t = getMaxCaracter() - 1; t >= 0; t--){
            trama = "[";
            for(int i = numEstaciones - 1; i >= 0; i--){
                ArrayList<Character> datos = estaciones.get(i).getData(); // Obtenemos los caracteres de la estación
                try {
                    trama += " " + datos.get(t) + " |"; // Lo colocamos en la trama si es que tiene
                }catch (Exception error){
                    trama += " " + "_" + " |"; // Colocamos un _ si no tiene caracter para transmitir
                }
            }
            trama = trama.substring(0 ,trama.length() - 1); // Quitar el | al final de cada trama
            tramas += trama + "] [" + (bit_tramado = Math.abs(bit_tramado - 1)) + "] --- "; // Concatenamos a las tramas y su bit de tramado
        }
        return tramas;
    }
    /**
     * Verifica si las Queue tienen datos o ya no
     */
    public static boolean hayTodavia(ArrayList<Queue<Character>> datos){
        for(Queue<Character> d : datos)
            if(!d.isEmpty())
                return true;
        return false;
    }

    /**
     * Genera la trama del TDM Asincrono
     * */
    public static String generarTramaAsincrona(){
        StringBuilder tramas = new StringBuilder();
        int bit_tramado = 1,
            numRanuras = getNumRanurasTiempoAsincrona(),
            numTramas = getNumTramasAsincrono(); // Este será dinamico y generico
        ArrayList<Queue<Character>> caracteres = new ArrayList<>();
        for(int i = 0; i < numEstaciones; i++)
            caracteres.add(new LinkedList<>(estaciones.get(i).getData()));
        StringBuilder tmpTrama = new StringBuilder();
        int index = 0;
        while(hayTodavia(caracteres)){
            index = index >= numEstaciones ? 0 : index;
            try {
                Queue<Character> datos = caracteres.get(index++);
                tmpTrama.append(datos.remove().toString() + (index));
            }catch (Exception e){}
        }
        tramas.append("]1[");
        for(int i = 0, aux = 0; i < tmpTrama.length() - 1; i+=2){
            if(aux == 0)
                tramas.append("] ");
            tramas.append(" | " + tmpTrama.charAt(i+1) + "" + tmpTrama.charAt(i));
            aux += 1;
            if(aux == numRanuras && numTramas != 0){
                if(i < tmpTrama.length() - 2)
                    tramas.append(" [ ---- ]" + (bit_tramado = Math.abs(bit_tramado - 1)) + "[" );
                aux = 0;
                numTramas--;
            }
            if(i == tmpTrama.length() - 2)
                tramas.append(" [");
            System.out.println(tramas);
        }
        return tramas.reverse().toString().replace("|  ]", "]");
    }

    /**
     * Retorna el número de estaciones que envían datos
     * */
    public static int getNumEstacionesEnvian(){
        return (int)(estaciones.stream().filter(estacion -> estacion.getNumCaracter() > 0).count());
    }

    /**
     * Retorna el número de caracteres que se envían
     * */
    public static int getNumCaracteresTotales(){
        return estaciones.stream().mapToInt(Estacion::getNumCaracter).sum();
    }

    /**
     * Calcula las ranuras de tiempo para las tramas del TDM Asincrono
     * */
    public static int getNumRanurasTiempoAsincrona(){
        int caracteres = getNumCaracteresTotales(),
            numEstacionesEnvian = getNumEstacionesEnvian(),
            aprox = caracteres / numEstacionesEnvian;
        return  aprox < numEstacionesEnvian ? aprox : aprox - 1;
    }

    /**
     * Calcula el número de tramas del TDM Asincrono
     * */
    public static int getNumTramasAsincrono(){
        int caracteres = getNumCaracteresTotales(),
                ranuras = getNumRanurasTiempoAsincrona();
        return caracteres / ranuras;
    }

    /**
     * Calcula el número de bits para direccionamiento de acuerdo a las estaciones
     * */
    public static int getBitsDireccionamiento(){
        return toBinary(numEstaciones).length();
    }

    /**
     * Convierte un número a binario
     * */
    public static String toBinary(int n){
        if(n == 1) return "1";
        return toBinary(n / 2) + n % 2;
    }


    /**
     * Permite mostrar las tramas generadas
     * */
    public static void mostrarTramas(){
        System.out.println("\nTRAMA SINCRONA GENERADA: \n");
        String trama = generarTramaSincrona(); // Generamos la trama
        decoracion(trama);
        System.out.println("\n\n" + trama + "\n"); // Mostramos la trama
        decoracion(trama);
        System.out.println("\nINFORMACIÓN  DE TDM SINCRONA: ");
        System.out.println("\n" + getBitsTransmitidosSincrona() + " bps = " + getMaxCaracter()
                + " tramas/segundo x " + (8 * numEstaciones + 1) + " bits/trama"); // Información de la tasa de datos
        System.out.println("Número de bits transmitidos: " + getBitsTransmitidosSincrona()); // Información de bits transmitidos
        System.out.println("Número de bits útiles transmitidos: " + getBitsUtiles()); // Información de bits utiles

        System.out.println("\n\nTRAMA ASINCRONA GENERADA: \n");
        String tramaAsincrona = generarTramaAsincrona();
        decoracion(tramaAsincrona);
        System.out.println("\n\n" + tramaAsincrona + "\n"); // Mostramos la trama asincrona
        decoracion(tramaAsincrona);
        System.out.println("\nINFORMACIÓN DE TDM ASINCRONA: ");
        System.out.println("Número de bits transmitidos: " + getBitsTransmitidosSincrona()); // Información de bits transmitidos
        System.out.println("Número de bits útiles transmitidos: " + getBitsUtiles()); // Información de bits utiles
        System.out.println("Bits para el direccionamiento: " + getBitsDireccionamiento());


        System.out.println("El número de tramas es " + getNumTramasAsincrono());
        System.out.println("El número de ranuras: " + getNumRanurasTiempoAsincrona());
        System.out.println("El número de caracteres: "  + getNumCaracteresTotales());
        System.out.println("El máx caractere es: " + getMaxCaracter());
    }

    public static void decoracion(String trama){
        for(int i = 0; i < trama.length(); i++)
            System.out.printf("*");
    }

    /**
     * Mostrar los datos que envía cada estación
     * */
    public static void mostrarDatos(){
        System.out.println("DATOS DE CADA ESTACIÓN");
        estaciones.stream().forEach(e -> e.imprimirDatos());
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
    public static int getBitsTransmitidosSincrona(){
        return getMaxCaracter() * numEstaciones * 8 + getMaxCaracter();
    }

    /**
     * Calcula y devuelve los bits transmitidos que son utiles
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
     * Permite agregar los caracteres a la estación
     * */
    public void addCaracters(){
        Scanner sc = new Scanner(System.in);
        System.out.println("Caracteres de Estación " + id);
        for(int i = 0; i < numCaracter; i++){
            System.out.printf("Caracter [" + (i + 1) + "] = ");
            data.add(new Character(sc.next().charAt(0))); // Agrega el caracter a los datos de la estación
        }
        System.out.println("-------------------------------------");
    }

    /**
     * Devuelve el número de indetificación de la estacipon
     * */
    public int getId(){
        return id;
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

    /**
     * Imprime los datos que envía y como los envía la estación
     * */
    public void imprimirDatos(){
        System.out.printf("ESTACIÓN " + id + " --> ENVÍA --> [ ");
        StringBuilder info = new StringBuilder();
        data.forEach(e -> info.append(e.toString()+ " "));
        System.out.printf(info + "] --> DE LA FORMA --> [" + info.reverse() + " ]\n");
    }
}