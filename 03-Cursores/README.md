## Cursores

***Hacer un procedimiento sobre la BD ventas que muestre los datos de los empleados que no son vendedores y el nombre de su departamento.***

```sql
use ventas
DELIMITER $$
drop procedure if exists d_nvendedor $$
CREATE PROCEDURE d_nvendedor ()
BEGIN
	DECLARE num_filas INT DEFAULT 0;
    DECLARE cuenta_bucle INT DEFAULT 0;
	declare nom_dep char(20);
	declare voficio varchar(10);
	declare nombre varchar(30);
	declare nomina decimal(6,2);
	declare no_vendedor cursor for select a.dnombre,b.oficio,b.apellido,b.salario from departamentos a,empleados b where b.oficio not like "VENDEDOR" and a.dep_no=b.dep_no;
    SELECT FOUND_ROWS( ) INTO num_filas;
	open no_vendedor;
	while cuenta_bucle < num_filas do
		BEGIN
			FETCH no_vendedor into nom_dep,voficio,nombre,nomina;
            set cuenta_bucle = cuenta_bucle + 1;
		END;
	END WHILE;
    CLOSE no_vendedor;
END $$
delimiter ;
call d_nvendedor();
```

***Al ejercicio anterior, añadir que para los empleados cuyo departamento sea MADRID, le subamos el sueldo un 10%***

```sql
use ventas
DELIMITER $$
drop procedure if exists d_nvendedor $$
CREATE PROCEDURE d_nvendedor ()
BEGIN
	DECLARE num_filas INT DEFAULT 0;
    DECLARE cuenta_bucle INT DEFAULT 0;
	declare nom_dep char(20);
	declare voficio varchar(10);
	declare nombre varchar(30);
	declare nomina decimal(6,2);
	declare no_vendedor cursor for select a.dnombre,b.oficio,b.apellido,b.salario from departamentos a,empleados b where b.oficio not like "VENDEDOR" and a.localidad like "MADRID" and a.dep_no=b.dep_no;
    SELECT FOUND_ROWS( ) INTO num_filas;
	open no_vendedor;
	while cuenta_bucle < num_filas do
		BEGIN
			FETCH no_vendedor into nom_dep,voficio,nombre,nomina;
            set nomina = nomina * 1.10;
            update empleados set salario = nomina where apellido = nombre;
            set cuenta_bucle = cuenta_bucle + 1;
		END;
	END WHILE;
    CLOSE no_vendedor;
END $$
delimiter ;
call d_nvendedor();
```

***La empresa va a sufrir obras en la sede en la que se encuentra el despacho “1” y todos los trabajadores de este despacho se van a tener que trasladar al despacho “5”. Recorre la tabla de DIRECTORES, registro a registro, actualizando la información para que nuestra base de datos recoja esta circunstancia.***

**Tabla**

```sql
INSERT INTO `despachos` VALUES (1,1),(2,2),(3,5);
INSERT INTO `directores` VALUES ('D1','Director 1',NULL,1),('D2','Director 2','D1',2),('D21','Director 21','D2',2),('D22','Director 22','D2',2),('D3','Director 3','D1',3),('D31','Director 31','D3',NULL);
```
```sql
DELIMITER $$
DROP PROCEDURE IF EXISTS change_des $$
CREATE PROCEDURE change_des ()
BEGIN
DECLARE cont_filas INT DEFAULT 0;
DECLARE con_bucle INT DEFAULT 0;
DECLARE ndespacho int;
declare cambio_des cursor for select despacho from directores where despacho = 1;
select COUNT(*) FROM directores into cont_filas;
open cambio_des;
	WHILE con_bucle < cont_filas  DO
		BEGIN
			fetch cambio_des into ndespacho;
			update directores set despacho = 5 where despacho = 1;
			set con_bucle = con_bucle + 1;
		END;
    END WHILE;
close cambio_des;
END $$
DELIMITER ;
call change_des();
```

**Resultado**

> Antes

> Después

***Debido a una serie de cambios en la empresa, se va a producir un intercambio entre los directores D1 y D3. A partir de ese momento, los empleados que tenían como jefe al director D1 pasarán a tener como director al director D3 y viceversa. Realiza una rutina que permita implementar lo anterior.***

### Ejercicio incompleto

```sql
DELIMITER $$
DROP PROCEDURE IF EXISTS change_dir $$
CREATE PROCEDURE change_dir ()
BEGIN
DECLARE cont_filas INT DEFAULT 0;
DECLARE cont_bucle INT DEFAULT 0;
DECLARE ddirectores1 varchar(45);
DECLARE ddirectores3 varchar(45);
declare cambio_des_d1 cursor for select directorescol from directores where directorescol="D1";
declare cambio_des_d3 cursor for select directorescol from directores where directorescol="D3";
select COUNT(*) FROM directores into cont_filas; 

open cambio_des_d1; #cambio de D3 a D1
	WHILE cont_bucle < cont_filas  DO 
		BEGIN
			fetch cambio_des_d1 into ddirectores1;
            update directores set directorescol = ddirectores1 where directorescol = "D3";
			set cont_bucle = cont_bucle + 1;
		END;
    END WHILE;
close cambio_des_d1;

open cambio_des_d3;##cambio D1 a D3
	WHILE cont_bucle < cont_filas  DO
		BEGIN
			fetch cambio_des_d3 into ddirectores3;
            update directores set directorescol = ddirectores3 where directorescol = "D1";
			set cont_bucle = cont_bucle + 1;
		END;
    END WHILE;
close cambio_des_d3;

END $$
DELIMITER ;
call change_dir();
```

**Resultado**

>Antes

> Después
