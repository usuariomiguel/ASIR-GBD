CREATE DATABASE ebanca;

USE ebanca;

DROP TABLE IF EXISTS cliente;
CREATE TABLE cliente (
  codigo_cliente int(11) NOT NULL AUTO_INCREMENT,
  dni int(7) NOT NULL,
  nombre char(20) NOT NULL,
  apellido1 char(20) NOT NULL,
  apellido2 char(20) DEFAULT NULL,
  direccion char(50) NOT NULL,
  region varchar(45) DEFAULT NULL,
  PRIMARY KEY (codigo_cliente)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

INSERT INTO cliente VALUES (1,11111111,'jcarlos','baldo',NULL,'d1',NULL),
(2,22222222,'pilar','rodri',NULL,'d2',NULL),
(3,33333333,'pablo','babes',NULL,'d3',NULL),
(4,44444444,'javi','sonas',NULL,'d4',NULL),
(5,55555555,'angel','alva',NULL,'d5',NULL);

DROP TABLE IF EXISTS cuenta;
CREATE TABLE cuenta (
  fecha_creacion date NOT NULL,
  saldo int(11) NOT NULL DEFAULT '0',
  cod_cuenta int(11) NOT NULL,
  cod_cliente int(11) NOT NULL,
  PRIMARY KEY (cod_cuenta),
  KEY ccl (cod_cliente),
  KEY fc (fecha_creacion,cod_cliente),
  KEY cfc (fecha_creacion,cod_cliente)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO cuenta VALUES ('2010-01-01',100,1,1),
('2010-02-01',100,2,2),
('2009-02-13',4400,3,3),
('2011-12-13',-40,4,4),
('2011-06-23',20040,5,5);

DROP TABLE IF EXISTS movimiento;
CREATE TABLE movimiento (
  dni decimal(8,0) NOT NULL,
  fechahora date NOT NULL,
  cantidad double NOT NULL,
  idmov int(11) NOT NULL DEFAULT '0',
  cod_cuenta int(11) NOT NULL,
  KEY ccuenta (cod_cuenta)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO movimiento VALUES ('11111111','2011-04-18',64028,37,1),
('44444444','2011-04-18',60528,38,4),
('44444444','2011-04-18',13979,39,4),
('44444444','2011-04-18',26467,40,4),
('22222222','2011-04-18',6906,41,2),
('44444444','2011-04-18',47477,42,4),
('33333333','2011-04-18',15490,43,3),
('22222222','2011-04-18',57323,44,2),
('33333333','2011-04-18',67620,45,3),
('33333333','2011-04-18',61864,46,3),
('11111111','2011-04-18',35142,47,1),
('11111111','2011-04-18',87009,48,1),
('22222222','2011-04-18',11884,49,2),
('11111111','2011-04-18',1480,50,1),
('22222222','2011-04-18',75530,51,2),
('44444444','2011-04-18',32424,52,4),
('44444444','2011-04-18',86077,53,4),
('33333333','2011-04-18',96523,54,3),
('22222222','2011-04-18',35796,55,2),
('33333333','2011-04-18',99784,56,3);

DROP TABLE IF EXISTS nrojos;
CREATE TABLE nrojos (
  id int(11) NOT NULL AUTO_INCREMENT,
  fecha date DEFAULT NULL,
  ccliente int(7) DEFAULT NULL,
  ccuenta int(11) DEFAULT NULL,
  saldo int(11) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS num_rojos;
CREATE TABLE num_rojos (
  dnicliente int(11) DEFAULT NULL,
  ccuenta int(11) DEFAULT NULL,
  fecha date DEFAULT NULL,
  saldo int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS saldo_mes;
CREATE TABLE saldo_mes (
  saldototal int(11) DEFAULT NULL,
  mes int(11) DEFAULT NULL,
  anio int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS saldo_total;
CREATE TABLE saldo_total (
  sumsaldo decimal(32,0)
) ENGINE=MyISAM;

DROP TABLE IF EXISTS saldo_totalequipo;
CREATE TABLE saldo_totalequipo (
  sumsaldo decimal(32,0)
) ENGINE=MyISAM;

DROP TABLE IF EXISTS tiene;
CREATE TABLE tiene (
  dni decimal(8,0) NOT NULL,
  cod_cuenta decimal(20,0) NOT NULL,
  fecha_creacion char(1) NOT NULL,
  PRIMARY KEY (dni,cod_cuenta),
  UNIQUE KEY ID_tiene_IND (dni,cod_cuenta),
  KEY EQU_tiene_cuent_IND (cod_cuenta)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS tmp_mov;
CREATE TABLE tmp_mov (
  idmov int(11) NOT NULL,
  cuenta int(11) DEFAULT NULL,
  cantidad int(11) DEFAULT NULL,
  fecha date DEFAULT NULL,
  PRIMARY KEY (idmov)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
