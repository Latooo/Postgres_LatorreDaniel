# Jardineria DATABASE
Consultas sobre una tabla

1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.

SELECT codigo_oficina, ciudad 
FROM oficina;

![image](https://github.com/user-attachments/assets/71bb1e9d-d580-4832-bcca-a1424295b033)

2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.

SELECT ciudad, telefONo
FROM oficina
WHERE pais = 'España';

![image](https://github.com/user-attachments/assets/6225cebc-a3b1-4abc-ab70-3dae83376312)

4. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo
jefe tiene un código de jefe igual a 7

SELECT nombre, apellido1,apellido2,email
FROM empleado
WHERE codigo_jefe=7;

![image](https://github.com/user-attachments/assets/b2b50f03-f4df-4974-8d50-65acc3fc06ff)

5. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la
empresa.

SELECT puesto,nombre,apellido1,apellido2,email
FROM empleado
WHERE codigo_jefe is null;

![image](https://github.com/user-attachments/assets/8d171490-8fc2-4de6-b5a5-dc10dafd5221)

7. Devuelve un listado con el nombre, apellidos y puesto de aquellos
empleados que no sean representantes de ventas.

SELECT nombre,apellido1,apellido2,puesto
FROM empleado
WHERE puesto <> 'Representante de Ventas';

![image](https://github.com/user-attachments/assets/e707a12c-8ee1-4be6-b62c-bf2b06844f2d)

8. Devuelve un listado con el código de cliente de aquellos clientes que
realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar
aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:
• Utilizando la función YEAR de MySQL pero que sirva en postgresql.
• Utilizando la función DATE_FORMAT de MySQL pero que sirva en postgresql.
• Sin utilizar ninguna de las funciones anteriores.

SELECT DISTINCT codigo_cliente
FROM pago
WHERE EXTRACT(YEAR FROM fecha_pago) = 2008;

![image](https://github.com/user-attachments/assets/8ed1cdd2-0943-4632-bd95-c29ccda40661)

9. Devuelve un listado con el código de pedido, código de cliente, fecha
esperada y fecha de entrega de los pedidos que no han sido entregados a
tiempo.

SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega 
FROM pedido 
WHERE fecha_entrega > fecha_esperada;

![image](https://github.com/user-attachments/assets/3f24c863-d5a5-4ef9-88d8-fae4c79e605f)

10. Devuelve un listado con el código de pedido, código de cliente, fecha
esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al
menos dos días antes de la fecha esperada.
• Utilizando la función ADDDATE de MySQL pero que sirva en postgresql.
• Utilizando la función DATEDIFF de MySQL pero que sirva en postgresql.
• ¿Sería posible resolver esta consulta utilizando el operador de suma + o
resta -?

SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE fecha_entrega <= (fecha_esperada - INTERVAL '2 days');

![image](https://github.com/user-attachments/assets/22451c7a-1864-4599-85b8-a346f8054a51)

11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.

SELECT * 
FROM pedido
WHERE EXTRACT (YEAR FROM fecha_entrega) = 2009;

![image](https://github.com/user-attachments/assets/a70b821f-5b8c-4f13-b339-a2aa35dc09ca)

12. Devuelve un listado de todos los pedidos que han sido entregados en el
mes de enero de cualquier año.
SELECT *
FROM pedido
WHERE EXTRACT(MONTH FROM fecha_entrega) = 1;

![image](https://github.com/user-attachments/assets/a8619817-6376-4f80-abd6-be3fff1a8205)

13. Devuelve un listado con todos los pagos que se realizaron en el
año 2008 mediante Paypal. Ordene el resultado de mayor a menor.*/

SELECT * 
FROM pago 
WHERE EXTRACT(YEAR FROM fecha_pago) = 2008 
  AND forma_pago = 'PayPal' 
ORDER BY total DESC;

![image](https://github.com/user-attachments/assets/701f2acc-ef9b-48b7-b8ae-b38449577d6b)

14. Devuelve un listado con todas las formas de pago que aparecen en la
tabla pago. Tenga en cuenta que no deben aparecer formas de pago
repetidas.

SELECT DISTINCT forma_pago
FROM pago;

![image](https://github.com/user-attachments/assets/394eb309-944a-4400-98c4-ed49bd5c574e)

15. Devuelve un listado con todos los productos que pertenecen a la
gama Ornamentales y que tienen más de 100 unidades en stock. El listado
deberá estar ordenado por su precio de venta, mostrando en primer lugar
los de mayor precio.

SELECT *
FROM producto
WHERE gama ='Ornamentales'
AND cantidad_en_stock = 100
ORDER BY precio_venta DESC;

![image](https://github.com/user-attachments/assets/6687ef02-d710-4c28-a5f3-fa187a9b1d76)

16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y
cuyo representante de ventas tenga el código de empleado 11 o 30.

SELECT *
FROM cliente
WHERE ciudad = 'Madrid'
AND codigo_empleado_rep_ventas IN (11, 30);

![image](https://github.com/user-attachments/assets/6c59107b-6245-4ca7-a5c2-37ff0c77c870)

# Consultas multitabla (Composición interna)

1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su
representante de ventas.

SELECT cliente.nombre_cliente, empleado.nombre, empleado.apellido1, empleado.apellido2 
FROM cliente
INNER JOIN empleado ON cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado;

![image](https://github.com/user-attachments/assets/0c4bcb9c-1c33-44f6-8a7c-85768565e702)

2. Muestra el nombre de los clientes que hayan realizado pagos junto con el
nombre de sus representantes de ventas.

SELECT cliente.nombre_cliente, empleado.nombre, empleado.apellido1, empleado.apellido2 
FROM cliente
INNER JOIN pago ON cliente.codigo_cliente = pago.codigo_cliente
INNER JOIN empleado ON cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado;

![image](https://github.com/user-attachments/assets/adf197e1-aa2a-40ad-8069-946860312ec0)

3. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus
representantes junto con la ciudad de la oficina a la que pertenece el
representante.

SELECT cliente.nombre_cliente, empleado.nombre, empleado.apellido1, empleado.apellido2, oficina.ciudad
FROM cliente
INNER JOIN pago ON cliente.codigo_cliente = pago.codigo_cliente
INNER JOIN empleado ON cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
INNER JOIN oficina ON empleado.codigo_oficina = oficina.codigo_oficina;

![image](https://github.com/user-attachments/assets/04010b81-3818-4e99-a202-3af69448760c)

4. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre
de sus representantes junto con la ciudad de la oficina a la que pertenece el
representante.

SELECT cliente.nombre_cliente, empleado.nombre, empleado.apellido1, empleado.apellido2, oficina.ciudad
FROM cliente
LEFT JOIN pago ON cliente.codigo_cliente = pago.codigo_cliente
INNER JOIN empleado ON cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
INNER JOIN oficina ON empleado.codigo_oficina = oficina.codigo_oficina
WHERE pago.codigo_cliente IS NULL;

![image](https://github.com/user-attachments/assets/63da9aeb-193d-4695-9a08-d62af176debb)

5. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.*/

SELECT DISTINCT oficina.linea_direcciON1, oficina.linea_direcciON2
FROM cliente
INNER JOIN empleado ON cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
INNER JOIN oficina ON empleado.codigo_oficina = oficina.codigo_oficina
WHERE cliente.ciudad = 'Fuenlabrada';

![image](https://github.com/user-attachments/assets/3c6d4b5e-812a-4a10-aa7f-fde9e2acce40)

6. Devuelve el nombre de los clientes y el nombre de sus representantes junto
con la ciudad de la oficina a la que pertenece el representante.

SELECT cliente.nombre_cliente, empleado.nombre, empleado.apellido1, empleado.apellido2, oficina.ciudad
FROM cliente
INNER JOIN empleado ON cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
INNER JOIN oficina ON empleado.codigo_oficina = oficina.codigo_oficina;

![image](https://github.com/user-attachments/assets/6d12ec0c-707b-4231-a68d-785e44a785f3)

7. Devuelve un listado con el nombre de los empleados junto con el nombre
de sus jefes.

SELECT e1.nombre AS empleado_nombre, e1.apellido1 AS empleado_apellido1, e1.apellido2 AS empleado_apellido2,
       e2.nombre AS jefe_nombre, e2.apellido1 AS jefe_apellido1, e2.apellido2 AS jefe_apellido2
FROM empleado e1
INNER JOIN empleado e2 ON e1.codigo_jefe = e2.codigo_empleado;

![image](https://github.com/user-attachments/assets/0fb6c0f4-1c8b-44d0-8c77-22d234f7a8c5)

8. Devuelve un listado que muestre el nombre de cada empleados, el nombre
de su jefe y el nombre del jefe de sus jefe.

SELECT e1.nombre AS empleado_nombre, e1.apellido1 AS empleado_apellido1, e1.apellido2 AS empleado_apellido2,
       e2.nombre AS jefe_nombre, e2.apellido1 AS jefe_apellido1, e2.apellido2 AS jefe_apellido2,
       e3.nombre AS jefe_del_jefe_nombre, e3.apellido1 AS jefe_del_jefe_apellido1, e3.apellido2 AS jefe_del_jefe_apellido2
FROM empleado e1
INNER JOIN empleado e2 ON e1.codigo_jefe = e2.codigo_empleado
LEFT JOIN empleado e3 ON e2.codigo_jefe = e3.codigo_empleado;

![image](https://github.com/user-attachments/assets/70fd45e2-41d5-43f9-a628-5d302aeac1a7)

9. Devuelve el nombre de los clientes a los que no se les ha entregado a
tiempo un pedido.

SELECT DISTINCT cliente.nombre_cliente
FROM cliente
INNER JOIN pedido ON cliente.codigo_cliente = pedido.codigo_cliente
WHERE pedido.fecha_entrega > pedido.fecha_esperada;

![image](https://github.com/user-attachments/assets/cbfdfd8d-0248-4fc1-a686-424c43fcc052)

10. Devuelve un listado de las diferentes gamas de producto que ha comprado
cada cliente.

SELECT DISTINCT cliente.nombre_cliente, gama_producto.gama
FROM cliente
INNER JOIN pedido ON cliente.codigo_cliente = pedido.codigo_cliente
INNER JOIN detalle_pedido ON pedido.codigo_pedido = detalle_pedido.codigo_pedido
INNER JOIN producto ON detalle_pedido.codigo_producto = producto.codigo_producto
INNER JOIN gama_producto ON producto.gama = gama_producto.gama;

![image](https://github.com/user-attachments/assets/3ab84ec9-fb9a-481c-a8a2-bafac46de7a5)

# Consultas multitabla (Composición externa)
Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, NATURAL
LEFT JOIN y NATURAL RIGHT JOIN.

1. Devuelve un listado que muestre solamente los clientes que no han
realizado ningún pago.

SELECT c.*
FROM cliente c
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
WHERE p.codigo_cliente IS NULL;

![image](https://github.com/user-attachments/assets/dd7444fd-c44e-423e-8a04-7b7b23c42349)

2. Devuelve un listado que muestre solamente los clientes que no han
realizado ningún pedido.

SELECT c.*
FROM cliente c
LEFT JOIN pedido pd ON c.codigo_cliente = pd.codigo_cliente
WHERE pd.codigo_pedido IS NULL;

![image](https://github.com/user-attachments/assets/27f42d5f-606f-43fe-986f-412bded13fa8)

3. Devuelve un listado que muestre los clientes que no han realizado ningún
pago y los que no han realizado ningún pedido.

SELECT c.*
FROM cliente c
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
LEFT JOIN pedido pd ON c.codigo_cliente = pd.codigo_cliente
WHERE p.codigo_cliente IS NULL AND pd.codigo_pedido IS NULL;

![image](https://github.com/user-attachments/assets/1a81180e-0f94-46fa-b41c-f1a4de7fe761)

4. Devuelve un listado que muestre solamente los empleados que no tienen
una oficina asociada.

SELECT e.*
FROM empleado e
LEFT JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE o.codigo_oficina IS NULL;

![image](https://github.com/user-attachments/assets/d558c8f9-3b54-45bc-a2b7-0853eb64fc14)

5. Devuelve un listado que muestre solamente los empleados que no tienen un
cliente asociado.

SELECT e.*
FROM empleado e
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE c.codigo_cliente IS NULL;

![image](https://github.com/user-attachments/assets/ed57418b-d727-4a0b-ad33-3463530c5f72)

6. Devuelve un listado que muestre solamente los empleados que no tienen un
cliente asociado junto con los datos de la oficina donde trabajan.

SELECT e.*, o.*
FROM empleado e
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
LEFT JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE c.codigo_cliente IS NULL;

![image](https://github.com/user-attachments/assets/2bdd314d-31b4-427b-8dda-ef8c97e1c6fe)

7. Devuelve un listado que muestre los empleados que no tienen una oficina
asociada y los que no tienen un cliente asociado.

SELECT e.*
FROM empleado e
LEFT JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE o.codigo_oficina IS NULL OR c.codigo_cliente IS NULL;

![image](https://github.com/user-attachments/assets/a174fd3e-ee50-426e-9da8-11007c1776b4)

8. Devuelve un listado de los productos que nunca han aparecido en un
pedido.

SELECT p.*
FROM producto p
LEFT JOIN detalle_pedido dp ON p.codigo_producto = dp.codigo_producto
WHERE dp.codigo_producto IS NULL; 

![image](https://github.com/user-attachments/assets/825ded08-4989-40f0-815d-75664d2cb3c5)

9. Devuelve un listado de los productos que nunca han aparecido en un
pedido. El resultado debe mostrar el nombre, la descripción y la imagen del
producto.

SELECT 
    p.nombre, 
    p.descripcion, 
    g.imagen
FROM producto p
LEFT JOIN detalle_pedido dp ON p.codigo_producto = dp.codigo_producto
LEFT JOIN gama_producto g ON p.gama = g.gama
WHERE dp.codigo_producto IS NULL;

![image](https://github.com/user-attachments/assets/1ff6c077-cfbd-4f9b-a704-98539deae44b)

10. Devuelve las oficinas donde no trabajan ninguno de los empleados que
hayan sido los representantes de ventas de algún cliente que haya realizado
la compra de algún producto de la gama Frutales.

SELECT o.*
FROM oficina o
LEFT JOIN empleado e ON o.codigo_oficina = e.codigo_oficina
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
LEFT JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
LEFT JOIN detalle_pedido dp ON p.codigo_pedido = dp.codigo_pedido
LEFT JOIN producto pr ON dp.codigo_producto = pr.codigo_producto
LEFT JOIN gama_producto g ON pr.gama = g.gama
WHERE g.gama = 'Frutales'
  AND e.codigo_empleado IS null;

  ![image](https://github.com/user-attachments/assets/fcc80e78-0976-48c3-a3bf-bc5e32fb7c17)

11. Devuelve un listado con los clientes que han realizado algún pedido pero no
han realizado ningún pago.

SELECT c.*
FROM cliente c
INNER JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
LEFT JOIN pago pa ON c.codigo_cliente = pa.codigo_cliente
WHERE pa.codigo_cliente IS NULL;

![image](https://github.com/user-attachments/assets/a3d7b928-1072-408a-8018-3afaf7af85dd)

12. Devuelve un listado con los datos de los empleados que no tienen clientes
asociados y el nombre de su jefe asociado.

SELECT e.*, j.nombre AS nombre_jefe, j.apellido1 AS apellido1_jefe, j.apellido2 AS apellido2_jefe
FROM empleado e
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
LEFT JOIN empleado j ON e.codigo_jefe = j.codigo_empleado
WHERE c.codigo_cliente IS NULL;

![image](https://github.com/user-attachments/assets/63ea8bdd-ee33-4670-a88e-cde3f07166c6)

# Consultas resumen
1. ¿Cuántos empleados hay en la compañía?

SELECT COUNT(*) AS total_empleados
FROM empleado;

![image](https://github.com/user-attachments/assets/e3ea4dd8-15a9-47bf-a4a6-7d5620a8e78e)

2. ¿Cuántos clientes tiene cada país?

SELECT pais, COUNT(*) AS total_clientes
FROM cliente
GROUP BY pais;

![image](https://github.com/user-attachments/assets/d574928a-867b-4041-8543-be39333f6a65)

3. ¿Cuál fue el pago medio en 2009?

SELECT AVG(total) AS pago_medio
FROM pago
WHERE EXTRACT(YEAR FROM fecha_pago) = 2009;

![image](https://github.com/user-attachments/assets/5fd2afce-6998-42d9-abcb-5a93c04338ab)

4. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma
descendente por el número de pedidos.

SELECT estado, COUNT(*) AS total_pedidos
FROM pedido
GROUP BY estado
ORDER BY total_pedidos DESC;

![image](https://github.com/user-attachments/assets/46c161c6-1358-4b74-b638-60095de09b2b)

5. Calcula el precio de venta del producto más caro y más barato en una
misma consulta.

SELECT MAX(precio_venta) AS precio_maximo, MIN(precio_venta) AS precio_minimo
FROM producto;
![image](https://github.com/user-attachments/assets/ff7364eb-8d50-4dc4-ac41-8564ece3ac18)

6. Calcula el número de clientes que tiene la empresa.

SELECT COUNT(*) AS total_clientes
FROM cliente;

![image](https://github.com/user-attachments/assets/0d376b13-66ba-496a-8e38-8584f0699649)

7. ¿Cuántos clientes existen con domicilio en la ciudad de Madrid?

SELECT COUNT(*) AS total_clientes
FROM cliente
WHERE ciudad = 'Madrid';

![image](https://github.com/user-attachments/assets/ad20aa84-18d5-4030-8c06-deaa06e584f4)

8. ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan
por M?

SELECT ciudad, COUNT(*) AS total_clientes
FROM cliente
WHERE ciudad LIKE 'M%'
GROUP BY ciudad;

![image](https://github.com/user-attachments/assets/c239a26f-40cb-4bf3-abbc-3a83f2a84f1b)

9. Devuelve el nombre de los representantes de ventas y el número de clientes
al que atiende cada uno.

SELECT e.nombre, e.apellido1, COUNT(c.codigo_cliente) AS total_clientes
FROM empleado e
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
GROUP BY e.codigo_empleado, e.nombre, e.apellido1;

![image](https://github.com/user-attachments/assets/4b096d83-a6bf-4d28-b7a7-f6dc7c0c8526)

10. Calcula el número de clientes que no tiene asignado representante de
ventas.

SELECT COUNT(*) AS total_clientes_sin_representante
FROM cliente
WHERE codigo_empleado_rep_ventas IS NULL;

![image](https://github.com/user-attachments/assets/cd9d021f-5751-49b1-ac4b-ab32428e892d)

11. Calcula la fecha del primer y último pago realizado por cada uno de los
clientes. El listado deberá mostrar el nombre y los apellidos de cada cliente.

SELECT d.codigo_pedido, COUNT(DISTINCT d.codigo_producto) AS num_productos
FROM detalle_pedido d
GROUP BY d.codigo_pedido;

![image](https://github.com/user-attachments/assets/fe2e034f-fe16-443f-9c41-b2b3c2e7a2f5)

12. Calcula el número de productos diferentes que hay en cada uno de los
pedidos.

SELECT d.codigo_pedido, COUNT(DISTINCT d.codigo_producto) AS num_productos
FROM detalle_pedido d
GROUP BY d.codigo_pedido;

![image](https://github.com/user-attachments/assets/89174897-0e39-455a-aa80-88ee4c48c8b8)

13. Calcula la suma de la cantidad total de todos los productos que aparecen en
cada uno de los pedidos.

SELECT d.codigo_pedido, SUM(d.cantidad) AS cantidad_total
FROM detalle_pedido d
GROUP BY d.codigo_pedido;

![image](https://github.com/user-attachments/assets/1dae4f2b-3dd1-4234-9d1e-895a208e9ebb)

14. Devuelve un listado de los 20 productos más vendidos y el número total de
unidades que se han vendido de cada uno. El listado deberá estar ordenado
por el número total de unidades vendidas.

SELECT d.codigo_producto, p.nombre, SUM(d.cantidad) AS unidades_vendidas
FROM detalle_pedido d
INNER JOIN producto p ON d.codigo_producto = p.codigo_producto
GROUP BY d.codigo_producto, p.nombre
ORDER BY unidades_vendidas DESC
LIMIT 20;

![image](https://github.com/user-attachments/assets/57a7438c-9f9a-4731-ac13-cb373c99ec5e)

15. La facturación que ha tenido la empresa en toda la historia, indicando la
base imponible, el IVA y el total facturado. La base imponible se calcula
sumando el coste del producto por el número de unidades vendidas de la
tabla detalle_pedido. El IVA es el 21 % de la base imponible, y el total la
suma de los dos campos anteriores.

SELECT
    SUM(dp.cantidad * dp.precio_unidad) AS base_imponible,
    SUM(dp.cantidad * dp.precio_unidad * 0.21) AS IVA,
    SUM(dp.cantidad * dp.precio_unidad * 1.21) AS total_facturado
FROM detalle_pedido dp;

![image](https://github.com/user-attachments/assets/1c826851-a27a-4357-8ff1-26e0922522db)

16. La misma información que en la pregunta anterior, pero agrupada por
código de producto.

SELECT
    dp.codigo_producto,
    SUM(dp.cantidad * dp.precio_unidad) AS base_imponible,
    SUM(dp.cantidad * dp.precio_unidad * 0.21) AS IVA,
    SUM(dp.cantidad * dp.precio_unidad * 1.21) AS total_facturado
FROM detalle_pedido dp

![image](https://github.com/user-attachments/assets/816edeb4-908f-44b2-bce4-888cb3034de7)

17. La misma información que en la pregunta anterior, pero agrupada por
código de producto filtrada por los códigos que empiecen por OR.

SELECT
    dp.codigo_producto,
    SUM(dp.cantidad * dp.precio_unidad) AS base_imponible,
    SUM(dp.cantidad * dp.precio_unidad * 0.21) AS IVA,
    SUM(dp.cantidad * dp.precio_unidad * 1.21) AS total_facturado
FROM detalle_pedido dp
INNER JOIN producto p ON dp.codigo_producto = p.codigo_producto
WHERE p.codigo_producto LIKE 'OR%'
GROUP BY dp.codigo_producto;

![image](https://github.com/user-attachments/assets/15df5023-554e-488a-aa45-3f2259b493e7)

18. Lista las ventas totales de los productos que hayan facturado más de 3000
euros. Se mostrará el nombre, unidades vendidas, total facturado y total
facturado con impuestos (21% IVA).

SELECT
    p.nombre,
    SUM(dp.cantidad) AS unidades_vendidas,
    SUM(dp.cantidad * dp.precio_unidad) AS total_facturado,
    SUM(dp.cantidad * dp.precio_unidad * 1.21) AS total_facturado_con_IVA
FROM detalle_pedido dp
INNER JOIN producto p ON dp.codigo_producto = p.codigo_producto
GROUP BY p.nombre
HAVING SUM(dp.cantidad * dp.precio_unidad) > 3000;

![image](https://github.com/user-attachments/assets/ffca043a-2f10-44d8-bb47-a3e6e028110a)

19. Muestre la suma total de todos los pagos que se realizaron para cada uno
de los años que aparecen en la tabla pagos.

SELECT EXTRACT(YEAR FROM fecha_pago) AS año, SUM(total) AS suma_pagos
FROM pago
GROUP BY EXTRACT(YEAR FROM fecha_pago);

![image](https://github.com/user-attachments/assets/3aebf9c1-8723-4fb3-9cb3-f2aa10d38e85)

Subconsultas
Con operadores básicos de comparación
1. Devuelve el nombre del cliente con mayor límite de crédito.

SELECT nombre_cliente
FROM cliente
WHERE limite_credito = (SELECT MAX(limite_credito) FROM cliente);

![image](https://github.com/user-attachments/assets/dcd9bf67-6521-48ff-83fa-6603cfa99b9a)


2. Devuelve el nombre del producto que tenga el precio de venta más caro.

SELECT nombre
FROM producto
WHERE precio_venta = (SELECT MAX(precio_venta) FROM producto);

![image](https://github.com/user-attachments/assets/5b96c406-6c7f-422a-bdbf-568622a3370c)

3. Devuelve el nombre del producto del que se han vendido más unidades.
(Tenga en cuenta que tendrá que calcular cuál es el número total de
unidades que se han vendido de cada producto a partir de los datos de la
tabla detalle_pedido)

SELECT p.nombre
FROM producto p
JOIN detalle_pedido dp ON p.codigo_producto = dp.codigo_producto
GROUP BY p.nombre
ORDER BY SUM(dp.cantidad) DESC
LIMIT 1;

![image](https://github.com/user-attachments/assets/7f1c28c6-5677-45dd-a47c-228e3a5842e3)

4. Los clientes cuyo límite de crédito sea mayor que los pagos que haya
realizado. (Sin utilizar INNER JOIN).

SELECT nombre_cliente
FROM cliente
WHERE limite_credito > ALL (
    SELECT total
    FROM pago
    WHERE cliente.codigo_cliente = pago.codigo_cliente
);

![image](https://github.com/user-attachments/assets/938bb866-1184-4612-a651-d1b404422ad7)


5. Devuelve el producto que más unidades tiene en stock.

SELECT nombre
FROM producto
WHERE cantidad_en_stock = (SELECT MAX(cantidad_en_stock) FROM producto);

![image](https://github.com/user-attachments/assets/087204a2-6c87-457e-b59f-b972c4786877)


6. Devuelve el producto que menos unidades tiene en stock.

SELECT nombre
FROM producto
WHERE cantidad_en_stock = (SELECT MIN(cantidad_en_stock) FROM producto);

![image](https://github.com/user-attachments/assets/5aaafbac-6562-48d8-8855-c6ddcc2db02a)


7. Devuelve el nombre, los apellidos y el email de los empleados que están a
cargo de Alberto Soria.

SELECT e.nombre, e.apellido1, e.email
FROM empleado e
WHERE e.codigo_jefe = (
    SELECT codigo_empleado
    FROM empleado
    WHERE nombre = 'Alberto' AND apellido1 = 'Soria'
);

![image](https://github.com/user-attachments/assets/f2f018b5-0ec5-4615-bbff-deff43d6bddf)


Subconsultas con ALL y any

8. Devuelve el nombre del cliente con mayor límite de crédito.

SELECT nombre_cliente
FROM cliente
WHERE limite_credito = ANY (SELECT MAX(limite_credito) FROM cliente);

![image](https://github.com/user-attachments/assets/c18ffd73-2eaa-4141-af9c-c80491455009)


9. Devuelve el nombre del producto que tenga el precio de venta más caro.

SELECT nombre
FROM producto
WHERE precio_venta = ANY (SELECT MAX(precio_venta) FROM producto);

![image](https://github.com/user-attachments/assets/16bbb49f-00b9-47bd-9344-36fe0dba0b92)


10. Devuelve el producto que menos unidades tiene en stock.

SELECT nombre
FROM producto
WHERE cantidad_en_stock = ANY (SELECT MIN(cantidad_en_stock) FROM producto);

![image](https://github.com/user-attachments/assets/bcc3d53c-19a9-4bbf-842f-4d58d72cd09e)


Subconsultas con IN y NOT in

11. Devuelve el nombre, apellido1 y cargo de los empleados que no
representen a ningún cliente.

SELECT nombre, apellido1, puesto
FROM empleado
WHERE codigo_empleado NOT IN (
    SELECT DISTINCT codigo_empleado_rep_ventas
    FROM cliente
    WHERE codigo_empleado_rep_ventas IS NOT NULL
);
![image](https://github.com/user-attachments/assets/c33f0f71-f215-4601-942f-fd1fbc9bcd34)


12. Devuelve un listado que muestre solamente los clientes que no han
realizado ningún pago.

SELECT nombre_cliente
FROM cliente
WHERE codigo_cliente NOT IN (
    SELECT DISTINCT codigo_cliente
    FROM pago
);

![image](https://github.com/user-attachments/assets/91d2a6fa-ef03-43cc-ae32-1b352270271b)


13. Devuelve un listado que muestre solamente los clientes que sí han realizado
algún pago.

SELECT nombre_cliente
FROM cliente
WHERE codigo_cliente IN (
    SELECT DISTINCT codigo_cliente
    FROM pago
);

![image](https://github.com/user-attachments/assets/70f18e98-9b26-4eae-8835-b36a39aeffd7)


14. Devuelve un listado de los productos que nunca han aparecido en un
pedido.

SELECT nombre
FROM producto
WHERE codigo_producto NOT IN (
    SELECT DISTINCT codigo_producto
    FROM detalle_pedido
);

![image](https://github.com/user-attachments/assets/30e3f26f-7094-4d95-9a26-0212fe0b5e76)


15. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos
empleados que no sean representante de ventas de ningún cliente.

SELECT e.nombre, e.apellido1, e.puesto, o.telefono
FROM empleado e
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE e.codigo_empleado NOT IN (
    SELECT DISTINCT codigo_empleado_rep_ventas
    FROM cliente
    WHERE codigo_empleado_rep_ventas IS NOT NULL
);

![image](https://github.com/user-attachments/assets/ccd93fd8-d3de-4e06-bfc0-64251a44df86)


16. Devuelve las oficinas donde no trabajan ninguno de los empleados que
hayan sido los representantes de ventas de algún cliente que haya realizado
la compra de algún producto de la gama Frutales.

SELECT DISTINCT o.ciudad
FROM oficina o
WHERE o.codigo_oficina NOT IN (
    SELECT e.codigo_oficina
    FROM empleado e
    WHERE e.codigo_empleado IN (
        SELECT c.codigo_empleado_rep_ventas
        FROM cliente c
        JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
        JOIN detalle_pedido dp ON p.codigo_pedido = dp.codigo_pedido
        JOIN producto prod ON dp.codigo_producto = prod.codigo_producto
        WHERE prod.gama = 'Frutales'
    )
);

![image](https://github.com/user-attachments/assets/4048547c-d902-4eeb-b0d8-b93be8862bfd)


17. Devuelve un listado con los clientes que han realizado algún pedido pero no
han realizado ningún pago.

SELECT DISTINCT c.nombre_cliente
FROM cliente c
WHERE c.codigo_cliente IN (
    SELECT DISTINCT p.codigo_cliente
    FROM pedido p
)
AND c.codigo_cliente NOT IN (
    SELECT DISTINCT codigo_cliente
    FROM pago
);

![image](https://github.com/user-attachments/assets/985863f4-c5a5-4fd3-9419-6ecacde5f506)


Subconsultas con EXISTS y NOT exists
18. Devuelve un listado que muestre solamente los clientes que no han
realizado ningún pago.

SELECT nombre_cliente
FROM cliente c
WHERE NOT EXISTS (
    SELECT 1
    FROM pago p
    WHERE p.codigo_cliente = c.codigo_cliente
);

![image](https://github.com/user-attachments/assets/0cbec486-f805-4c49-95b1-71781c9eda51)


19. Devuelve un listado que muestre solamente los clientes que sí han realizado
algún pago.

SELECT nombre_cliente
FROM cliente c
WHERE EXISTS (
    SELECT 1
    FROM pago p
    WHERE p.codigo_cliente = c.codigo_cliente
);

![image](https://github.com/user-attachments/assets/86f5f8b8-32a9-4623-aa49-efb8feb33b13)


20. Devuelve un listado de los productos que nunca han aparecido en un
pedido.

SELECT nombre
FROM producto p
WHERE NOT EXISTS (
    SELECT 1
    FROM detalle_pedido dp
    WHERE dp.codigo_producto = p.codigo_producto
);

![image](https://github.com/user-attachments/assets/cae9294b-1675-4727-b0e7-2e5d6fa805ea)


21. Devuelve un listado de los productos que han aparecido en un pedido
alguna vez.

SELECT DISTINCT p.nombre
FROM producto p
WHERE EXISTS (
    SELECT 1
    FROM detalle_pedido dp
    WHERE dp.codigo_producto = p.codigo_producto
);

![image](https://github.com/user-attachments/assets/d8fbe6be-1d59-455c-b6b5-9eacf4160d88)


Subconsultas correlacionadas
Consultas variadas

1. Devuelve el listado de clientes indicando el nombre del cliente y cuántos
pedidos ha realizado. Tenga en cuenta que pueden existir clientes que no
han realizado ningún pedido.

SELECT c.nombre_cliente,
       (SELECT COUNT(*)
        FROM pedido p
        WHERE p.codigo_cliente = c.codigo_cliente) AS total_pedidos
FROM cliente c;

![image](https://github.com/user-attachments/assets/d8f43395-700d-4bb6-aded-c20fd5dd11be)


2. Devuelve un listado con los nombres de los clientes y el total pagado por
cada uno de ellos. Tenga en cuenta que pueden existir clientes que no han
realizado ningún pago.

SELECT c.nombre_cliente,
       COALESCE((
           SELECT SUM(p.total)
           FROM pago p
           WHERE p.codigo_cliente = c.codigo_cliente
       ), 0) AS total_pagado
FROM cliente c;
![image](https://github.com/user-attachments/assets/bb65d995-80f0-4178-b50d-9766e7789e19)


3. Devuelve el nombre de los clientes que hayan hecho pedidos en 2008
ordenados alfabéticamente de menor a mayor.

SELECT DISTINCT c.nombre_cliente
FROM cliente c
JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
WHERE EXTRACT(YEAR FROM p.fecha_pedido) = 2008
ORDER BY c.nombre_cliente;

![image](https://github.com/user-attachments/assets/315f8ac0-46d6-4283-926d-d85d5737beed)


4. Devuelve el nombre del cliente, el nombre y primer apellido de su
representante de ventas y el número de teléfono de la oficina del
representante de ventas, de aquellos clientes que no hayan realizado ningún
pago.

SELECT c.nombre_cliente,
       e.nombre,
       e.apellido1,
       o.telefono
FROM cliente c
JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE c.codigo_cliente NOT IN (
    SELECT DISTINCT codigo_cliente
    FROM pago
);

![image](https://github.com/user-attachments/assets/dcb471b9-f445-4c96-afab-bf4397f14bb1)


5. Devuelve el listado de clientes donde aparezca el nombre del cliente, el
nombre y primer apellido de su representante de ventas y la ciudad donde
está su oficina.

SELECT c.nombre_cliente,
       e.nombre,
       e.apellido1,
       o.ciudad
FROM cliente c
JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina;

![image](https://github.com/user-attachments/assets/0cb3a000-de86-450e-8598-48295f8382c1)


6. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos
empleados que no sean representante de ventas de ningún cliente.

SELECT e.nombre, e.apellido1, e.puesto, o.telefono
FROM empleado e
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE e.codigo_empleado NOT IN (
    SELECT DISTINCT codigo_empleado_rep_ventas
    FROM cliente
    WHERE codigo_empleado_rep_ventas IS NOT NULL
);

![image](https://github.com/user-attachments/assets/c3535624-975d-4d7f-9128-ea001e0eb1a5)


7. Devuelve un listado indicando todas las ciudades donde hay oficinas y el
número de empleados que tiene.

SELECT o.ciudad, COUNT(e.codigo_empleado) AS total_empleados
FROM oficina o
LEFT JOIN empleado e ON o.codigo_oficina = e.codigo_oficina
GROUP BY o.ciudad;

![image](https://github.com/user-attachments/assets/b8da0d8e-803c-4c4a-91c7-f75f5617a2b5)


## Colegio DATABASE

 1.Devuelve un listado con el primer apellido, segundo apellido y el nombre de
 todos los alumnos. El listado deberá estar ordenado alfabéticamente de
 menor a mayor por el primer apellido, segundo apellido y nombre.

SELECT apellido1, apellido2, nombre
FROM alumno
ORDER BY apellido1, apellido2, nombre;

![image](https://github.com/user-attachments/assets/b3a38e6e-7619-44f6-893b-b52a42a541e2)


 2.Averigua el nombre y los dos apellidos de los alumnos que no han dado de
 alta su número de teléfono en la base de datos.

SELECT nombre, apellido1, apellido2
FROM alumno
WHERE telefono IS NULL;

![image](https://github.com/user-attachments/assets/5e6c4920-e62c-4a58-ac7f-a3aca17013d4)

 3.Devuelve el listado de los alumnos que nacieron en 1999.

SELECT nombre, apellido1, apellido2
FROM alumno
WHERE EXTRACT(YEAR FROM fecha_nacimiento) = 1999;

![image](https://github.com/user-attachments/assets/8b7ed6f4-2f16-4df4-89e2-85296f7018bb)


 4.Devuelve el listado de profesores que no han dado de alta su número de
 teléfono en la base de datos y además su nif termina en K.

SELECT nombre, apellido1, apellido2
FROM profesor
WHERE telefono IS NULL AND nif LIKE '%K';

![image](https://github.com/user-attachments/assets/11bb882d-9bfb-4a6a-b2cf-f473955a2da2)


 5.Devuelve el listado de las asignaturas que se imparten en el primer
 cuatrimestre, en el tercer curso del grado que tiene el identificador 7.

SELECT nombre
FROM asignatura
WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7;

![image](https://github.com/user-attachments/assets/f8507574-e3a3-408c-bee7-1aeb26e25af6)


 1.Devuelve un listado con los datos de todas las alumnas que se han
 matriculado alguna vez en el Grado en Ingeniería Informática (Plan 2015).

SELECT DISTINCT a.*
FROM alumno a
JOIN alumno_se_matricula_asignatura am ON a.id = am.id_alumno
JOIN asignatura asig ON am.id_asignatura = asig.id
JOIN grado g ON asig.id_grado = g.id
WHERE g.nombre = 'Grado en Ingeniería Informática (Plan 2015)' AND a.sexo = 'M';

![image](https://github.com/user-attachments/assets/d1e91ebb-82e4-486e-91d1-c1d3f3e83c43)


 2.Devuelve un listado con todas las asignaturas ofertadas en el Grado en
 Ingeniería Informática (Plan 2015).

SELECT asig.nombre
FROM asignatura asig
JOIN grado g ON asig.id_grado = g.id
WHERE g.nombre = 'Grado en Ingeniería Informática (Plan 2015)';

![image](https://github.com/user-attachments/assets/4f09379d-ee27-4527-96d9-d1eb0e8cc27a)


 3. Devuelve un listado de los profesores junto con el nombre del
 departamento al que están vinculados. El listado debe devolver cuatro
 columnas, primer apellido, segundo apellido, nombre y nombre del
 departamento. El resultado estará ordenado alfabéticamente de menor a
 mayor por los apellidos y el nombre.

SELECT p.apellido1, p.apellido2, p.nombre, d.nombre AS nombre_departamento
FROM profesor p
JOIN departamento d ON p.id_departamento = d.id
ORDER BY p.apellido1, p.apellido2, p.nombre;
![image](https://github.com/user-attachments/assets/08abf366-1424-44d0-8749-01469916895e)


 4. Devuelve un listado con el nombre de las asignaturas, año de inicio y año de
 fin del curso escolar del alumno con nif 26902806M.

SELECT asig.nombre, cs.anyo_inicio, cs.anyo_fin
FROM alumno_se_matricula_asignatura am
JOIN asignatura asig ON am.id_asignatura = asig.id
JOIN curso_escolar cs ON am.id_curso_escolar = cs.id
JOIN alumno a ON am.id_alumno = a.id
WHERE a.nif = '26902806M';

![image](https://github.com/user-attachments/assets/2e68b318-b7d0-49ee-b9e8-24a448907879)


 5. Devuelve un listado con el nombre de todos los departamentos que tienen
 profesores que imparten alguna asignatura en el Grado en Ingeniería
 Informática (Plan 2015).

SELECT DISTINCT d.nombre
FROM departamento d
JOIN profesor p ON d.id = p.id_departamento
JOIN asignatura asig ON p.id_profesor = asig.id_profesor
JOIN grado g ON asig.id_grado = g.id
WHERE g.nombre = 'Grado en Ingeniería Informática (Plan 2015)';

![image](https://github.com/user-attachments/assets/4a01c5cc-1699-4a2b-8eca-231ca175eede)


 6. Devuelve un listado con todos los alumnos que se han matriculado en
 alguna asignatura durante el curso escolar 2018/2019.

SELECT DISTINCT a.*
FROM alumno a
JOIN alumno_se_matricula_asignatura am ON a.id = am.id_alumno
JOIN curso_escolar cs ON am.id_curso_escolar = cs.id
WHERE cs.anyo_inicio = 2018 AND cs.anyo_fin = 2019;

![image](https://github.com/user-attachments/assets/ce333d4e-a604-4974-b8d9-3fe4c06f2d06)



 Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.

 1. Devuelve un listado con los nombres de todos los profesores y los
 departamentos que tienen vinculados. El listado también debe mostrar
 aquellos profesores que no tienen ningún departamento asociado. El listado
 debe devolver cuatro columnas, nombre del departamento, primer apellido,
 segundo apellido y nombre del profesor. El resultado estará ordenado
 alfabéticamente de menor a mayor por el nombre del departamento,
-apellidos y el nombre.

SELECT d.nombre AS nombre_departamento, p.apellido1, p.apellido2, p.nombre
FROM profesor p
LEFT JOIN departamento d ON p.id_departamento = d.id
ORDER BY d.nombre, p.apellido1, p.apellido2, p.nombre;

![image](https://github.com/user-attachments/assets/db5e1dce-6eee-4044-899c-08780614d8af)


 2. Devuelve un listado con los profesores que no están asociados a un
 departamento.

SELECT p.*
FROM profesor p
LEFT JOIN departamento d ON p.id_departamento = d.id
WHERE d.id IS NULL;
![image](https://github.com/user-attachments/assets/b0e2814e-8f21-48ad-be8f-3b5e3c8000af)


 3. Devuelve un listado con los departamentos que no tienen profesores
 asociados.

SELECT d.*
FROM departamento d
LEFT JOIN profesor p ON d.id = p.id_departamento
WHERE p.id_profesor IS NULL;

![image](https://github.com/user-attachments/assets/6a9f3530-5116-4ff3-9463-0f35c87ab437)

 4. Devuelve un listado con los profesores que no imparten ninguna asignatura.

SELECT p.*
FROM profesor p
LEFT JOIN asignatura a ON p.id_profesor = a.id_profesor
WHERE a.id IS NULL;

![image](https://github.com/user-attachments/assets/63ea3689-1f73-463f-ba8a-2df710f1c399)


 5. Devuelve un listado con las asignaturas que no tienen un profesor asignado.

SELECT a.*
FROM asignatura a
LEFT JOIN profesor p ON a.id_profesor = p.id_profesor
WHERE p.id_profesor IS NULL;

![image](https://github.com/user-attachments/assets/26dbce81-2903-46ff-901a-b253e75aa043)

 6. Devuelve un listado con todos los departamentos que tienen alguna
 asignatura que no se haya impartido en ningún curso escolar. El resultado
 debe mostrar el nombre del departamento y el nombre de la asignatura que
 no se haya impartido nunca.

SELECT DISTINCT d.nombre AS nombre_departamento, a.nombre AS nombre_asignatura
FROM departamento d
JOIN profesor p ON d.id = p.id_departamento
JOIN asignatura a ON p.id_profesor = a.id_profesor
LEFT JOIN alumno_se_matricula_asignatura am ON a.id = am.id_asignatura
WHERE am.id_curso_escolar IS NULL;

![image](https://github.com/user-attachments/assets/dc9421a0-8584-494d-b285-9ed749db796f)

 1. Devuelve el número total de alumnas que hay.

SELECT COUNT(*) AS total_alumnas
FROM alumno
WHERE sexo = 'M';

![image](https://github.com/user-attachments/assets/d19f0c11-e0df-41c3-ae1d-7c2a74400bee)


 2. Calcula cuántos alumnos nacieron en 1999.

SELECT COUNT(*) AS total_alumnos_1999
FROM alumno
WHERE EXTRACT(YEAR FROM fecha_nacimiento) = 1999;

![image](https://github.com/user-attachments/assets/424b4562-63a8-46dd-bcaa-fb531713d674)


 3. Calcula cuántos profesores hay en cada departamento. El resultado sólo
 debe mostrar dos columnas, una con el nombre del departamento y otra
 con el número de profesores que hay en ese departamento. El resultado
 sólo debe incluir los departamentos que tienen profesores asociados y
 deberá estar ordenado de mayor a menor por el número de profesores.

SELECT d.nombre AS nombre_departamento, COUNT(p.id_profesor) AS numero_profesores
FROM departamento d
JOIN profesor p ON d.id = p.id_departamento
GROUP BY d.nombre
ORDER BY numero_profesores DESC;

![image](https://github.com/user-attachments/assets/7f3fb39c-c3cf-47c4-98c9-779a4b77c722)


 4. Devuelve un listado con todos los departamentos y el número de profesores
 que hay en cada uno de ellos. Tenga en cuenta que pueden existir
 departamentos que no tienen profesores asociados. Estos departamentos
 también tienen que aparecer en el listado.

SELECT d.nombre AS nombre_departamento, COUNT(p.id_profesor) AS numero_profesores
FROM departamento d
LEFT JOIN profesor p ON d.id = p.id_departamento
GROUP BY d.nombre
ORDER BY numero_profesores DESC;

![image](https://github.com/user-attachments/assets/bce68abe-7283-4014-8328-884838463613)


 5. Devuelve un listado con el nombre de todos los grados existentes en la base
 de datos y el número de asignaturas que tiene cada uno. Tenga en cuenta
 que pueden existir grados que no tienen asignaturas asociadas. Estos grados
 también tienen que aparecer en el listado. El resultado deberá estar
 ordenado de mayor a menor por el número de asignaturas.

SELECT g.nombre AS nombre_grado, COUNT(a.id) AS numero_asignaturas
FROM grado g
LEFT JOIN asignatura a ON g.id = a.id_grado
GROUP BY g.nombre
ORDER BY numero_asignaturas DESC;

![image](https://github.com/user-attachments/assets/25566a5e-c056-493d-a6cf-d08ddedd07c4)


 6. Devuelve un listado con el nombre de todos los grados existentes en la base
 de datos y el número de asignaturas que tiene cada uno, de los grados que
 tengan más de 40 asignaturas asociadas.

SELECT g.nombre AS nombre_grado, COUNT(a.id) AS numero_asignaturas
FROM grado g
JOIN asignatura a ON g.id = a.id_grado
GROUP BY g.nombre
HAVING COUNT(a.id) > 40
ORDER BY numero_asignaturas DESC;

![image](https://github.com/user-attachments/assets/20a7db40-604a-4389-9a5f-d366d0fd916a)


 7. Devuelve un listado que muestre el nombre de los grados y la suma del
 número total de créditos que hay para cada tipo de asignatura. El resultado
 debe tener tres columnas: nombre del grado, tipo de asignatura y la suma
 de los créditos de todas las asignaturas que hay de ese tipo. Ordene el
 resultado de mayor a menor por el número total de crédidos.

SELECT g.nombre AS nombre_grado, a.tipo AS tipo_asignatura, SUM(a.creditos) AS suma_creditos
FROM grado g
JOIN asignatura a ON g.id = a.id_grado
GROUP BY g.nombre, a.tipo
ORDER BY suma_creditos DESC;

![image](https://github.com/user-attachments/assets/08337c77-428f-4af0-a138-7dc6b98045cf)


 8. Devuelve un listado que muestre cuántos alumnos se han matriculado de
 alguna asignatura en cada uno de los cursos escolares. El resultado deberá
 mostrar dos columnas, una columna con el año de inicio del curso escolar y
 otra con el número de alumnos matriculados.

SELECT cs.anyo_inicio, COUNT(DISTINCT am.id_alumno) AS numero_alumnos
FROM curso_escolar cs
JOIN alumno_se_matricula_asignatura am ON cs.id = am.id_curso_escolar
GROUP BY cs.anyo_inicio;

![image](https://github.com/user-attachments/assets/835b76f6-77ab-46b5-a4ea-0e14449857b1)


 9. Devuelve un listado con el número de asignaturas que imparte cada
 profesor. El listado debe tener en cuenta aquellos profesores que no
 imparten ninguna asignatura. El resultado mostrará cinco columnas: id,
 nombre, primer apellido, segundo apellido y número de asignaturas. El
 resultado estará ordenado de mayor a menor por el número de asignaturas.

SELECT p.id_profesor, p.nombre, p.apellido1, p.apellido2, COUNT(a.id) AS numero_asignaturas
FROM profesor p
LEFT JOIN asignatura a ON p.id_profesor = a.id_profesor
GROUP BY p.id_profesor, p.nombre, p.apellido1, p.apellido2
ORDER BY numero_asignaturas DESC;

![image](https://github.com/user-attachments/assets/19416562-4df4-497b-8045-25bab33dc975)


 1. Devuelve todos los datos del alumno más joven.

SELECT *
FROM alumno
WHERE fecha_nacimiento = (SELECT MAX(fecha_nacimiento) FROM alumno);

![image](https://github.com/user-attachments/assets/18111da4-5dca-4f48-9a36-3f0532daf586)


 2. Devuelve un listado con los profesores que no están asociados a un
 departamento.

SELECT p.*
FROM profesor p
LEFT JOIN departamento d ON p.id_departamento = d.id
WHERE d.id IS NULL;

![image](https://github.com/user-attachments/assets/8660cb2c-7b5c-4e2e-a2e1-ee086955d51e)

 3. Devuelve un listado con los departamentos que no tienen profesores
 asociados.

SELECT d.*
FROM departamento d
LEFT JOIN profesor p ON d.id = p.id_departamento
WHERE p.id_profesor IS NULL;

![image](https://github.com/user-attachments/assets/47e412da-d60e-41bd-b74b-e2b72b96812b)


 4. Devuelve un listado con los profesores que tienen un departamento
 asociado y que no imparten ninguna asignatura.

SELECT p.*
FROM profesor p
LEFT JOIN asignatura a ON p.id_profesor = a.id_profesor
WHERE a.id IS NULL AND p.id_departamento IS NOT NULL;

![image](https://github.com/user-attachments/assets/946dbc55-2b98-448f-9a62-0ba1df8d2764)

 5. Devuelve un listado con las asignaturas que no tienen un profesor asignado.

SELECT a.*
FROM asignatura a
LEFT JOIN profesor p ON a.id_profesor = p.id_profesor
WHERE p.id_profesor IS NULL;
![image](https://github.com/user-attachments/assets/43f1d236-ab1d-4afe-b59f-ba556f2360f6)


 6. Devuelve un listado con todos los departamentos que no han impartido
 asignaturas en ningún curso escolar.

SELECT d.nombre AS nombre_departamento
FROM departamento d
LEFT JOIN profesor p ON d.id = p.id_departamento
LEFT JOIN asignatura a ON p.id_profesor = a.id_profesor
LEFT JOIN alumno_se_matricula_asignatura am ON a.id = am.id_asignatura
WHERE am.id_curso_escolar IS NULL
GROUP BY d.nombre;

![image](https://github.com/user-attachments/assets/37b6baf5-b284-468e-a2a3-2801daba0a57)

