package DAO;

import Database.Database;
import Model.InventarioVehiculos;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class InventarioVehiculosDAO {

    public void addVehiculo(InventarioVehiculos vehiculo) throws SQLException {
        String sql = "INSERT INTO InventarioVehiculos (id, nombre, marca, modelo, año, precio, estado) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = Database.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, vehiculo.getId());
            pstmt.setString(2, vehiculo.getNombre());
            pstmt.setString(3, vehiculo.getMarca());
            pstmt.setString(4, vehiculo.getModelo());
            pstmt.setString(5, vehiculo.getAño());
            pstmt.setInt(6, vehiculo.getPrecio());
            pstmt.setString(7, vehiculo.getEstado()); // Estado como String

            pstmt.executeUpdate();
        }
    }

    public InventarioVehiculos getVehiculoById(int id) throws SQLException {
        String sql = "SELECT * FROM InventarioVehiculos WHERE id = ?";
        try (Connection conn = Database.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                return new InventarioVehiculos(
                    rs.getInt("id"),
                    rs.getString("nombre"),
                    rs.getString("marca"),
                    rs.getString("modelo"),
                    rs.getString("año"),
                    rs.getInt("precio"),
                    rs.getString("estado")
                );
            }
        }
        return null;
    }

    public List<InventarioVehiculos> getAllVehiculos() throws SQLException {
        List<InventarioVehiculos> vehiculos = new ArrayList<>();
        String sql = "SELECT * FROM InventarioVehiculos";
        try (Connection conn = Database.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                vehiculos.add(new InventarioVehiculos(
                    rs.getInt("id"),
                    rs.getString("nombre"),
                    rs.getString("marca"),
                    rs.getString("modelo"),
                    rs.getString("año"),
                    rs.getInt("precio"),
                    rs.getString("estado")
                ));
            }
        }
        return vehiculos;
    }

    public void updateVehiculo(InventarioVehiculos vehiculo) throws SQLException {
        String sql = "UPDATE InventarioVehiculos SET nombre = ?, marca = ?, modelo = ?, año = ?, precio = ?, estado = ? WHERE id = ?";
        try (Connection conn = Database.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, vehiculo.getNombre());
            pstmt.setString(2, vehiculo.getMarca());
            pstmt.setString(3, vehiculo.getModelo());
            pstmt.setString(4, vehiculo.getAño());
            pstmt.setInt(5, vehiculo.getPrecio());
            pstmt.setString(6, vehiculo.getEstado()); // Estado como String
            pstmt.setInt(7, vehiculo.getId());

            pstmt.executeUpdate();
        }
    }

    public void deleteVehiculo(int id) throws SQLException {
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        conn = Database.getConnection();
        conn.setAutoCommit(false); // Comenzar una transacción

        // Primero eliminar en la tabla Servicios
        String deleteServicios = "DELETE FROM Servicios WHERE id_vehiculo = ?";
        pstmt = conn.prepareStatement(deleteServicios);
        pstmt.setInt(1, id);
        pstmt.executeUpdate();

        // Luego eliminar en la tabla InventarioVehiculos
        String deleteVehiculo = "DELETE FROM InventarioVehiculos WHERE id = ?";
        pstmt = conn.prepareStatement(deleteVehiculo);
        pstmt.setInt(1, id);
        pstmt.executeUpdate();

        conn.commit(); // Confirmar la transacción
    } catch (SQLException e) {
        if (conn != null) {
            try {
                conn.rollback(); // Revertir la transacción en caso de error
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        throw e;
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
}
}
