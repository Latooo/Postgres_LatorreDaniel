package Model;

public class InventarioVehiculos {

    private int id;
    private String nombre;
    private String marca;
    private String modelo;
    private String año;
    private int precio;
    private String estado; // Debe ser 'Nuevo' o 'Usado'

    public InventarioVehiculos(int id, String nombre, String marca, String modelo, String año, int precio, String estado) {
        this.id = id;
        this.nombre = nombre;
        this.marca = marca;
        this.modelo = modelo;
        this.año = año;
        this.precio = precio;
        if (!estado.equals("Nuevo") && !estado.equals("Usado")) {
            throw new IllegalArgumentException("Estado no válido");
        }
        this.estado = estado;
    }

    // Getters y setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getMarca() { return marca; }
    public void setMarca(String marca) { this.marca = marca; }

    public String getModelo() { return modelo; }
    public void setModelo(String modelo) { this.modelo = modelo; }

    public String getAño() { return año; }
    public void setAño(String año) { this.año = año; }

    public int getPrecio() { return precio; }
    public void setPrecio(int precio) { this.precio = precio; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) {
        if (!estado.equals("Nuevo") && !estado.equals("Usado")) {
            throw new IllegalArgumentException("Estado no válido");
        }
        this.estado = estado;
    }
}
