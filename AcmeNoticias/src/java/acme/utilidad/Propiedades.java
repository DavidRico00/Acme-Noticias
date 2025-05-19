package acme.utilidad;

public class Propiedades {

    private static final Propiedades p = new Propiedades();
    public static Propiedades getInstance() {
        return p;
    }
    
    private final String HOST = "localhost";
    public final String ContextPath = "/acme";
    public final String redirect = "http://"+HOST+":8080"+ContextPath;

}
