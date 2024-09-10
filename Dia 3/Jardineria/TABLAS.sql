-- Tabla oficina

CREATE TABLE oficina(
    codigo_oficina VARCHAR(10) NOT NULL PRIMARY KEY,
    ciudad VARCHAR(30) NOT NULL,
    pais VARCHAR(50) NOT NULL,
    region VARCHAR(50),
    codigo_postal VARCHAR(10) NOT NULL,
    telefono VARCHAR(20),
    linea_direccion1 VARCHAR(50) NOT NULL,
    linea_direccion2 VARCHAR(50)
);

-- Tabla empleado

CREATE TABLE empleado(
    codigo_empleado INT PRIMARY KEY NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido1 VARCHAR(50) NOT NULL,
    apellido2 VARCHAR(50),
    extension VARCHAR(10) NOT NULL,
    email VARCHAR(100) NOT NULL,
    codigo_oficina VARCHAR(10) NOT NULL,
    codigo_jefe INT,
    puesto VARCHAR(50),
    FOREIGN KEY (codigo_oficina) REFERENCES oficina(codigo_oficina)
);

-- Tabla cliente

CREATE TABLE cliente(
    codigo_cliente INT PRIMARY KEY,
    nombre_cliente VARCHAR(50) NOT NULL,
    nombre_contacto VARCHAR(30),
    apellido_contacto VARCHAR(30),
    telefono VARCHAR(15) NOT NULL,
    fax VARCHAR(15),
    linea_direccion1 VARCHAR(50) NOT NULL,
    linea_direccion2 VARCHAR(50),
    ciudad VARCHAR(50) NOT NULL,
    region VARCHAR(50),
    pais VARCHAR(50),
    codigo_postal VARCHAR(10),
    codigo_empleado_rep_ventas INT,
    limite_credito DECIMAL(15,2),
    FOREIGN KEY (codigo_empleado_rep_ventas) REFERENCES empleado(codigo_empleado)
);

-- Tabla gama producto

CREATE TABLE gama_producto(
    gama VARCHAR(50) NOT NULL PRIMARY KEY,
    descripcion_texto TEXT,
    descripcion_html TEXT,
    imagen VARCHAR(256)
);

-- Tabla producto

CREATE TABLE producto(
    codigo_producto VARCHAR(15) PRIMARY KEY,
    nombre VARCHAR(70) NOT NULL,
    gama VARCHAR(50) NOT NULL,
    dimensiones VARCHAR(25),
    proveedor VARCHAR(50),
    descripcion TEXT,
    cantidad_en_stock SMALLINT NOT NULL,
    precio_venta DECIMAL(15,2) NOT NULL,
    precio_proveedor DECIMAL(15,2),
    FOREIGN KEY (gama) REFERENCES gama_producto(gama)
);

-- Tabla pedido

CREATE TABLE pedido(
    codigo_pedido INT PRIMARY KEY,
    fecha_pedido DATE NOT NULL,
    fecha_esperada DATE NOT NULL,
    fecha_entrega DATE,
    estado VARCHAR(15) NOT NULL,
    comentarios TEXT,
    codigo_cliente INT NOT NULL,
    FOREIGN KEY (codigo_cliente) REFERENCES cliente(codigo_cliente)
);

-- Tabla detalle pedido

CREATE TABLE detalle_pedido(
    codigo_pedido INT,
    codigo_producto VARCHAR(15),
    cantidad INT NOT NULL,
    precio_unidad DECIMAL(15,2),
    numero_linea SMALLINT,
    PRIMARY KEY (codigo_pedido, codigo_producto, numero_linea),
    FOREIGN KEY (codigo_pedido) REFERENCES pedido(codigo_pedido),
    FOREIGN KEY (codigo_producto) REFERENCES producto(codigo_producto)
);

-- Tabla pago

CREATE TABLE pago(
    codigo_cliente INT,
    forma_pago VARCHAR(40),
    id_transaccion VARCHAR(50) NOT NULL,
    fecha_pago DATE,
    total DECIMAL(15,2),
    PRIMARY KEY (codigo_cliente, id_transaccion),
    FOREIGN KEY (codigo_cliente) REFERENCES cliente(codigo_cliente)
);
