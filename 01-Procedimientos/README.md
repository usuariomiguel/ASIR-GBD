# Procedimientos
## Basicos
***Sobre la base de ventas crea un procedimiento para mostrar el año actual.***
```sql
create*procedure*anioactual()
    select*curdate();
call anioactual();
```
***Crea un procedimiento que muestre las tres primeras letras de una cadena pasada como parámetro y en mayúsculas. Utiliza la base de datos Ventas.***
```sql
drop procedure if exists pocas_letras;
create*procedure pocas_letras*(palabras*varchar(15))
    select*left(palabras,3);
call pocas_letras('Monteiguelso');
```
***Crea un procedimiento que devuelva el nombre de los ciclistas que pertenezcan al mismo equipo que un corredor que se le pasa por parámetro. Utiliza la base de datos Ciclistas***
```sql
use ciclistascompleta;
drop procedure if exists devuelve_nombre;
create procedure devuelve_nombre(nombr varchar(20))
    select nombre from ciclistas where nomeq IN (select nomeq from ciclistas where nombre like nombr);
call devuelve_nombre('Miguel Induráin'); 
```
***Crea un procedimiento que devuelva el nombre de los ciclistas con mas años que los que se le pasa por parámetro. Utiliza la base de datos Ciclistas***
```sql
use ciclistascompleta;
drop procedure if exists mas_años;
create procedure mas_años(años int)
    select nombre from ciclistas where edad > años;
call mas_años('30');
```
***Crea un procedimiento que devuelva  el valor del atributo netapa de aquellas etapas tales que todos los puertos que están en ellas tenga más los metros que se le pasa por parámetro. Utiliza la base de datos Ciclistas.***
```sql
use ciclistascompleta;
drop procedure if exists mas_altura;
create procedure mas_altura(alt int)
    SELECT * FROM puertos p, etapas e where p.altura > alt group by p.nombre;
call mas_altura(1200); 
```
***Crear un procedimiento que devuelva el nombre y el director de los equipos tales que todos sus ciclistas son mayores de una edad que se pasa por parámetro. Utiliza la base de datos Ciclistas.***
```sql
use ciclistascompleta;
drop procedure if exists mas_años;
create procedure mas_años(años int)
    select e.nombre, e.director from equipos e, ciclistas c where c.edad > años;
call mas_años('30'); 
```
***Crear un procedimiento que devuelva el valor del atributo netapa, la ciudad de salida y la ciudad de llegada de las etapas de más de un determinado número de kilómetros  y   un mínimo de puertos que se pasan por parámetros.  Utiliza la base de datos Ciclistas.***
```sql
use ciclistascompleta;
drop procedure if exists recorrido;
create procedure recorrido(km int, puertos int)
    SELECT numero, salida, llegada FROM etapas where numkms > km and numero > puertos;
call recorrido(100,2);
```
## IF y CASE
***Crea una función que reciba 2 números enteros y devuelva 1, si el primer número es divisible por el otro y 0, en caso contrario. Utiliza la base de datos Ventas.***
```sql
use ventas
delimiter $$
drop procedure if exists numeros;
create procedure números (n1 int, n2 int)
DETERMINISTIC
begin 
    IF (n1 > n2) THEN 
        SELECT n1 / n2 ;
    ELSE 
        SELECT CONCAT(' no es visible');
    END IF;
end$$
call números('40','50');
```
### LOOP
***Crea un procedimiento que muestre por pantalla los números del 1 al 10.***
```sql
DELIMITER $$
CREATE PROCEDURE simple_loop ( )
    BEGIN
    DECLARE counter BIGINT DEFAULT 0;
    
    my_loop: LOOP
        SET counter=counter+1;

        IF counter=10 THEN
        LEAVE my_loop;
        END IF;

        SELECT counter;

    END LOOP my_loop;
    END$$
DELIMITER ;
call simple_loop();
```
***Crea un procedimiento que reciba dos números y haga la cuenta atrás desde el mayor hasta el menor. El orden de los números es aleatorio, hay que comprobar cual es el mayor y el menor.***
```sql
delimiter $$
drop procedure if exists lp $$
create procedure lp(n1 int, n2 int)
begin
	declare iguales varchar(15);
	l1: loop
    		IF  n1 = n2 THEN 
				leave l1;
			END IF;
			IF n1 > n2 THEN 
				set n1 = n1 - 1;
			ELSEIF n2 > n1 THEN
				set n2 = n2 - 1;
			ELSE
				SET  iguales = "son iguales";
			END IF;
	end loop l1;
    select n1,n2;
end$$
delimiter ;
call lp(15,20);
```
***