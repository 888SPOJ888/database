CREATE DATABASE PRUEBA;

CREATE TABLE Cliente(
    CL_ID SERIAL NOT NULL,
    nombre_cliente VARCHAR,
	rut_cliente VARCHAR(15) NOT NULL,
    direccion_cliente VARCHAR,
    PRIMARY KEY (CL_ID)
);

CREATE TABLE Factura(
    numero_factura SERIAL NOT NULL,
    fecha_factura DATE,
    id_cliente INT NOT NULL,
    PRIMARY KEY (Numero_Factura),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(CL_ID)
);

CREATE TABLE Categoria(
    id_categoria SERIAL NOT NULL,
    descripcion_categoria VARCHAR,
    nombre_categoria VARCHAR NOT NULL,
    PRIMARY KEY (id_categoria)
);

CREATE TABLE Producto(
    id_producto SERIAL NOT NULL,
    nombre_producto VARCHAR NOT NULL,
	descripcion_producto VARCHAR,
    valor_unitario FLOAT NOT NULL,
    categoria_producto INT NOT NULL,
    PRIMARY KEY (id_producto),
    FOREIGN KEY (categoria_producto) REFERENCES Categoria(id_categoria)
);

CREATE TABLE Producto_Factura(
    Num_Factura INT NOT NULL,
    ID_Prod INT NOT NULL,
    cantidad_producto INT,
    PRIMARY KEY (ID_Prod,Num_Factura),
    FOREIGN KEY (ID_Prod) REFERENCES Producto(id_producto),
    FOREIGN KEY (Num_Factura) REFERENCES Factura(numero_factura) 
);