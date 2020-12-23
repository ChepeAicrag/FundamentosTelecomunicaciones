/**
 * Programa de Unidad 4 y 5
 * @author: García García José Ángel
 * @version: 22/12/2020
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
        System.out.print("Introduce el numero de estaciones: ");
        numEstaciones = sc.nextInt(); // Lectura del número de estaciones
        crearEstaciones(); // Creación de las estaciones
        rellenarEstaciones(); // Relleno de las estaciones
        mostrarDatos(); // Muestra los datos que se envíarán por cada estación
        mostrarTramas(); // Obtiene y muestra las tramas
    }

    /**
     * Crea las estaciones con su respectivo número de caracteres a transmitir
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
     * Rellena todas las estaciones ejecutando su método para agregar caracteres de cada estación
     * */
    public static void rellenarEstaciones(){
        estaciones.stream().forEach(estacion -> estacion.addCaracters());
    }


    /**
     * Genera las tramas de acuerdo con un TDM Sincrona
     * */
    public static String generarTramaSincrona(){
        String tramas = "", trama = ""; // Variables para almacenar todas las tramas y cada trama
        int bit_tramado = 0; // Para indicar el bit de tramado
        for(int t = getMaxCaracter() - 1; t >= 0; t--){
            trama = "["; // Indica el inicio de una trama
            for(int i = numEstaciones - 1; i >= 0; i--){
                ArrayList<Character> datos = estaciones.get(i).getData(); // Se obtiene los caracteres de la estación
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
     * Calcula y retorna el mayor número de caracteres que envía una estación, para saber cuantas tramas se generan en TDM Asincrono
     * */
    public static int getMaxCaracter(){
        return estaciones.stream().mapToInt(Estacion::getNumCaracter).max().getAsInt();
    }

    /**
     * Calcula y retorna los bits transmitidos que son utiles en TDM Sincrona
     * */
    public static int getBitsUtilesSincrona(){
        return  estaciones.stream().mapToInt(Estacion::getBits).sum();
    }

    /**
     * Calcula y retorna los bits que se han transmitido
     * */
    public static int getBitsTransmitidosSincrona(){
        return getMaxCaracter() * numEstaciones * 8 + getMaxCaracter();
    }

    /**
     * Genera las tramas de acuerdo con un TDM Asincrona
     * */
    public static String generarTramaAsincrona(){
        StringBuilder tramas = new StringBuilder(); // Almacena las tramas
        int bit_tramado = 1, // Para indicar el bit de tramado
            numRanuras = getNumRanurasTiempoAsincrona(), // Para saber en cuantas ranuras partir la trama
            numTramas = getNumTramasAsincrona(); // El número de tramas a generar
        ArrayList<Queue<Character>> caracteres = new ArrayList<>(); // Contiene todos los caracteres que se envían
        for(int i = 0; i < numEstaciones; i++)
            caracteres.add(new LinkedList<>(estaciones.get(i).getData()));
        StringBuilder tmpTrama = new StringBuilder(); // La trama temporal
        int index = 0; // Para controla el index de cada caracter
        while(hayTodavia(caracteres)){
            index = index >= numEstaciones ? 0 : index;
            try {
                Queue<Character> datos = caracteres.get(index++);
                tmpTrama.append(datos.remove().toString() + (index)); // Se guarda todos los caracteres en
            }catch (Exception e){}
        }
        tramas.append("]1["); // Para la parte inicial, siempre inicia en bit tramado 1
        for(int i = 0, aux = 0; i < tmpTrama.length() - 1; i+=2){
            tramas.append( aux == 0 ? "] " : ""); // Inicia una trama dependiendo del número de rodajas
            tramas.append(" | " + tmpTrama.charAt(i+1) + "" + tmpTrama.charAt(i)); // Agrega el caracter a la trama
            aux += 1; // Indica que ya se colocó un caracter en la trama
            if(aux == numRanuras && numTramas != 0){ // Valida si es momento de cerrar la trama
                // Cierra la trama con su respectivo bit de tramado
                tramas.append( i < tmpTrama.length() - 2 ? " [ ---- ]" + (bit_tramado = Math.abs(bit_tramado - 1)) + "[" : "");
                aux = 0; // Reinicia las ranuras hechas
                numTramas--; // Decrementa las tramas, indicando que se completó una
            }
            tramas.append(i == tmpTrama.length() - 2 ? " [" : ""); // Cierra la última trama recien calculada y la agrega a tramas
        }
        StringBuilder nuevo = new StringBuilder(tramas.reverse().toString().replace("|  ]", "]"));
        int faltante = getNumTramasAsincrona() * numRanuras - getNumCaracteresTotales() ;
        for(int i = 1; i <= faltante; i++)
            nuevo.insert(i*2,"_ ");
        return nuevo.toString(); // Regresa las tramas
    }

    /**
     * Verifica si las Queue tienen datos o ya no de acuerdo aun ArrayList<Queue>
     */
    public static boolean hayTodavia(ArrayList<Queue<Character>> datos){
        for(Queue<Character> d : datos)
            if(!d.isEmpty())
                return true;
        return false;
    }

    /**
     * Calcula y retorna las ranuras de tiempo para un TDM Asincrona
     * */
    public static int getNumRanurasTiempoAsincrona(){
        int caracteres = getNumCaracteresTotales(),
                numEstacionesEnvian = getNumEstacionesEnvian(),
                aprox = caracteres / numEstacionesEnvian;
        return  aprox < numEstacionesEnvian ? aprox : aprox - 1;
    }

    /**
     * Calcula y retorna el número de tramas recomendado para una TDM Asincrona
     * */
    public static int getNumTramasAsincrona(){
        int caracteres = getNumCaracteresTotales(),
                ranuras = getNumRanurasTiempoAsincrona();
        return (int)Math.ceil((double)caracteres / ranuras);
        //double tramas = (double)caracteres / ranuras;
        //return String.valueOf(tramas).contains(".5") ? (int)(tramas + 0.5) : (int)tramas;
    }

    /**
     * Retorna el número de caracteres que se envían por todas las estaciones
     * */
    public static int getNumCaracteresTotales(){
        return estaciones.stream().mapToInt(Estacion::getNumCaracter).sum();
    }

    /**
     * Retorna el número de estaciones que envían datos
     * */
    public static int getNumEstacionesEnvian(){
        return (int)(estaciones.stream().filter(estacion -> estacion.getNumCaracter() > 0).count());
    }

    /**
     * Calcula y retorna el número de bits para direccionamiento de acuerdo a las estaciones para el TDM Asincrona
     * */
    public static int getBitsDireccionamiento(){
        return 2;
       //return toBinary(numEstaciones).length();
    }

    /**
     * Convierte un número a binario
     * */
    public static String toBinary(int n){
        if(n == 1) return "1";
        return toBinary(n / 2) + n % 2;
    }

    /**
     * Calcula y retorna los bits que se han transmitido
     * */
    public static int getBitsTransmitidosAsincrona(){
        return (getNumRanurasTiempoAsincrona() * getNumTramasAsincrona()) * (8 + getBitsDireccionamiento()) + getNumTramasAsincrona();
    }

    /**
     * Calcula y retorna los bits transmitidos que son utiles en TDM Asincrona
     * */
    public static int getBitsUtilesAsincrona(){
        return  getBitsTransmitidosAsincrona() - (getBitsDireccionamiento() * ( 8 +
                getNumTramasAsincrona() * getNumRanurasTiempoAsincrona()) + getNumTramasAsincrona());
    }

    /**
     * Permite mostrar las tramas generadas tanto de TDM Sincrona como ASincrona
     * */
    public static void mostrarTramas(){
        System.out.println("\nTRAMA(S) DE TDM SINCRONA: \n");
        String trama = generarTramaSincrona(); // Obtenemos las tramas mediante TDM Asincrona
        decoracion(trama);
        System.out.println("\n\n" + trama + "\n"); // Mostramos la tramas sincrona
        decoracion(trama);
        System.out.println("\n\nINFORMACIÓN  DE TDM SINCRONA: ");
        System.out.println("\n" + getBitsTransmitidosSincrona() + " bps = " + getMaxCaracter()
                + " tramas/segundo x " + (8 * numEstaciones + 1) + " bits/trama"); // Información de la tasa de datos
        System.out.println("Número de bits transmitidos: " + getBitsTransmitidosSincrona()); // Información de bits transmitidos
        System.out.println("Número de bits útiles transmitidos: " + getBitsUtilesSincrona()); // Información de bits utiles

        System.out.println("\n\nTRAMA(S) DE TDM ASINCRONA: \n");
        String tramaAsincrona = generarTramaAsincrona(); // Obtenemos las tramas mediante TDM Asincrona
        decoracion(tramaAsincrona);
        System.out.println("\n\n" + tramaAsincrona + "\n"); // Mostramos la tramas asincrona
        decoracion(tramaAsincrona);
        System.out.println("\n\nINFORMACIÓN DE TDM ASINCRONA: \n");
        System.out.println("Número de bits transmitidos: " + getBitsTransmitidosAsincrona()); // Información de bits transmitidos
        System.out.println("Número de bits útiles transmitidos: " + getBitsUtilesAsincrona()); // Información de bits utiles
        System.out.println("Bits para el direccionamiento: " + getBitsDireccionamiento()); // Información del bit de direccionamiento
    }

    /**
     * Imprime una linea de asteriscos para mostrar la trama a modo de decoración
     * */
    public static void decoracion(String trama){
        for(int i = 0; i < trama.length(); i++)
            System.out.printf("*");
    }

    /**
     * Muestra los datos que envía cada estación, ejectuando el respectivo método de la estación
     * */
    public static void mostrarDatos(){
        System.out.println("\n DATOS DE CADA ESTACIÓN");
        estaciones.stream().forEach(e -> e.imprimirDatos());
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
        bits = numCaracter * 8; // Se supone que cada caracter es de 8 bits
    }

    /**
     * Permite agregar los respectivos caracteres a la estación
     * */
    public void addCaracters(){
        Scanner sc = new Scanner(System.in); // Scanner para leer de teclado
        System.out.println("Caracteres de Estación " + id);
        for(int i = 0; i < numCaracter; i++){
            System.out.printf("Caracter [" + (i + 1) + "] = ");
            data.add(new Character(sc.nextLine().charAt(0))); // Agrega el caracter a los datos de la estación
        }
        System.out.println("-------------------------------------");
    }

    /**
     * Retorna el número de caracteres que envía la estación
     * */
    public int getNumCaracter(){
        return numCaracter;
    }

    /**
     * Retorna el total de bits que envía la estación
     * */
    public int getBits(){
        return bits;
    }

    /**
     * Retorna el array de caracteres que envía la estación
     * */
    public ArrayList<Character> getData(){
        return data;
    }

    /**
     * Imprime los datos que envía y como los envía la estación (orden)
     * */
    public void imprimirDatos(){
        System.out.printf("ESTACIÓN " + id + " --> ENVÍA --> [ ");
        StringBuilder info = new StringBuilder();
        data.forEach(e -> info.append(e.toString()+ " "));
        System.out.printf(info + "] --> DE LA FORMA --> [" + info.reverse() + " ]\n");
    }
}