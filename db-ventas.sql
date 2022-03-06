drop database if exists ventasleon;
create database ventasleon;

use ventasleon;

create table departamentos  (
   dep_no  integer (2) primary key,
   dnombre  char(20) not null unique,
   localidad varchar(30)
);

create table empleados (
   emp_no integer(4) primary key,
   apellido  varchar(30) not null,
   oficio  varchar (10),
   director integer(4),
   fecha_alta date,
   salario numeric(6,2) not null,
   comision numeric(6,2),
   dep_no integer(2),
   constraint fk_director foreign key (director) references empleados  (emp_no),
   constraint fk_depto foreign key (dep_no) references departamentos (dep_no)
);

create table clientes (
   cli_no integer(3) primary key,
   nombre  varchar(50) not null,
   localidad varchar(30),
   vendedor_no  integer(4) not null,
   debe  numeric(8,2) not null default 0.00,
   haber  numeric(8,2) not null default 0.00,
   lim_credito  numeric(8,2) not null,
   constraint fk_vendedor foreign key (vendedor_no) references empleados (emp_no)
);

create table productos (
  producto_no integer (2) primary key,
  descripcion varchar (50) not null,
  precio numeric (8,2) not null,
  stock integer(4) not null
);

create table pedidos (
   pedido_no integer (4) primary key,
   producto_no integer (2) not null,
   cli_no   integer (3) not null,
   unidades integer (3) not null, 
   fecha date not null,
   constraint fk_producto foreign key (producto_no) references productos (producto_no),
   constraint fk_cliente foreign key (cli_no) references clientes (cli_no)
);

insert into departamentos (dep_no, dnombre, localidad)
values (10, 'CONTABILIDAD', 'BARCELONA'),
                (20, 'INVESTIGACION', 'VALENCIA'),
                (30, 'VENTAS', 'MADRID'), 
                (40, 'PRODUCCION', 'SEVILLA');


insert into empleados (emp_no, apellido, oficio, director, fecha_alta, salario, comision, dep_no)
VALUES  (7839, 'REY', 'PRESIDENTE', NULL, '1981-11-17', 6000.00, NULL, 10),
                 (7698, 'GARRIDO', 'DIRECTOR', 7839, '1981-05-01', 3850.00, NULL, 30),
                 (7782 , 'MARTINEZ', 'DIRECTOR', 7839, '1981-06-09', 2450.00, NULL,10),
                 (7499, 'ALONSO', 'VENDEDOR', 7698, '1981-02-20', 1400.00, 400.00, 30),
                 (7521, 'LOPEZ', 'EMPLEADO', 7782, '1981-05-08', 1350.00, NULL, 10),
                 (7654, 'MARTIN', 'VENDEDOR', 7698, '1981-09-28', 1500.00, 1600.00, 30),
                 (7844, 'CALVO', 'VENDEDOR', 7698, '1981-09-08', 1800.00, 0.00, 30),
                 (7876, 'GIL', 'ANALISTA', 7782, '1982-05-06', 3350.00, NULL, 20),
                 (7900, 'JIMENEZ', 'EMPLEADO', 7782, '1982-03-24', 1400.00, NULL, 20);

insert into clientes (cli_no, nombre, localidad, vendedor_no, debe, haber, lim_credito)
values (101, 'DISTRIBUCIONES GOMEZ', 'MADRID',7499, 0.00,0.00,5000.00), 	
                 (102, 'LOGITRONICA S.L.', 'CADIZ', 7654, 0.00, 0.00, 5000.00),
                 (103, 'INDUSTRIAS LACTEAS S.A.', 'LAS ROZAS', 7844, 0.00, 0.00, 10000.00),
                 (104, 'TALLERES ESTESO S.A.', 'SEVILLA', 7654, 0.00, 0.00, 5000.00),
                 (105, 'EDICIONES SANZ', 'CADIZ', 7499, 0.00, 0.00, 5000.00),
                 (106, 'SIGNOLOGIC S.A.', 'MADRID', 7654, 0.00, 0.00, 5000.00),
                 (107, 'MARTIN Y ASOCIADOS S.L.', 'ARAVACA', 7844, 0.00, 0.00, 10000.00),
                 (108, 'MANUFACTURAS ALI S.A.', 'SEVILLA', 7654, 0.00, 0.00, 5000.00);

insert into productos (producto_no, descripcion, precio, stock) 
values (10, 'MESA DESPACHO MOD.GAVIOTA', 550.00, 50),
       (20, 'SILLA DIRECTOR MOD.BUFALO', 670.00, 25),
       (30, 'ARMARIO NOGAL 2 PUERTAS', 460.00, 20),
       (40, 'MESA MOD.UNION', 340.00, 15),
       (50, 'ARCHIVADOR CEREZO', 1050.00, 20),
       (60, 'CAJA SEGURIDAD MOD.B222', 252.00, 15),
       (70, 'DESTRUCTORA DE PAPEL A3', 450.00, 25),
       (80, 'MODULO ORDENADOR MOD.ERGOS', 495.00, 25);

insert into pedidos (pedido_no, producto_no, cli_no, unidades, fecha)
values (1000, 20, 103, 3, '2009-10-06'),
       (1001, 50, 106, 2, '2009-10-06'),
       (1002, 10, 101, 4, '2009-10-07'),
       (1003, 20, 105, 4, '2009-10-16'),
       (1004, 40, 106, 8, '2009-10-20'),
       (1005, 30, 105, 2, '2009-10-20'),
       (1006, 70, 103, 3, '2009-11-03'),
       (1007, 50, 101, 2, '2009-11-06'),
       (1008, 10, 106, 6, '2009-11-16'),
       (1009, 20, 105, 2, '2009-11-26'),
       (1010, 40, 102, 3, '2009-12-08'),
       (1011, 30, 106, 2, '2009-12-15'),
       (1012, 10, 105, 3, '2009-12-06'),
       (1013, 30, 106, 2, '2009-12-06'),
       (1014, 20, 101, 4, '2010-01-07'),              
       (1015, 70, 105, 4, '2010-01-16');


