import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;

public class ProyectoUnidad2 {

    public static void main(String[] args) {
        ProyectoUnidad2 p = new ProyectoUnidad2();
        Ventana v = new Ventana();
    }
}

class Ventana extends JFrame{

    private JLabel etqEntrada, resultado;
    private JTextArea txtEntrada;
    private JButton btnCalcular, btnBorrar;

    public  Ventana(){
        super("Fundamentos de Telecomunicaciones - Proyecto Unidad 2");
        setVisible(true);
        setResizable(false);
        setContentPane(getElements());
        setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        setSize(500, 500);
        setLocationRelativeTo(null);
        //revalidate();
    }

    public JPanel getElements(){
        SpringLayout s = new SpringLayout();
        JPanel panel = new JPanel(s);
        panel.setBackground(Color.GRAY);
        etqEntrada = new JLabel("Introduce (tren de bits / polinomio)",SwingConstants.CENTER);
        etqEntrada.setFont(new Font("Sylfaen", Font.BOLD, 17));
        txtEntrada = new JTextArea();

        panel.add(etqEntrada);
        s.putConstraint(SpringLayout.WEST, etqEntrada, 70, SpringLayout.WEST, panel);
        s.putConstraint(SpringLayout.EAST, etqEntrada, -70, SpringLayout.EAST, panel);
        s.putConstraint(SpringLayout.NORTH, etqEntrada, 100, SpringLayout.NORTH, panel);

        panel.add(txtEntrada);
        s.putConstraint(SpringLayout.WEST, txtEntrada, 100, SpringLayout.WEST, panel);
        s.putConstraint(SpringLayout.EAST, txtEntrada, -100, SpringLayout.EAST, panel);
        s.putConstraint(SpringLayout.NORTH, txtEntrada, 20, SpringLayout.SOUTH, etqEntrada);
        s.putConstraint(SpringLayout.SOUTH, txtEntrada, -300, SpringLayout.SOUTH, panel);

        btnCalcular = new JButton("Calcular");
        btnCalcular.setFont(new Font("Sylfaen", Font.BOLD, 17));
        panel.add(btnCalcular);
        s.putConstraint(SpringLayout.WEST, btnCalcular, 140, SpringLayout.WEST, panel);
        //s.putConstraint(SpringLayout.EAST, btnCalcular, -10, SpringLayout.EAST, panel);
        s.putConstraint(SpringLayout.NORTH, btnCalcular, 40, SpringLayout.SOUTH, txtEntrada);
        //s.putConstraint(SpringLayout.SOUTH, btnCalcular, -200, SpringLayout.SOUTH, panel);

        btnBorrar = new JButton("Borrar");
        btnBorrar.setFont(new Font("Sylfaen", Font.BOLD, 17));
        btnBorrar.setActionCommand("Borrar");
        panel.add(btnBorrar);
        s.putConstraint(SpringLayout.WEST, btnBorrar, 20, SpringLayout.EAST, btnCalcular);
        //s.putConstraint(SpringLayout.EAST, btnCalcular, -10, SpringLayout.EAST, panel);
        s.putConstraint(SpringLayout.NORTH, btnBorrar, 40, SpringLayout.SOUTH, txtEntrada);
        //s.putConstraint(SpringLayout.SOUTH, btnCalcular, -200, SpringLayout.SOUTH, panel);

        resultado = new JLabel("-------------------------------");
        resultado.setBackground(Color.RED);
        panel.add(resultado);
        s.putConstraint(SpringLayout.WEST, resultado, 170, SpringLayout.WEST, panel);
        s.putConstraint(SpringLayout.EAST, resultado, -170, SpringLayout.EAST, panel);
        s.putConstraint(SpringLayout.NORTH, resultado, 40, SpringLayout.SOUTH, btnCalcular);
        s.putConstraint(SpringLayout.SOUTH, resultado, -150, SpringLayout.SOUTH, panel);

        Controlador c = new Controlador();
        txtEntrada.addKeyListener(c);
        btnCalcular.addActionListener(c);
        btnBorrar.addActionListener(c);
        return panel;
    }


    public String polinomio_bits(String entrada){
        String bits = "";
        String[] data = entrada.split("\\+");
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


    class Controlador implements ActionListener, KeyListener {

        // Validar el orden de entrada
        @Override
        public void actionPerformed(ActionEvent e) {
            if(e.getActionCommand().equals("Borrar")){
                resultado.setText("-------------------------------");
                txtEntrada.setText("");
                return;
            }
            String entrada = txtEntrada.getText();
            if ( entrada.isEmpty() ||
                 (entrada.contains("x") && entrada.contains("0"))
            ) return;
            String salida = entrada.contains("0") && entrada.contains("1") ?
                            bits_polinomio(entrada) :
                            polinomio_bits(entrada);
            resultado.setText(salida);
            resultado.setAlignmentX(SwingConstants.CENTER);
        }

        @Override
        public void keyTyped(KeyEvent e) {
            char car = e.getKeyChar();
                if((car<'0' || car>'9') && (car<'x' || car>'x') && (car<'^' || car>'^') && (car<'+' || car>'+'))
                    e.consume();
        }

        @Override
        public void keyPressed(KeyEvent e) {}

        @Override
        public void keyReleased(KeyEvent e) {}
    }
}

