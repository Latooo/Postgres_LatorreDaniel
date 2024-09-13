package View;

import Controller.InventarioVehiculosController;
import Model.InventarioVehiculos;

import java.util.List;
import java.util.Scanner;

public class InventarioVehiculosView {

    private InventarioVehiculosController controller;
    private Scanner scanner;

    public InventarioVehiculosView() {
        this.controller = new InventarioVehiculosController();
        this.scanner = new Scanner(System.in);
    }

    public void mostrarMenu() {
        while (true) {
            System.out.println("Menú Inventario de Vehículos");
            System.out.println("1. Añadir vehículo");
            System.out.println("2. Ver vehículo");
            System.out.println("3. Ver todos los vehículos");
            System.out.println("4. Actualizar vehículo");
            System.out.println("5. Eliminar vehículo");
            System.out.println("6. Salir");
            System.out.print("Elija una opción: ");

            int opcion = scanner.nextInt();
            scanner.nextLine(); // Limpiar el buffer

            switch (opcion) {
                case 1:
                    añadirVehiculo();
                    break;
                case 2:
                    verVehiculo();
                    break;
                case 3:
                    verTodosLosVehiculos();
                    break;
                case 4:
                    actualizarVehiculo();
                    break;
                case 5:
                    eliminarVehiculo();
                    break;
                case 6:
                    return;
                default:
                    System.out.println("Opción no válida.");
            }
        }
    }

    private void añadirVehiculo() {
        System.out.print("ID: ");
        int id = scanner.nextInt();
        scanner.nextLine(); // Limpiar el buffer

        System.out.print("Nombre: ");
        String nombre = scanner.nextLine();

        System.out.print("Marca: ");
        String marca = scanner.nextLine();

        System.out.print("Modelo: ");
        String modelo = scanner.nextLine();

        System.out.print("Año: ");
        String año = scanner.nextLine();

        System.out.print("Precio: ");
        int precio = scanner.nextInt();
        scanner.nextLine(); // Limpiar el buffer

        System.out.print("Estado (Nuevo/Usado): ");
        String estado = scanner.nextLine();

        try {
            InventarioVehiculos vehiculo = new InventarioVehiculos(id, nombre, marca, modelo, año, precio, estado);
            controller.crearVehiculo(vehiculo);
        } catch (IllegalArgumentException e) {
            System.err.println("Error al añadir el vehículo: " + e.getMessage());
        }
    }

    private void verVehiculo() {
        System.out.print("Ingrese el ID del vehículo: ");
        int id = scanner.nextInt();
        scanner.nextLine(); // Limpiar el buffer

        InventarioVehiculos vehiculo = controller.obtenerVehiculo(id);
        if (vehiculo != null) {
            System.out.println("ID: " + vehiculo.getId());
            System.out.println("Nombre: " + vehiculo.getNombre());
            System.out.println("Marca: " + vehiculo.getMarca());
            System.out.println("Modelo: " + vehiculo.getModelo());
            System.out.println("Año: " + vehiculo.getAño());
            System.out.println("Precio: " + vehiculo.getPrecio());
            System.out.println("Estado: " + vehiculo.getEstado());
        } else {
            System.out.println("Vehículo no encontrado.");
        }
    }

    private void verTodosLosVehiculos() {
        List<InventarioVehiculos> vehiculos = controller.obtenerTodosLosVehiculos();
        if (vehiculos != null && !vehiculos.isEmpty()) {
            for (InventarioVehiculos vehiculo : vehiculos) {
                System.out.println("ID: " + vehiculo.getId());
                System.out.println("Nombre: " + vehiculo.getNombre());
                System.out.println("Marca: " + vehiculo.getMarca());
                System.out.println("Modelo: " + vehiculo.getModelo());
                System.out.println("Año: " + vehiculo.getAño());
                System.out.println("Precio: " + vehiculo.getPrecio());
                System.out.println("Estado: " + vehiculo.getEstado());
                System.out.println("-------------------------");
            }
        } else {
            System.out.println("No hay vehículos en el inventario.");
        }
    }

    private void actualizarVehiculo() {
        System.out.print("ID del vehículo a actualizar: ");
        int id = scanner.nextInt();
        scanner.nextLine(); // Limpiar el buffer

        System.out.print("Nuevo nombre: ");
        String nombre = scanner.nextLine();

        System.out.print("Nueva marca: ");
        String marca = scanner.nextLine();

        System.out.print("Nuevo modelo: ");
        String modelo = scanner.nextLine();

        System.out.print("Nuevo año: ");
        String año = scanner.nextLine();

        System.out.print("Nuevo precio: ");
        int precio = scanner.nextInt();
        scanner.nextLine(); // Limpiar el buffer

        System.out.print("Nuevo estado (Nuevo/Usado): ");
        String estado = scanner.nextLine();

        try {
            InventarioVehiculos vehiculo = new InventarioVehiculos(id, nombre, marca, modelo, año, precio, estado);
            controller.actualizarVehiculo(vehiculo);
        } catch (IllegalArgumentException e) {
            System.err.println("Error al actualizar el vehículo: " + e.getMessage());
        }
    }

    private void eliminarVehiculo() {
        System.out.print("ID del vehículo a eliminar: ");
        int id = scanner.nextInt();
        scanner.nextLine(); // Limpiar el buffer

        controller.eliminarVehiculo(id);
    }
}
