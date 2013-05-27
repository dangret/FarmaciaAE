package ittepic.edu.mx.clases;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.logging.*;
 
 
/**
 *
 * @author e0s87
 */
public class Codificador {
    /** * Clase con mÃ©todos estÃ¡ticos de cifrado * */
    public String encriptar(String texto, String algoritmo) {
         String output="";
        try {
           
            byte[] textBytes = texto.getBytes();
            MessageDigest md = MessageDigest.getInstance(algoritmo);
            md.update(textBytes);
            byte[] codigo = md.digest();            
            output = new String(codigo);
            
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(Codificador.class.getName()).log(Level.SEVERE, null, ex);
        }
        return output;
 
    }
    
    public Boolean comprobar(String textOriginal,String textMD5, String algoritmo){
        String output;
        try{
            byte[] textBytes = textOriginal.getBytes();
            MessageDigest md5 = MessageDigest.getInstance(algoritmo);
            md5.update(textBytes);
            byte[] codigo = md5.digest();            
            output = new String(codigo);
            
            if (output.equals(textMD5)) return true;
            else return false;
            
        }catch (NoSuchAlgorithmException e){
            Logger.getLogger(Codificador.class.getName()).log(Level.SEVERE, null, e);
            return null;
        }
        
        
    }
}
