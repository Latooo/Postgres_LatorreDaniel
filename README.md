--Subconsultas
--Con operadores básicos de comparación
--1. Devuelve el nombre del cliente con mayor límite de crédito.

SELECT nombre_cliente
FROM cliente
WHERE limite_credito = (SELECT MAX(limite_credito) FROM cliente);

![image](https://github.com/user-attachments/assets/dcd9bf67-6521-48ff-83fa-6603cfa99b9a)


--2. Devuelve el nombre del producto que tenga el precio de venta más caro.

SELECT nombre
FROM producto
WHERE precio_venta = (SELECT MAX(precio_venta) FROM producto);

![image](https://github.com/user-attachments/assets/5b96c406-6c7f-422a-bdbf-568622a3370c)

--3. Devuelve el nombre del producto del que se han vendido más unidades.
--(Tenga en cuenta que tendrá que calcular cuál es el número total de
--unidades que se han vendido de cada producto a partir de los datos de la
--tabla detalle_pedido)

SELECT p.nombre
FROM producto p
JOIN detalle_pedido dp ON p.codigo_producto = dp.codigo_producto
GROUP BY p.nombre
ORDER BY SUM(dp.cantidad) DESC
LIMIT 1;

![image](https://github.com/user-attachments/assets/7f1c28c6-5677-45dd-a47c-228e3a5842e3)

--4. Los clientes cuyo límite de crédito sea mayor que los pagos que haya
--realizado. (Sin utilizar INNER JOIN).

SELECT nombre_cliente
FROM cliente
WHERE limite_credito > ALL (
    SELECT total
    FROM pago
    WHERE cliente.codigo_cliente = pago.codigo_cliente
);

![image](https://github.com/user-attachments/assets/938bb866-1184-4612-a651-d1b404422ad7)


--5. Devuelve el producto que más unidades tiene en stock.

SELECT nombre
FROM producto
WHERE cantidad_en_stock = (SELECT MAX(cantidad_en_stock) FROM producto);

![image](https://github.com/user-attachments/assets/087204a2-6c87-457e-b59f-b972c4786877)


--6. Devuelve el producto que menos unidades tiene en stock.

SELECT nombre
FROM producto
WHERE cantidad_en_stock = (SELECT MIN(cantidad_en_stock) FROM producto);

![image](https://github.com/user-attachments/assets/5aaafbac-6562-48d8-8855-c6ddcc2db02a)


--7. Devuelve el nombre, los apellidos y el email de los empleados que están a
--cargo de Alberto Soria.

SELECT e.nombre, e.apellido1, e.email
FROM empleado e
WHERE e.codigo_jefe = (
    SELECT codigo_empleado
    FROM empleado
    WHERE nombre = 'Alberto' AND apellido1 = 'Soria'
);

![image](https://github.com/user-attachments/assets/f2f018b5-0ec5-4615-bbff-deff43d6bddf)


--Subconsultas con ALL y any

--8. Devuelve el nombre del cliente con mayor límite de crédito.

SELECT nombre_cliente
FROM cliente
WHERE limite_credito = ANY (SELECT MAX(limite_credito) FROM cliente);

![image](https://github.com/user-attachments/assets/c18ffd73-2eaa-4141-af9c-c80491455009)


--9. Devuelve el nombre del producto que tenga el precio de venta más caro.

SELECT nombre
FROM producto
WHERE precio_venta = ANY (SELECT MAX(precio_venta) FROM producto);

![image](https://github.com/user-attachments/assets/16bbb49f-00b9-47bd-9344-36fe0dba0b92)


--10. Devuelve el producto que menos unidades tiene en stock.

SELECT nombre
FROM producto
WHERE cantidad_en_stock = ANY (SELECT MIN(cantidad_en_stock) FROM producto);

![image](https://github.com/user-attachments/assets/bcc3d53c-19a9-4bbf-842f-4d58d72cd09e)


--Subconsultas con IN y NOT in

--11. Devuelve el nombre, apellido1 y cargo de los empleados que no
--representen a ningún cliente.

SELECT nombre, apellido1, puesto
FROM empleado
WHERE codigo_empleado NOT IN (
    SELECT DISTINCT codigo_empleado_rep_ventas
    FROM cliente
    WHERE codigo_empleado_rep_ventas IS NOT NULL
);
![image](https://github.com/user-attachments/assets/c33f0f71-f215-4601-942f-fd1fbc9bcd34)


--12. Devuelve un listado que muestre solamente los clientes que no han
--realizado ningún pago.

SELECT nombre_cliente
FROM cliente
WHERE codigo_cliente NOT IN (
    SELECT DISTINCT codigo_cliente
    FROM pago
);

![image](https://github.com/user-attachments/assets/91d2a6fa-ef03-43cc-ae32-1b352270271b)


--13. Devuelve un listado que muestre solamente los clientes que sí han realizado
--algún pago.

SELECT nombre_cliente
FROM cliente
WHERE codigo_cliente IN (
    SELECT DISTINCT codigo_cliente
    FROM pago
);

![image](https://github.com/user-attachments/assets/70f18e98-9b26-4eae-8835-b36a39aeffd7)


--14. Devuelve un listado de los productos que nunca han aparecido en un
--pedido.

SELECT nombre
FROM producto
WHERE codigo_producto NOT IN (
    SELECT DISTINCT codigo_producto
    FROM detalle_pedido
);

![image](https://github.com/user-attachments/assets/30e3f26f-7094-4d95-9a26-0212fe0b5e76)


--15. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos
--empleados que no sean representante de ventas de ningún cliente.

SELECT e.nombre, e.apellido1, e.puesto, o.telefono
FROM empleado e
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE e.codigo_empleado NOT IN (
    SELECT DISTINCT codigo_empleado_rep_ventas
    FROM cliente
    WHERE codigo_empleado_rep_ventas IS NOT NULL
);

![image](https://github.com/user-attachments/assets/ccd93fd8-d3de-4e06-bfc0-64251a44df86)


--16. Devuelve las oficinas donde no trabajan ninguno de los empleados que
--hayan sido los representantes de ventas de algún cliente que haya realizado
--la compra de algún producto de la gama Frutales.

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


--17. Devuelve un listado con los clientes que han realizado algún pedido pero no
--han realizado ningún pago.

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


--Subconsultas con EXISTS y NOT exists
--18. Devuelve un listado que muestre solamente los clientes que no han
--realizado ningún pago.

SELECT nombre_cliente
FROM cliente c
WHERE NOT EXISTS (
    SELECT 1
    FROM pago p
    WHERE p.codigo_cliente = c.codigo_cliente
);

![image](https://github.com/user-attachments/assets/0cbec486-f805-4c49-95b1-71781c9eda51)


--19. Devuelve un listado que muestre solamente los clientes que sí han realizado
--algún pago.

SELECT nombre_cliente
FROM cliente c
WHERE EXISTS (
    SELECT 1
    FROM pago p
    WHERE p.codigo_cliente = c.codigo_cliente
);

![image](https://github.com/user-attachments/assets/86f5f8b8-32a9-4623-aa49-efb8feb33b13)


--20. Devuelve un listado de los productos que nunca han aparecido en un
--pedido.

SELECT nombre
FROM producto p
WHERE NOT EXISTS (
    SELECT 1
    FROM detalle_pedido dp
    WHERE dp.codigo_producto = p.codigo_producto
);

![image](https://github.com/user-attachments/assets/cae9294b-1675-4727-b0e7-2e5d6fa805ea)


--21. Devuelve un listado de los productos que han aparecido en un pedido
--alguna vez.

SELECT DISTINCT p.nombre
FROM producto p
WHERE EXISTS (
    SELECT 1
    FROM detalle_pedido dp
    WHERE dp.codigo_producto = p.codigo_producto
);

![image](https://github.com/user-attachments/assets/d8fbe6be-1d59-455c-b6b5-9eacf4160d88)


--Subconsultas correlacionadas
--Consultas variadas

--1. Devuelve el listado de clientes indicando el nombre del cliente y cuántos
--pedidos ha realizado. Tenga en cuenta que pueden existir clientes que no
--han realizado ningún pedido.

SELECT c.nombre_cliente,
       (SELECT COUNT(*)
        FROM pedido p
        WHERE p.codigo_cliente = c.codigo_cliente) AS total_pedidos
FROM cliente c;

![image](https://github.com/user-attachments/assets/d8f43395-700d-4bb6-aded-c20fd5dd11be)


--2. Devuelve un listado con los nombres de los clientes y el total pagado por
--cada uno de ellos. Tenga en cuenta que pueden existir clientes que no han
--realizado ningún pago.

SELECT c.nombre_cliente,
       COALESCE((
           SELECT SUM(p.total)
           FROM pago p
           WHERE p.codigo_cliente = c.codigo_cliente
       ), 0) AS total_pagado
FROM cliente c;
![image](https://github.com/user-attachments/assets/bb65d995-80f0-4178-b50d-9766e7789e19)


--3. Devuelve el nombre de los clientes que hayan hecho pedidos en 2008
--ordenados alfabéticamente de menor a mayor.

SELECT DISTINCT c.nombre_cliente
FROM cliente c
JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
WHERE EXTRACT(YEAR FROM p.fecha_pedido) = 2008
ORDER BY c.nombre_cliente;

![image](https://github.com/user-attachments/assets/315f8ac0-46d6-4283-926d-d85d5737beed)


--4. Devuelve el nombre del cliente, el nombre y primer apellido de su
--representante de ventas y el número de teléfono de la oficina del
--representante de ventas, de aquellos clientes que no hayan realizado ningún
--pago.

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


--5. Devuelve el listado de clientes donde aparezca el nombre del cliente, el
--nombre y primer apellido de su representante de ventas y la ciudad donde
--está su oficina.

SELECT c.nombre_cliente,
       e.nombre,
       e.apellido1,
       o.ciudad
FROM cliente c
JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina;

![image](https://github.com/user-attachments/assets/0cb3a000-de86-450e-8598-48295f8382c1)


--6. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos
--empleados que no sean representante de ventas de ningún cliente.

SELECT e.nombre, e.apellido1, e.puesto, o.telefono
FROM empleado e
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE e.codigo_empleado NOT IN (
    SELECT DISTINCT codigo_empleado_rep_ventas
    FROM cliente
    WHERE codigo_empleado_rep_ventas IS NOT NULL
);

![image](https://github.com/user-attachments/assets/c3535624-975d-4d7f-9128-ea001e0eb1a5)


--7. Devuelve un listado indicando todas las ciudades donde hay oficinas y el
--número de empleados que tiene.

SELECT o.ciudad, COUNT(e.codigo_empleado) AS total_empleados
FROM oficina o
LEFT JOIN empleado e ON o.codigo_oficina = e.codigo_oficina
GROUP BY o.ciudad;

![image](https://github.com/user-attachments/assets/b8da0d8e-803c-4c4a-91c7-f75f5617a2b5)


## Colegio DATABASE

-- 1.Devuelve un listado con el primer apellido, segundo apellido y el nombre de
-- todos los alumnos. El listado deberá estar ordenado alfabéticamente de
-- menor a mayor por el primer apellido, segundo apellido y nombre.

SELECT apellido1, apellido2, nombre
FROM alumno
ORDER BY apellido1, apellido2, nombre;

![image](https://github.com/user-attachments/assets/b3a38e6e-7619-44f6-893b-b52a42a541e2)


-- 2.Averigua el nombre y los dos apellidos de los alumnos que no han dado de
-- alta su número de teléfono en la base de datos.

SELECT nombre, apellido1, apellido2
FROM alumno
WHERE telefono IS NULL;

![image](https://github.com/user-attachments/assets/5e6c4920-e62c-4a58-ac7f-a3aca17013d4)

-- 3.Devuelve el listado de los alumnos que nacieron en 1999.

SELECT nombre, apellido1, apellido2
FROM alumno
WHERE EXTRACT(YEAR FROM fecha_nacimiento) = 1999;

![image](https://github.com/user-attachments/assets/8b7ed6f4-2f16-4df4-89e2-85296f7018bb)


-- 4.Devuelve el listado de profesores que no han dado de alta su número de
-- teléfono en la base de datos y además su nif termina en K.

SELECT nombre, apellido1, apellido2
FROM profesor
WHERE telefono IS NULL AND nif LIKE '%K';

![image](https://github.com/user-attachments/assets/11bb882d-9bfb-4a6a-b2cf-f473955a2da2)


-- 5.Devuelve el listado de las asignaturas que se imparten en el primer
-- cuatrimestre, en el tercer curso del grado que tiene el identificador 7.

SELECT nombre
FROM asignatura
WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7;

![image](https://github.com/user-attachments/assets/f8507574-e3a3-408c-bee7-1aeb26e25af6)


-- 1.Devuelve un listado con los datos de todas las alumnas que se han
-- matriculado alguna vez en el Grado en Ingeniería Informática (Plan 2015).

SELECT DISTINCT a.*
FROM alumno a
JOIN alumno_se_matricula_asignatura am ON a.id = am.id_alumno
JOIN asignatura asig ON am.id_asignatura = asig.id
JOIN grado g ON asig.id_grado = g.id
WHERE g.nombre = 'Grado en Ingeniería Informática (Plan 2015)' AND a.sexo = 'M';

![image](https://github.com/user-attachments/assets/d1e91ebb-82e4-486e-91d1-c1d3f3e83c43)


-- 2.Devuelve un listado con todas las asignaturas ofertadas en el Grado en
-- Ingeniería Informática (Plan 2015).

SELECT asig.nombre
FROM asignatura asig
JOIN grado g ON asig.id_grado = g.id
WHERE g.nombre = 'Grado en Ingeniería Informática (Plan 2015)';

![image](https://github.com/user-attachments/assets/4f09379d-ee27-4527-96d9-d1eb0e8cc27a)


-- 3. Devuelve un listado de los profesores junto con el nombre del
-- departamento al que están vinculados. El listado debe devolver cuatro
-- columnas, primer apellido, segundo apellido, nombre y nombre del
-- departamento. El resultado estará ordenado alfabéticamente de menor a
-- mayor por los apellidos y el nombre.

SELECT p.apellido1, p.apellido2, p.nombre, d.nombre AS nombre_departamento
FROM profesor p
JOIN departamento d ON p.id_departamento = d.id
ORDER BY p.apellido1, p.apellido2, p.nombre;
![image](https://github.com/user-attachments/assets/08abf366-1424-44d0-8749-01469916895e)


-- 4. Devuelve un listado con el nombre de las asignaturas, año de inicio y año de
-- fin del curso escolar del alumno con nif 26902806M.

SELECT asig.nombre, cs.anyo_inicio, cs.anyo_fin
FROM alumno_se_matricula_asignatura am
JOIN asignatura asig ON am.id_asignatura = asig.id
JOIN curso_escolar cs ON am.id_curso_escolar = cs.id
JOIN alumno a ON am.id_alumno = a.id
WHERE a.nif = '26902806M';

![image](https://github.com/user-attachments/assets/2e68b318-b7d0-49ee-b9e8-24a448907879)


-- 5. Devuelve un listado con el nombre de todos los departamentos que tienen
-- profesores que imparten alguna asignatura en el Grado en Ingeniería
-- Informática (Plan 2015).

SELECT DISTINCT d.nombre
FROM departamento d
JOIN profesor p ON d.id = p.id_departamento
JOIN asignatura asig ON p.id_profesor = asig.id_profesor
JOIN grado g ON asig.id_grado = g.id
WHERE g.nombre = 'Grado en Ingeniería Informática (Plan 2015)';

![image](https://github.com/user-attachments/assets/4a01c5cc-1699-4a2b-8eca-231ca175eede)


-- 6. Devuelve un listado con todos los alumnos que se han matriculado en
-- alguna asignatura durante el curso escolar 2018/2019.

SELECT DISTINCT a.*
FROM alumno a
JOIN alumno_se_matricula_asignatura am ON a.id = am.id_alumno
JOIN curso_escolar cs ON am.id_curso_escolar = cs.id
WHERE cs.anyo_inicio = 2018 AND cs.anyo_fin = 2019;

![image](https://github.com/user-attachments/assets/ce333d4e-a604-4974-b8d9-3fe4c06f2d06)



-- Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.

-- 1. Devuelve un listado con los nombres de todos los profesores y los
-- departamentos que tienen vinculados. El listado también debe mostrar
-- aquellos profesores que no tienen ningún departamento asociado. El listado
-- debe devolver cuatro columnas, nombre del departamento, primer apellido,
-- segundo apellido y nombre del profesor. El resultado estará ordenado
-- alfabéticamente de menor a mayor por el nombre del departamento,
---apellidos y el nombre.

SELECT d.nombre AS nombre_departamento, p.apellido1, p.apellido2, p.nombre
FROM profesor p
LEFT JOIN departamento d ON p.id_departamento = d.id
ORDER BY d.nombre, p.apellido1, p.apellido2, p.nombre;

![image](https://github.com/user-attachments/assets/db5e1dce-6eee-4044-899c-08780614d8af)


-- 2. Devuelve un listado con los profesores que no están asociados a un
-- departamento.

SELECT p.*
FROM profesor p
LEFT JOIN departamento d ON p.id_departamento = d.id
WHERE d.id IS NULL;
![image](https://github.com/user-attachments/assets/b0e2814e-8f21-48ad-be8f-3b5e3c8000af)


-- 3. Devuelve un listado con los departamentos que no tienen profesores
-- asociados.

SELECT d.*
FROM departamento d
LEFT JOIN profesor p ON d.id = p.id_departamento
WHERE p.id_profesor IS NULL;

![image](https://github.com/user-attachments/assets/6a9f3530-5116-4ff3-9463-0f35c87ab437)

-- 4. Devuelve un listado con los profesores que no imparten ninguna asignatura.

SELECT p.*
FROM profesor p
LEFT JOIN asignatura a ON p.id_profesor = a.id_profesor
WHERE a.id IS NULL;

![image](https://github.com/user-attachments/assets/63ea3689-1f73-463f-ba8a-2df710f1c399)


-- 5. Devuelve un listado con las asignaturas que no tienen un profesor asignado.

SELECT a.*
FROM asignatura a
LEFT JOIN profesor p ON a.id_profesor = p.id_profesor
WHERE p.id_profesor IS NULL;

![image](https://github.com/user-attachments/assets/26dbce81-2903-46ff-901a-b253e75aa043)

-- 6. Devuelve un listado con todos los departamentos que tienen alguna
-- asignatura que no se haya impartido en ningún curso escolar. El resultado
-- debe mostrar el nombre del departamento y el nombre de la asignatura que
-- no se haya impartido nunca.

SELECT DISTINCT d.nombre AS nombre_departamento, a.nombre AS nombre_asignatura
FROM departamento d
JOIN profesor p ON d.id = p.id_departamento
JOIN asignatura a ON p.id_profesor = a.id_profesor
LEFT JOIN alumno_se_matricula_asignatura am ON a.id = am.id_asignatura
WHERE am.id_curso_escolar IS NULL;

![image](https://github.com/user-attachments/assets/dc9421a0-8584-494d-b285-9ed749db796f)

-- 1. Devuelve el número total de alumnas que hay.

SELECT COUNT(*) AS total_alumnas
FROM alumno
WHERE sexo = 'M';

![image](https://github.com/user-attachments/assets/d19f0c11-e0df-41c3-ae1d-7c2a74400bee)


-- 2. Calcula cuántos alumnos nacieron en 1999.

SELECT COUNT(*) AS total_alumnos_1999
FROM alumno
WHERE EXTRACT(YEAR FROM fecha_nacimiento) = 1999;

![image](https://github.com/user-attachments/assets/424b4562-63a8-46dd-bcaa-fb531713d674)


-- 3. Calcula cuántos profesores hay en cada departamento. El resultado sólo
-- debe mostrar dos columnas, una con el nombre del departamento y otra
-- con el número de profesores que hay en ese departamento. El resultado
-- sólo debe incluir los departamentos que tienen profesores asociados y
-- deberá estar ordenado de mayor a menor por el número de profesores.

SELECT d.nombre AS nombre_departamento, COUNT(p.id_profesor) AS numero_profesores
FROM departamento d
JOIN profesor p ON d.id = p.id_departamento
GROUP BY d.nombre
ORDER BY numero_profesores DESC;

![image](https://github.com/user-attachments/assets/7f3fb39c-c3cf-47c4-98c9-779a4b77c722)


-- 4. Devuelve un listado con todos los departamentos y el número de profesores
-- que hay en cada uno de ellos. Tenga en cuenta que pueden existir
-- departamentos que no tienen profesores asociados. Estos departamentos
-- también tienen que aparecer en el listado.

SELECT d.nombre AS nombre_departamento, COUNT(p.id_profesor) AS numero_profesores
FROM departamento d
LEFT JOIN profesor p ON d.id = p.id_departamento
GROUP BY d.nombre
ORDER BY numero_profesores DESC;

![image](https://github.com/user-attachments/assets/bce68abe-7283-4014-8328-884838463613)


-- 5. Devuelve un listado con el nombre de todos los grados existentes en la base
-- de datos y el número de asignaturas que tiene cada uno. Tenga en cuenta
-- que pueden existir grados que no tienen asignaturas asociadas. Estos grados
-- también tienen que aparecer en el listado. El resultado deberá estar
-- ordenado de mayor a menor por el número de asignaturas.

SELECT g.nombre AS nombre_grado, COUNT(a.id) AS numero_asignaturas
FROM grado g
LEFT JOIN asignatura a ON g.id = a.id_grado
GROUP BY g.nombre
ORDER BY numero_asignaturas DESC;

![image](https://github.com/user-attachments/assets/25566a5e-c056-493d-a6cf-d08ddedd07c4)


-- 6. Devuelve un listado con el nombre de todos los grados existentes en la base
-- de datos y el número de asignaturas que tiene cada uno, de los grados que
-- tengan más de 40 asignaturas asociadas.

SELECT g.nombre AS nombre_grado, COUNT(a.id) AS numero_asignaturas
FROM grado g
JOIN asignatura a ON g.id = a.id_grado
GROUP BY g.nombre
HAVING COUNT(a.id) > 40
ORDER BY numero_asignaturas DESC;

![image](https://github.com/user-attachments/assets/20a7db40-604a-4389-9a5f-d366d0fd916a)


-- 7. Devuelve un listado que muestre el nombre de los grados y la suma del
-- número total de créditos que hay para cada tipo de asignatura. El resultado
-- debe tener tres columnas: nombre del grado, tipo de asignatura y la suma
-- de los créditos de todas las asignaturas que hay de ese tipo. Ordene el
-- resultado de mayor a menor por el número total de crédidos.

SELECT g.nombre AS nombre_grado, a.tipo AS tipo_asignatura, SUM(a.creditos) AS suma_creditos
FROM grado g
JOIN asignatura a ON g.id = a.id_grado
GROUP BY g.nombre, a.tipo
ORDER BY suma_creditos DESC;

![image](https://github.com/user-attachments/assets/08337c77-428f-4af0-a138-7dc6b98045cf)


-- 8. Devuelve un listado que muestre cuántos alumnos se han matriculado de
-- alguna asignatura en cada uno de los cursos escolares. El resultado deberá
-- mostrar dos columnas, una columna con el año de inicio del curso escolar y
-- otra con el número de alumnos matriculados.

SELECT cs.anyo_inicio, COUNT(DISTINCT am.id_alumno) AS numero_alumnos
FROM curso_escolar cs
JOIN alumno_se_matricula_asignatura am ON cs.id = am.id_curso_escolar
GROUP BY cs.anyo_inicio;

![image](https://github.com/user-attachments/assets/835b76f6-77ab-46b5-a4ea-0e14449857b1)


-- 9. Devuelve un listado con el número de asignaturas que imparte cada
-- profesor. El listado debe tener en cuenta aquellos profesores que no
-- imparten ninguna asignatura. El resultado mostrará cinco columnas: id,
-- nombre, primer apellido, segundo apellido y número de asignaturas. El
-- resultado estará ordenado de mayor a menor por el número de asignaturas.

SELECT p.id_profesor, p.nombre, p.apellido1, p.apellido2, COUNT(a.id) AS numero_asignaturas
FROM profesor p
LEFT JOIN asignatura a ON p.id_profesor = a.id_profesor
GROUP BY p.id_profesor, p.nombre, p.apellido1, p.apellido2
ORDER BY numero_asignaturas DESC;

![image](https://github.com/user-attachments/assets/19416562-4df4-497b-8045-25bab33dc975)


-- 1. Devuelve todos los datos del alumno más joven.

SELECT *
FROM alumno
WHERE fecha_nacimiento = (SELECT MAX(fecha_nacimiento) FROM alumno);

![image](https://github.com/user-attachments/assets/18111da4-5dca-4f48-9a36-3f0532daf586)


-- 2. Devuelve un listado con los profesores que no están asociados a un
-- departamento.

SELECT p.*
FROM profesor p
LEFT JOIN departamento d ON p.id_departamento = d.id
WHERE d.id IS NULL;

![image](https://github.com/user-attachments/assets/8660cb2c-7b5c-4e2e-a2e1-ee086955d51e)

-- 3. Devuelve un listado con los departamentos que no tienen profesores
-- asociados.

SELECT d.*
FROM departamento d
LEFT JOIN profesor p ON d.id = p.id_departamento
WHERE p.id_profesor IS NULL;

![image](https://github.com/user-attachments/assets/47e412da-d60e-41bd-b74b-e2b72b96812b)


-- 4. Devuelve un listado con los profesores que tienen un departamento
-- asociado y que no imparten ninguna asignatura.

SELECT p.*
FROM profesor p
LEFT JOIN asignatura a ON p.id_profesor = a.id_profesor
WHERE a.id IS NULL AND p.id_departamento IS NOT NULL;

![image](https://github.com/user-attachments/assets/946dbc55-2b98-448f-9a62-0ba1df8d2764)

-- 5. Devuelve un listado con las asignaturas que no tienen un profesor asignado.

SELECT a.*
FROM asignatura a
LEFT JOIN profesor p ON a.id_profesor = p.id_profesor
WHERE p.id_profesor IS NULL;
![image](https://github.com/user-attachments/assets/43f1d236-ab1d-4afe-b59f-ba556f2360f6)


-- 6. Devuelve un listado con todos los departamentos que no han impartido
-- asignaturas en ningún curso escolar.

SELECT d.nombre AS nombre_departamento
FROM departamento d
LEFT JOIN profesor p ON d.id = p.id_departamento
LEFT JOIN asignatura a ON p.id_profesor = a.id_profesor
LEFT JOIN alumno_se_matricula_asignatura am ON a.id = am.id_asignatura
WHERE am.id_curso_escolar IS NULL
GROUP BY d.nombre;

![image](https://github.com/user-attachments/assets/37b6baf5-b284-468e-a2a3-2801daba0a57)

