/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ittepic.edu.mx.clases;

import java.io.IOException;
import java.net.URLEncoder;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Properties;
import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.KeyGenerator;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

/**
 *
 * @author sears
 */
public class Mail {

    public int enviarMail(String nick, String correo) {
        try {
            Properties props = new Properties();
// Nombre del host de correo, es smtp.gmail.com
            props.setProperty("mail.smtp.host", "smtp.gmail.com");
// TLS si está disponible
            props.setProperty("mail.smtp.starttls.enable", "true");
// Puerto de gmail para envio de correos
            props.setProperty("mail.smtp.port", "587");
// Nombre del usuario
            props.setProperty("mail.smtp.user", "garyio.org@gmail.com");
// Si requiere o no usuario y password para conectarse.
            props.setProperty("mail.smtp.auth", "true");

            Session session = Session.getDefaultInstance(props);
            session.setDebug(true);

            //CREACION DEL MENSAJE
            MimeMessage message = new MimeMessage(session);
            // Quien envia el correo
            message.setFrom(new InternetAddress("FarmaciasSanCazola@gmail.com"));
// A quien va dirigido
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(correo));

            message.setSubject("MENSAJE CONFIRMACION- FARMACIAS SAN CAZOLA");
            message.setText("Enhorabuena, Tu cuenta en Farmacias San Cazola ha sido creada Exitosamente.\n"
                    + "Para activar tu cuenta ingresa al siguiente enlace:\n"
                    + "http://localhost:8080/Farmacia_AE/activacion.jsp?r=" + nick);
            //EVIAMOS EL CORREO
            Transport t = session.getTransport("smtp");
            t.connect("garyio.org@gmail.com", "tumamamemima1234");
            t.sendMessage(message, message.getAllRecipients());
            t.close();
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    public String encriptar(String nick) throws NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeyException, IllegalBlockSizeException, BadPaddingException {
        String claveEncriptada = null;
        String claveOriginal = nick;
        String semilla = "0123456789";

        // Generamos una clave secreta.
        SecretKeySpec desKey = new SecretKeySpec(new String((semilla.trim().concat("99999999")).substring(0, 8)).getBytes(), "DES");
        Cipher cipher = Cipher.getInstance("DES/ECB/PKCS5Padding");
        cipher.init(Cipher.ENCRYPT_MODE, desKey);
        byte[] claveEncriptadaBytes = cipher.doFinal(claveOriginal.getBytes());
        claveEncriptada = new BASE64Encoder().encode(claveEncriptadaBytes);
        return claveEncriptada;
    }

    public String desencriptar(String nick) throws IOException, NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeyException, IllegalBlockSizeException, BadPaddingException {
        String cadena = nick;
        String semilla = "0123456789";
        String cadenaDesencriptada = null;
        String tmp = new String((semilla.trim().concat("99999999")).substring(0, 8));

        byte[] claveDesc = new BASE64Decoder().decodeBuffer(cadena);
        SecretKeySpec desKey = new SecretKeySpec(tmp.getBytes(), "DES");

        Cipher cipher = Cipher.getInstance("DES/ECB/PKCS5Padding");
        cipher.init(Cipher.DECRYPT_MODE, desKey);

        cadenaDesencriptada = new String(cipher.doFinal(claveDesc));
        return cadenaDesencriptada;
    }
}
