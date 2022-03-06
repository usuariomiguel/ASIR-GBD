# Funciones
## Funciones Basicos
***Crea una función que devuelva el valor de la hipotenusa de un triángulo a partir de los valores de sus lados. Utiliza la base de datos Ventas.***
```sql
delimiter $$
drop function if exists nueva$$
create function nueva (lado1 integer, lado2 integer)
returns int
deterministic
begin
    ##INICIO DE ACCIONES
    declare hipotenusa int;
            SET hipotenusa = ROUND(SQRT((lado1 * lado1) + (lado2 * lado2)), 0);
    return hipotenusa;
    ##FIN DE ACCIONES
end$$
delimiter ;
select nueva (50,60);
```
***Crea una función que calcule el total de puntos en un partido de baloncesto tomando como entrada el resultado en formato 'xxx-xxx'. Utiliza la base de datos Ventas.***
```sql
delimiter $$
drop function if exists EJER2$$
create function EJER2 (n varchar(30))
returns varchar(30)
deterministic
begin
    RETURN substring_index(n,'-',1) - right(n,4);
end$$
delimiter ;
select EJER2 ("015-040");
```
***Crea una función que calcule el número de años transcurridos entre 2 fechas donde la primera es menor que la segunda (para probarlo calcula tu edad introduciendo tu fecha de nacimiento y la fecha actual).***
```sql
delimiter //
drop function if exists años$$
create function años (hi varchar(20),ho date)
returns varchar(20)
deterministic
begin
    RETURN substring_index(ho,'-',1) - substring_index(hi,'-',1);
end//
delimiter ;
select años ('1993-12-09', curdate());
```
***Crea una función  que devuelva  la edad media de los ciclistas que han ganado alguna etapa. Utiliza la base de datos Ciclistas.***
```sql
delimiter $$
drop function if exists ganadores$$
create function ganadores (numero int) returns int
deterministic
begin
    declare nom int;
    select count(c.nombre) into nom from ciclistas c, etapas e where e.dorsalganador > numero and e.dorsalganador = c.dorsal;
    return nom;
end$$
delimiter ; 
select ganadores (1);
```
## Funciones con IF
***Crea una función que devuelva el mayor de tres números pasados como parámetros, sin usar la función GREATEST. Utiliza la base de datos Ventas.***
```sql
delimiter $$
drop function if exists el_mayor;
create function el_mayor(n1 int, n2 int, n3 int) returns varchar(20)
deterministic
begin
    declare var int;
    if n1 >= n2 and n1 >= n3 then 
        select n1 into var;
    elseif n2 >= n1 and n2 >= n3 then 
        select n2 into var;
    else 
        select n3 into var;
    end if;
    return var;
end;$$
select el_mayor(75,80,55);
```
```sql
delimiter $$
drop function if exists recuento;
create function recuento (resultado varchar(20)) returns varchar(25)
deterministic
begin
    declare equip1 varchar(15);
    declare equip2  varchar(15);
    declare ganador varchar(15);
    select substring_index(resultado, '-', 1) into equip1;
    select substring(resultado, 5, 3) into equip2;
        if equip1 > equip2 then 
            select equip1 into ganador;
            else 
            select equip2 into ganador;
        end if;
return ganador;
end;$$
SELECT recuento('012-011') AS "Resultado";
```
***Crea una función que diga si una palabra, pasada como parámetro, es palíndroma (por ejemplo: radar, reconocer, sometemos,  ...). Devuelve 1 si es palíndroma y 0 en caso contrario.Utiliza la base de datos Ventas.***
```sql
delimiter $$
drop function if exists palindroma;
create function palindroma (palabra varchar(20)) returns varchar(20)
deterministic
begin
    declare resultado varchar(20);
    declare al_reves varchar(20);
    select reverse(right(palabra,100)) into al_reves;
        if al_reves = palabra then 
            set resultado = 'es polindroma';
        else
            set resultado = 'no es polindroma';
        end if;
    return resultado;
end;$$
select palindroma('daad');
```
***Crea una función que devuelva el valor “viejo” si la media de edad de los corredores de un equipo que se le pasa por parámetro es mayor que la media total de todos los corredores. Devolverá “joven” si la media del equipo es menor.***
```sql
delimiter $$
drop function if exists media_edad;
create function media_edad(annios int) returns varchar(20)
deterministic
begin
    declare result varchar(15);
    select round(avg(edad),0) from ciclistas into result;
        if result > annios THEN 
            SET result = 'JOVEN';
        ELSE 
            SET result = 'VIEJO';
        END IF;
    return result;
end;$$
SELECT media_edad(20);
```

## Funciones con CASE

```sql
delimiter $$
drop function if exists dias_semana;
create function dias_semana (dia int) returns varchar(15)
deterministic
begin
    declare numi varchar(15);
        CASE
            WHEN dia = 1 THEN select concat('lunes') into numi;
            WHEN dia = 2 THEN select concat('martes') into numi;
            WHEN dia = 3 THEN select concat('miercoles') into numi;
            WHEN dia = 4 THEN select concat('jueves') into numi;
            WHEN dia = 5 THEN select concat('viernes') into numi;
            WHEN dia = 6 THEN select concat('sabado') into numi;
            WHEN dia = 7 THEN select concat('domingo') into numi;
            ELSE 
            select concat('te pasastes de dia') into numi;
        END CASE;
    return numi;
end$$
delimiter ; 
select dias_semana (2);
```
```sql
DELIMITER $$
drop function if exists buenas;
CREATE FUNCTION buenas (numero int) returns varchar(100)
DETERMINISTIC
BEGIN
declare clave varchar(100);
if numero >= 8 then 
	case
		when numero / 8 = 6 then select '48 | 40 | 32 | 24 | 16 | 8' into clave;
		when numero / 8 = 5 then select '40 | 32 | 24 | 16 | 8' into clave ;
		when numero / 8 = 4 then select '32 | 24 | 16 | 8' into clave ;
		when numero / 8 = 3 then select '24 | 16 | 8' into clave ;
		when numero / 8 = 2 then select '16 | 8' into clave ;
		when numero / 8 = 1 then select '8' into clave ;
        when numero <> 16 or 32 or 24 or 8 or 40 or 48 then select 0 into clave;
	end case;
end if;
    return clave;
END$$
DELIMITER ;
select buenas(32) as 'multiplos de 8';
```