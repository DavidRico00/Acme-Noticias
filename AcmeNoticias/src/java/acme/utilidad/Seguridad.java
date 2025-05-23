package acme.utilidad;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Formatter;

public class Seguridad {
    public static String pwdMD5(String pwd){
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] hashBytes = md.digest(pwd.getBytes());
            
            Formatter formatter = new Formatter();
            for (byte b : hashBytes) {
                formatter.format("%02x", b);
            }
            return formatter.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error al encriptar: " + e);
        }
    }
}
