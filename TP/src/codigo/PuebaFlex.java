package codigo;
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
/**
 *
 * @author Eugenia
 */
public class PuebaFlex {

    /**
     * @param args the command line arguments
     * @throws Exception 
     */
    public static void main(String[] args) throws Exception {
    	try {
            // TODO code application logic here
            FileReader f = new FileReader("pepe.txt");
            Lexico Lexer = new Lexico(f);
            parser sintac = new parser(Lexer);
            sintac.parse();
        } catch (FileNotFoundException ex) {
            System.out.println("No se encontro el archivo");
        }
        
    }
    
}
