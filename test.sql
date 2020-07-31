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

#######ingresando clientes#######
INSERT INTO Cliente (nombre_cliente, rut_cliente, direccion_cliente)
VALUES ('Felipe Palacios', '13.867.234-1', 'Ethel de Viñeaux #678');

INSERT INTO Cliente (nombre_cliente, rut_cliente, direccion_cliente)
VALUES ('Valentina Malinarich', '18.329.168-K', 'Alonso de Ercilla # 8928');

INSERT INTO Cliente (nombre_cliente, rut_cliente, direccion_cliente)
VALUES ('Catalina Montt', '20.127.345-9', 'Diego Portales # 2333');

INSERT INTO Cliente (nombre_cliente, rut_cliente, direccion_cliente)
VALUES ('Ivory Happyhill', '12.435.655-3', 'Montt # 202');

INSERT INTO Cliente (nombre_cliente, rut_cliente, direccion_cliente)
VALUES ('Ignacio Vergara', '15.992.681-7', '26 sur # 67');

##############ingresando categorias############

INSERT INTO categoria (descripcion_categoria, nombre_categoria)
VALUES ('Productos para la limpieza', 'Detergentes');

INSERT INTO categoria (descripcion_categoria, nombre_categoria)
VALUES ('Productos del Mar', 'Pescados y Mariscos');

INSERT INTO categoria (descripcion_categoria, nombre_categoria)
VALUES ('Productos Femeninos', 'Balsamo, Shampoo y cremas');

##############productos############

INSERT INTO producto (nombre_producto, descripcion_producto, valor_unitario, categoria_producto)
VALUES ('OMO', 'Detergente liquido para diluir', '10000', 1);

INSERT INTO producto (nombre_producto, descripcion_producto, valor_unitario, categoria_producto)
VALUES ('Quix', 'Lavalozas Concentrado Limon', '5000', 1);

INSERT INTO producto (nombre_producto, descripcion_producto, valor_unitario, categoria_producto)
VALUES ('Cera Liquida Virginia', 'Proteccion intensa del piso de madera', '3500', 1);

INSERT INTO producto (nombre_producto, descripcion_producto, valor_unitario, categoria_producto)
VALUES ('Merluza', 'Filetes de Merluza sin Piel', '6500', 2);

INSERT INTO producto (nombre_producto, descripcion_producto, valor_unitario, categoria_producto)
VALUES ('Capaccio', 'Carpaccio de Salmon Doypack', '3890', 2);

INSERT INTO producto (nombre_producto, descripcion_producto, valor_unitario, categoria_producto)
VALUES ('Camaron con Cascara', 'Camaron Importado Cocido con Cascara', '11990', 2);

INSERT INTO producto (nombre_producto, descripcion_producto, valor_unitario, categoria_producto)
VALUES ('Ladysoft', 'Toalla higienica con alas ultradelgada tela suave', '1990', 3);

INSERT INTO producto (nombre_producto, descripcion_producto, valor_unitario, categoria_producto)
VALUES ('Pantene', 'Pack Shampoo 400 ml + Balsamo 500 ml Restauracion ', '4990', 3);

##############facturas#########

######2 para cliente 1#####
INSERT INTO factura (fecha_factura, id_cliente)
VALUES ('30-11-2019', 1);

INSERT INTO factura (fecha_factura, id_cliente)
VALUES ('02-12-2019', 1);

######3 para cliente 2#####

INSERT INTO factura (fecha_factura, id_cliente)
VALUES ('02-02-2020', 2);

INSERT INTO factura (fecha_factura, id_cliente)
VALUES ('20-02-2020', 2);

INSERT INTO factura (fecha_factura, id_cliente)
VALUES ('03-03-2020', 2);

######1 para cliente 3#####
INSERT INTO factura (fecha_factura, id_cliente)
VALUES ('03-01-2020', 3);

######4 para cliente 3#####
INSERT INTO factura (fecha_factura, id_cliente)
VALUES ('24-12-2019', 4);

INSERT INTO factura (fecha_factura, id_cliente)
VALUES ('28-12-2019', 4);

INSERT INTO factura (fecha_factura, id_cliente)
VALUES ('31-12-2019', 4);

INSERT INTO factura (fecha_factura, id_cliente)
VALUES ('22-01-2020', 4);

#####uniendo informacion entre producto y factura####

###factura Nr1###
INSERT INTO producto_factura (num_factura, id_prod, cantidad_producto)
VALUES (1, 1, 2);

INSERT INTO producto_factura (num_factura, id_prod, cantidad_producto)
VALUES (1, 8, 3);

###factura Nr2###
INSERT INTO producto_factura (num_factura, id_prod, cantidad_producto)
VALUES (2, 2, 3);

INSERT INTO producto_factura (num_factura, id_prod, cantidad_producto)
VALUES (2, 5, 2);

INSERT INTO producto_factura (num_factura, id_prod, cantidad_producto)
VALUES (2, 6, 3);

###factura Nr3
INSERT INTO producto_factura (num_factura, id_prod, cantidad_producto)
VALUES (3, 1, 1);

###factura Nr4###
INSERT INTO producto_factura (num_factura, id_prod, cantidad_producto)
VALUES (4, 2, 2);

INSERT INTO producto_factura (num_factura, id_prod, cantidad_producto)
VALUES (4, 5, 3);

INSERT INTO producto_factura (num_factura, id_prod, cantidad_producto)
VALUES (4, 6, 4);

INSERT INTO producto_factura (num_factura, id_prod, cantidad_producto)
VALUES (4, 8, 1);


#####questions###

question 1

SELECT nombre_cliente FROM Cliente WHERE CL_ID IN (SELECT id_cliente FROM Factura
WHERE numero_factura IN (SELECT nf FROM (SELECT Num_Factura AS nf,SUM(Cantidad_Producto* valor_unitario) AS Subtotal
FROM Producto,Producto_Factura WHERE id_producto = ID_Prod GROUP BY Num_Factura ORDER BY Subtotal DESC
LIMIT 1)as Best_client));


question 2

SELECT nombre_cliente FROM Cliente WHERE CL_ID IN (SELECT id_cliente FROM Factura
WHERE numero_factura IN (SELECT nf FROM (SELECT Num_Factura AS nf,SUM(Cantidad_Producto* valor_unitario) AS Subtotal
FROM Producto,Producto_Factura WHERE id_producto = ID_Prod GROUP BY Num_Factura ORDER BY Subtotal DESC)AS The_expensive
WHERE Subtotal > 5990
));

question 3

SELECT COUNT (CL_ID) AS Number_cl FROM (SELECT DISTINCT CL_ID
FROM Cliente,Factura,producto_factura WHERE ID_Prod = 6 
and Numero_Factura=Num_Factura and CL_ID = ID_Cliente) 
AS the_winner1;
