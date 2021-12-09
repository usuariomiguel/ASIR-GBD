delimiter @@

drop procedure if exists act_pago@@

create procedure act_pago()

begin


declare fecha_max date;

declare salir int default 0;

declare id varchar(50);

declare fecha date;

declare cursor_pago cursor for select id_transaccion, fecha_pago from pago;

declare continue handler for not found set salir = 1;

select max(fecha_pago) from pago into fecha_max;

open cursor_pago;

bucle: LOOP

fetch cursor_pago into id,fecha;

if (salir = 1) then

leave bucle;

end if;

if (fecha < fecha_max) then

update pago set fecha_pago = date_format(date_add(fecha, interval (year(fecha_max) -

year(fecha))year), '%Y-%m-%d')

where id_transaccion = id;

end if;

end loop;

close cursor_pago;

end@@



delimiter ;