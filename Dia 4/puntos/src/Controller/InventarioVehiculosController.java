package Controller;

import DAO.InventarioVehiculosDAO;
import Model.InventarioVehiculos;

import java.sql.SQLException;
import java.util.List;

public class InventarioVehiculosController {

    private InventarioVehiculosDAO vehiculoDAO;

    public InventarioVehiculosController() {
        this.vehiculoDAO = new InventarioVehiculosDAO();
    }

    public void crearVehiculo(InventarioVehiculos vehiculo) {
        try {
            vehiculoDAO.addVehiculo(vehiculo);
            System.out.println("Vehículo añadido con éxito.");
        } catch (SQLException e) {
            System.err.println("Error al añadir el vehículo: " + e.getMessage());
        }
    }

    public InventarioVehiculos obtenerVehiculo(int id) {
        try {
            return vehiculoDAO.getVehiculoById(id);
        } catch (SQLException e) {
            System.err.println("Error al obtener el vehículo: " + e.getMessage());
        }
        return null;
    }

    public List<InventarioVehiculos> obtenerTodosLosVehiculos() {
        try {
            return vehiculoDAO.getAllVehiculos();
        } catch (SQLException e) {
            System.err.println("Error al obtener los vehículos: " + e.getMessage());
        }
        return null;
    }

    public void actualizarVehiculo(InventarioVehiculos vehiculo) {
        try {
            vehiculoDAO.updateVehiculo(vehiculo);
            System.out.println("Vehículo actualizado con éxito.");
        } catch (SQLException e) {
            System.err.println("Error al actualizar el vehículo: " + e.getMessage());
        }
    }

    public void eliminarVehiculo(int id) {
        try {
            vehiculoDAO.deleteVehiculo(id);
            System.out.println("Vehículo eliminado con éxito.");
        } catch (SQLException e) {
            System.err.println("Error al eliminar el vehículo: " + e.getMessage());
        }
    }
}
