DROP DATABASE IF EXISTS taller_mecanico_db;
CREATE DATABASE taller_mecanico_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE taller_mecanico_db;

CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(30) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE marca (
    id_marca INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE modelo (
    id_modelo INT AUTO_INCREMENT PRIMARY KEY,
    id_marca INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT fk_modelo_marca FOREIGN KEY (id_marca)
        REFERENCES marca(id_marca)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    usuario VARCHAR(50) NOT NULL UNIQUE,
    clave_hash VARCHAR(255) NOT NULL,
    rol VARCHAR(50) NOT NULL,
    activa BOOLEAN NOT NULL DEFAULT TRUE
) ENGINE=InnoDB;

CREATE TABLE vehiculo (
    id_vehiculo INT AUTO_INCREMENT PRIMARY KEY,
    placa VARCHAR(20) NOT NULL UNIQUE,
    id_cliente INT NOT NULL,
    id_modelo INT NOT NULL,
    anio INT NOT NULL,
    color VARCHAR(30),
    notas TEXT,
    CONSTRAINT fk_vehiculo_cliente FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_vehiculo_modelo FOREIGN KEY (id_modelo)
        REFERENCES modelo(id_modelo)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE servicio (
    id_servicio INT AUTO_INCREMENT PRIMARY KEY,
    id_vehiculo INT NOT NULL,
    id_usuario INT NOT NULL,
    fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    lectura_odometro INT,
    unidad VARCHAR(20),
    proximo_cambio INT,
    observacion TEXT,
    CONSTRAINT fk_servicio_vehiculo FOREIGN KEY (id_vehiculo)
        REFERENCES vehiculo(id_vehiculo)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_servicio_usuario FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE tipo_item (
    id_tipo_item INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE ficha_tecnica (
    id_vehiculo INT NOT NULL,
    id_tipo_item INT NOT NULL,
    descripcion TEXT,
    viscosidad VARCHAR(30),
    cantidad DECIMAL(10, 2),
    PRIMARY KEY (id_vehiculo, id_tipo_item),
    CONSTRAINT fk_fichatec_vehiculo FOREIGN KEY (id_vehiculo)
        REFERENCES vehiculo(id_vehiculo)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_fichatec_tipoitem FOREIGN KEY (id_tipo_item)
        REFERENCES tipo_item(id_tipo_item)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE detalle_servicio (
    id_servicio INT NOT NULL,
    id_tipo_item INT NOT NULL,
    descripcion TEXT,
    PRIMARY KEY (id_servicio, id_tipo_item),
    CONSTRAINT fk_detalleserv_servicio FOREIGN KEY (id_servicio)
        REFERENCES servicio(id_servicio)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_detalleserv_tipoitem FOREIGN KEY (id_tipo_item)
        REFERENCES tipo_item(id_tipo_item)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;