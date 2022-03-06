## Triggers

***Crea  un disparador que asegure que el precio de cada producto sea un número mayor de 200.***

```sql
    delimiter $$
    create trigger actualizacion before insert on productos
    for each row
    if new.precio < 200 then set new.precio = 200;
    end if $$
    delimiter ;
```

***haz un disparador que cree un registro en la tabla nrojos con los campos cliente, cuenta, fecha y saldo cada vez que algún cliente se quede en números rojos en alguna de sus cuentas.***

```sql
delimiter $$
DROP TRIGGER IF EXISTS nums_rojos $$
create trigger nums_rojos before update on cuenta
for each row
if new.saldo <= 0 then insert into nrojos select fecha_creacion,cod_cliente,cod_cuenta,new.saldo from cuenta ;
end if $$
delimiter ;

use ebanca;
UPDATE cuenta SET saldo=saldo-1 WHERE cod_cuenta = 3;
SELECT * FROM ebanca.nrojos;
SELECT * FROM ebanca.cuenta;
```

***Haz lo necesario para que cada vez que hay un movimiento se actualice el saldo de la cuenta de ese cliente con ese movimiento, ya sea un ingreso o una retirada.***

```sql
delimiter $$
DROP TRIGGER IF EXISTS move$$
create trigger move after insert on movimiento
for each row
update cuenta a, movimiento b set a.saldo = a.saldo + NEW.cantidad where a.cod_cuenta = new.cod_cuenta;
end if $$
delimiter ;

INSERT INTO movimiento
(dni,fechahora,cantidad,idmov,cod_cuenta)
VALUES
(1,'2011-02-01',2,59,1);

SELECT * FROM ebanca.movimiento;
SELECT * FROM ebanca.cuenta;
```

***Haz lo necesario para que cada vez que un cliente de ebanca ingrese más de 1000€ se le bonifique con 100€, solo para clientes con cuentas que superen tres años de antigüedad y para movimientos realizados entre el 1 de enero de 2011 y el 31 de marzo de 2011.***

```sql
delimiter $$
DROP TRIGGER IF EXISTS bonus$$
create trigger bonus after insert on movimiento
for each row
if new.cantidad > 1000 then 
update cuenta a, movimiento b set a.saldo = a.saldo + 100 where a.cod_cuenta = new.cod_cuenta and a.fecha_creacion between '2011-01-01' and '2011-03-31';
update cuenta a, movimiento b set a.saldo = a.saldo + NEW.cantidad where a.cod_cuenta = new.cod_cuenta;
end if $$
delimiter ;

INSERT INTO `ebanca`.`movimiento`
(dni,fechahora,cantidad,idmov,cod_cuenta)
VALUES
(5,'2011-02-01',4000,3,8);

SELECT * FROM ebanca.movimiento;
SELECT * FROM ebanca.cuenta;
```

***Crea un trigger para impedir que se aumente el salario de un empleado en más de un 20%.***

```sql
delimiter $$
create trigger veinte after update on empleados for each row
begin
if new.salario < old.salario * 1.20 
then update empleados set new.salario = old.salario;
end if;
end $$
delimiter ;

UPDATE empleados SET salario=salario + 50 WHERE IdJefe= 7;
SELECT * FROM ebanca.empleados;
```

***Crea una tabla HISTORIAL que permita almacenar qué acciones se han realizado sobre la base de datos, qué usuario lo ha realizado y en qué momento. Cuando se produzca la actualización de un empleado, se indicará en la tabla de HISTORIAL.***

```sql
delimiter $$

CREATE TRIGGER NEWW AFTER INSERT ON EMPLEADOS FOR EACH ROW
BEGIN
INSERT INTO HISTORIAL(id, accion , fecha) 
VALUES (new.id, concat('se inserto nuevo empleado',' ',new.nomemp, new.fechaalta);
END$$
DELIMITER ;

INSERT INTO empleados (id,nomemp,salario,idjefe,fechaalta,fechabaja) 
values (57,'pepe',800,8,2021-03-02,2021-03-03);

SELECT * FROM ebanca.empleados;
SELECT * FROM ebanca.HISTORIAL;
```