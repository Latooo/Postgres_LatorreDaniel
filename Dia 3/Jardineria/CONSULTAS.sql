--Consultas sobre una tabla
--1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.

select codigo_oficina, ciudad from oficina;

--2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.

select ciudad, telefono from oficina where pais = 'España';


--3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo
--jefe tiene un código de jefe igual a 7.

select nombre, apellido1, apellido2, email from empleado where codigo_jefe = '7';


--4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la
--empresa.

SELECT puesto,nombre,apellido1,apellido2,email
FROM empleado
WHERE codigo_jefe is null;

--5. Devuelve un listado con el nombre, apellidos y puesto de aquellos
--empleados que no sean representantes de ventas.

SELECT nombre,apellido1,apellido2,puesto
FROM empleado
WHERE puesto <> 'Representante de Ventas';

--6. Devuelve un listado con el nombre de los todos los clientes españoles.

SELECT nombre_cliente
FROM cliente
WHERE pais = 'Spain';

--7. Devuelve un listado con los distintos estados por los que puede pasar un
--pedido.

SELECT distinct estado
FROM pedido;

--8. Devuelve un listado con el código de cliente de aquellos clientes que
--realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar
--aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:

SELECT DISTINCT codigo_cliente 
FROM pago 
WHERE extract (year from fecha_pago) = 2008;

--9. Devuelve un listado con el código de pedido, código de cliente, fecha
--esperada y fecha de entrega de los pedidos que no han sido entregados a
--tiempo.

SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega 
FROM pedido 
WHERE fecha_entrega > fecha_esperada;

-- 10.Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos 
-- cuya fecha de entrega ha sido al menos dos días antes de la fecha esperada.

SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega 
FROM pedido 
WHERE fecha_entrega <= (fecha_esperada - INTERVAL '2 DAYS');

-- 11.Devuelve un listado de todos los pedidos que fuerON en 2009.

SELECT * 
FROM pedido
where extract (year from fecha_entrega) = 2009;

-- 12.Devuelve un listado de todos los pedidos que han sido en el mes de enero de cualquier año.

SELECT *
FROM pedido
WHERE extract (month from fecha_entrega) = '1';

-- 13.Devuelve un listado cON todos los pagos que se realizarON en el año 2008 mediante Paypal. Ordene el resultado de mayor a menor.alter

SELECT * 
FROM pago 
WHERE extract (year from fecha_pago) = 2008 
  AND forma_pago = 'PayPal' 
ORDER BY total DESC;

-- 14.Devuelve un listado cON todas las formas de pago que aparecen en la tabla pago.

SELECT forma_pago
FROM pago;

-- 15.Devuelve un listado cON todos los productos que pertenecen a la gama Ornamentales y que tienen más de 100 unidades en stock. 
-- El listado deberá estar ordenado por su precio de venta, mostrANDo en primer lugar los de mayor precio.

SELECT *
FROM producto
WHERE gama ='Ornamentales'
AND cantidad_en_stock = 100
ORDER BY precio_venta DESC;

-- 16.Devuelve un listado cON todos los clientes que sean de la ciudad de Madrid 
-- y cuyo representante de ventas tenga el código de empleado 11 o 30.

SELECT *
FROM cliente
WHERE ciudad = 'Madrid'
AND codigo_empleado_rep_ventas IN (11, 30);

-- Consultas multitabla (Composición interna)

-- 1.Obtén un listado cON el nombre de cada cliente y el nombre y apellido de su representante de ventas.
SELECT cliente.nombre_cliente, empleado.nombre, empleado.apellido1, empleado.apellido2 
FROM cliente
INNER JOIN empleado ON cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado;

-- 2.Nombre de los clientes que hayan realizado pagos junto cON el nombre de sus representantes de ventas.
SELECT cliente.nombre_cliente, empleado.nombre, empleado.apellido1, empleado.apellido2 
FROM cliente
INNER JOIN pago ON cliente.codigo_cliente = pago.codigo_cliente
INNER JOIN empleado ON cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado;

-- 3.Nombre de los clientes que han hecho pagos 
-- y el nombre de sus representantes junto cON la ciudad de la oficina a la que pertenece el representante.
SELECT cliente.nombre_cliente, empleado.nombre, empleado.apellido1, empleado.apellido2, oficina.ciudad
FROM cliente
INNER JOIN pago ON cliente.codigo_cliente = pago.codigo_cliente
INNER JOIN empleado ON cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
INNER JOIN oficina ON empleado.codigo_oficina = oficina.codigo_oficina;

-- 4. Nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes 
-- junto cON la ciudad de la oficina a la que pertenece el representante.
SELECT cliente.nombre_cliente, empleado.nombre, empleado.apellido1, empleado.apellido2, oficina.ciudad
FROM cliente
LEFT JOIN pago ON cliente.codigo_cliente = pago.codigo_cliente
INNER JOIN empleado ON cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
INNER JOIN oficina ON empleado.codigo_oficina = oficina.codigo_oficina
WHERE pago.codigo_cliente IS NULL;

-- 5.Dirección de las oficinas que tengan clientes en Fuenlabrada.
SELECT DISTINCT oficina.linea_direcciON1, oficina.linea_direcciON2
FROM cliente
INNER JOIN empleado ON cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
INNER JOIN oficina ON empleado.codigo_oficina = oficina.codigo_oficina
WHERE cliente.ciudad = 'Fuenlabrada';

-- 6. Nombre de los clientes y el nombre de sus representantes junto cON la ciudad de la oficina a la que pertenece el representante.
SELECT cliente.nombre_cliente, empleado.nombre, empleado.apellido1, empleado.apellido2, oficina.ciudad
FROM cliente
INNER JOIN empleado ON cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
INNER JOIN oficina ON empleado.codigo_oficina = oficina.codigo_oficina;

-- 7.Listado cON el nombre de los empleados junto cON el nombre de sus jefes.
SELECT e1.nombre AS empleado_nombre, e1.apellido1 AS empleado_apellido1, e1.apellido2 AS empleado_apellido2,
       e2.nombre AS jefe_nombre, e2.apellido1 AS jefe_apellido1, e2.apellido2 AS jefe_apellido2
FROM empleado e1
INNER JOIN empleado e2 ON e1.codigo_jefe = e2.codigo_empleado;

-- 8.Listado que muestre el nombre de cada empleado, el nombre de su jefe y el nombre del jefe de su jefe.
SELECT e1.nombre AS empleado_nombre, e1.apellido1 AS empleado_apellido1, e1.apellido2 AS empleado_apellido2,
       e2.nombre AS jefe_nombre, e2.apellido1 AS jefe_apellido1, e2.apellido2 AS jefe_apellido2,
       e3.nombre AS jefe_del_jefe_nombre, e3.apellido1 AS jefe_del_jefe_apellido1, e3.apellido2 AS jefe_del_jefe_apellido2
FROM empleado e1
INNER JOIN empleado e2 ON e1.codigo_jefe = e2.codigo_empleado
LEFT JOIN empleado e3 ON e2.codigo_jefe = e3.codigo_empleado;

-- 9.Nombre de los clientes a los que no se les ha entregado a tiempo un pedido.
SELECT DISTINCT cliente.nombre_cliente
FROM cliente
INNER JOIN pedido ON cliente.codigo_cliente = pedido.codigo_cliente
WHERE pedido.fecha_entrega > pedido.fecha_esperada;

-- 10.Listado de las diferentes gamas de producto que ha comprado cada cliente.
SELECT DISTINCT cliente.nombre_cliente, gama_producto.gama
FROM cliente
INNER JOIN pedido ON cliente.codigo_cliente = pedido.codigo_cliente
INNER JOIN detalle_pedido ON pedido.codigo_pedido = detalle_pedido.codigo_pedido
INNER JOIN producto ON detalle_pedido.codigo_producto = producto.codigo_producto
INNER JOIN gama_producto ON producto.gama = gama_producto.gama;

--Consultas multitabla (Composición externa)
--Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, NATURAL
--LEFT JOIN y NATURAL RIGHT JOIN.

--1. Devuelve un listado que muestre solamente los clientes que no han
--realizado ningún pago.

--2. Devuelve un listado que muestre solamente los clientes que no han
--realizado ningún pedido.

--3. Devuelve un listado que muestre los clientes que no han realizado ningún
--pago y los que no han realizado ningún pedido.

--4. Devuelve un listado que muestre solamente los empleados que no tienen
--una oficina asociada.
--5. Devuelve un listado que muestre solamente los empleados que no tienen un
--cliente asociado.
--6. Devuelve un listado que muestre solamente los empleados que no tienen un
--cliente asociado junto con los datos de la oficina donde trabajan.
--7. Devuelve un listado que muestre los empleados que no tienen una oficina
--asociada y los que no tienen un cliente asociado.
--8. Devuelve un listado de los productos que nunca han aparecido en un
--pedido.

--9. Devuelve un listado de los productos que nunca han aparecido en un
--pedido. El resultado debe mostrar el nombre, la descripción y la imagen del
--producto.
--10. Devuelve las oficinas donde no trabajan ninguno de los empleados que
--hayan sido los representantes de ventas de algún cliente que haya realizado
--la compra de algún producto de la gama Frutales.
--11. Devuelve un listado con los clientes que han realizado algún pedido pero no
--han realizado ningún pago.
--12. Devuelve un listado con los datos de los empleados que no tienen clientes
--asociados y el nombre de su jefe asociado.
--Consultas resumen
--1. ¿Cuántos empleados hay en la compañía?
--2. ¿Cuántos clientes tiene cada país?
--3. ¿Cuál fue el pago medio en 2009?
--4. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma
--descendente por el número de pedidos.
--5. Calcula el precio de venta del producto más caro y más barato en una
--misma consulta.
--6. Calcula el número de clientes que tiene la empresa.
--7. ¿Cuántos clientes existen con domicilio en la ciudad de Madrid?
--8. ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan
--por M?
--9. Devuelve el nombre de los representantes de ventas y el número de clientes
--al que atiende cada uno.
--10. Calcula el número de clientes que no tiene asignado representante de
--ventas.
--11. Calcula la fecha del primer y último pago realizado por cada uno de los
--clientes. El listado deberá mostrar el nombre y los apellidos de cada cliente.

--12. Calcula el número de productos diferentes que hay en cada uno de los
--pedidos.
--13. Calcula la suma de la cantidad total de todos los productos que aparecen en
--cada uno de los pedidos.
--14. Devuelve un listado de los 20 productos más vendidos y el número total de
--unidades que se han vendido de cada uno. El listado deberá estar ordenado
--por el número total de unidades vendidas.
--15. La facturación que ha tenido la empresa en toda la historia, indicando la
--base imponible, el IVA y el total facturado. La base imponible se calcula
--sumando el coste del producto por el número de unidades vendidas de la
--tabla detalle_pedido. El IVA es el 21 % de la base imponible, y el total la
--suma de los dos campos anteriores.
--16. La misma información que en la pregunta anterior, pero agrupada por
--código de producto.
--17. La misma información que en la pregunta anterior, pero agrupada por
--código de producto filtrada por los códigos que empiecen por OR.
--18. Lista las ventas totales de los productos que hayan facturado más de 3000
--euros. Se mostrará el nombre, unidades vendidas, total facturado y total
--facturado con impuestos (21% IVA).
--19. Muestre la suma total de todos los pagos que se realizaron para cada uno
--de los años que aparecen en la tabla pagos.
--Subconsultas
--Con operadores básicos de comparación
--1. Devuelve el nombre del cliente con mayor límite de crédito.
--2. Devuelve el nombre del producto que tenga el precio de venta más caro.
--3. Devuelve el nombre del producto del que se han vendido más unidades.
--(Tenga en cuenta que tendrá que calcular cuál es el número total de
--unidades que se han vendido de cada producto a partir de los datos de la
--tabla detalle_pedido)

--4. Los clientes cuyo límite de crédito sea mayor que los pagos que haya
--realizado. (Sin utilizar INNER JOIN).
--5. Devuelve el producto que más unidades tiene en stock.
--6. Devuelve el producto que menos unidades tiene en stock.
--7. Devuelve el nombre, los apellidos y el email de los empleados que están a
--cargo de Alberto Soria.
--Subconsultas con ALL y ANY
--8. Devuelve el nombre del cliente con mayor límite de crédito.
--9. Devuelve el nombre del producto que tenga el precio de venta más caro.
--10. Devuelve el producto que menos unidades tiene en stock.
--Subconsultas con IN y NOT IN
--11. Devuelve el nombre, apellido1 y cargo de los empleados que no
--representen a ningún cliente.
--12. Devuelve un listado que muestre solamente los clientes que no han
--realizado ningún pago.
--13. Devuelve un listado que muestre solamente los clientes que sí han realizado
--algún pago.
--14. Devuelve un listado de los productos que nunca han aparecido en un
--pedido.
--15. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos
--empleados que no sean representante de ventas de ningún cliente.
--16. Devuelve las oficinas donde no trabajan ninguno de los empleados que
--hayan sido los representantes de ventas de algún cliente que haya realizado
--la compra de algún producto de la gama Frutales.
--17. Devuelve un listado con los clientes que han realizado algún pedido pero no
--han realizado ningún pago.

--Subconsultas con EXISTS y NOT EXISTS
--18. Devuelve un listado que muestre solamente los clientes que no han
--realizado ningún pago.
--19. Devuelve un listado que muestre solamente los clientes que sí han realizado
--algún pago.
--20. Devuelve un listado de los productos que nunca han aparecido en un
--pedido.
--21. Devuelve un listado de los productos que han aparecido en un pedido
--alguna vez.
--Subconsultas correlacionadas
--Consultas variadas
--1. Devuelve el listado de clientes indicando el nombre del cliente y cuántos
--pedidos ha realizado. Tenga en cuenta que pueden existir clientes que no
--han realizado ningún pedido.
--2. Devuelve un listado con los nombres de los clientes y el total pagado por
--cada uno de ellos. Tenga en cuenta que pueden existir clientes que no han
--realizado ningún pago.
--3. Devuelve el nombre de los clientes que hayan hecho pedidos en 2008
--ordenados alfabéticamente de menor a mayor.
--4. Devuelve el nombre del cliente, el nombre y primer apellido de su
--representante de ventas y el número de teléfono de la oficina del
--representante de ventas, de aquellos clientes que no hayan realizado ningún
--pago.
--5. Devuelve el listado de clientes donde aparezca el nombre del cliente, el
--nombre y primer apellido de su representante de ventas y la ciudad donde
--está su oficina.
--6. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos
--empleados que no sean representante de ventas de ningún cliente.

--7. Devuelve un listado indicando todas las ciudades donde hay oficinas y el
--número de empleados que tiene.