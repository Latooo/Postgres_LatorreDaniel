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

-- 3.Devuelve el listado de los alumnos que nacieron en 1999.
SELECT nombre, apellido1, apellido2
FROM alumno
WHERE EXTRACT(YEAR FROM fecha_nacimiento) = 1999;

-- 4.Devuelve el listado de profesores que no han dado de alta su número de
-- teléfono en la base de datos y además su nif termina en K.
SELECT nombre, apellido1, apellido2
FROM profesor
WHERE telefono IS NULL AND nif LIKE '%K';

-- 5.Devuelve el listado de las asignaturas que se imparten en el primer
-- cuatrimestre, en el tercer curso del grado que tiene el identificador 7.
SELECT nombre
FROM asignatura
WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7;


-- 1.Devuelve un listado con los datos de todas las alumnas que se han
-- matriculado alguna vez en el Grado en Ingeniería Informática (Plan 2015).
SELECT DISTINCT a.*
FROM alumno a
JOIN alumno_se_matricula_asignatura am ON a.id = am.id_alumno
JOIN asignatura asig ON am.id_asignatura = asig.id
JOIN grado g ON asig.id_grado = g.id
WHERE g.nombre = 'Grado en Ingeniería Informática (Plan 2015)' AND a.sexo = 'M';

-- 2.Devuelve un listado con todas las asignaturas ofertadas en el Grado en
-- Ingeniería Informática (Plan 2015).
SELECT asig.nombre
FROM asignatura asig
JOIN grado g ON asig.id_grado = g.id
WHERE g.nombre = 'Grado en Ingeniería Informática (Plan 2015)';

-- 3. Devuelve un listado de los profesores junto con el nombre del
-- departamento al que están vinculados. El listado debe devolver cuatro
-- columnas, primer apellido, segundo apellido, nombre y nombre del
-- departamento. El resultado estará ordenado alfabéticamente de menor a
-- mayor por los apellidos y el nombre.
SELECT p.apellido1, p.apellido2, p.nombre, d.nombre AS nombre_departamento
FROM profesor p
JOIN departamento d ON p.id_departamento = d.id
ORDER BY p.apellido1, p.apellido2, p.nombre;

-- 4. Devuelve un listado con el nombre de las asignaturas, año de inicio y año de
-- fin del curso escolar del alumno con nif 26902806M.
SELECT asig.nombre, cs.anyo_inicio, cs.anyo_fin
FROM alumno_se_matricula_asignatura am
JOIN asignatura asig ON am.id_asignatura = asig.id
JOIN curso_escolar cs ON am.id_curso_escolar = cs.id
JOIN alumno a ON am.id_alumno = a.id
WHERE a.nif = '26902806M';

-- 5. Devuelve un listado con el nombre de todos los departamentos que tienen
-- profesores que imparten alguna asignatura en el Grado en Ingeniería
-- Informática (Plan 2015).
SELECT DISTINCT d.nombre
FROM departamento d
JOIN profesor p ON d.id = p.id_departamento
JOIN asignatura asig ON p.id_profesor = asig.id_profesor
JOIN grado g ON asig.id_grado = g.id
WHERE g.nombre = 'Grado en Ingeniería Informática (Plan 2015)';

-- 6. Devuelve un listado con todos los alumnos que se han matriculado en
-- alguna asignatura durante el curso escolar 2018/2019.
SELECT DISTINCT a.*
FROM alumno a
JOIN alumno_se_matricula_asignatura am ON a.id = am.id_alumno
JOIN curso_escolar cs ON am.id_curso_escolar = cs.id
WHERE cs.anyo_inicio = 2018 AND cs.anyo_fin = 2019;


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

-- 2. Devuelve un listado con los profesores que no están asociados a un
-- departamento.
SELECT p.*
FROM profesor p
LEFT JOIN departamento d ON p.id_departamento = d.id
WHERE d.id IS NULL;

-- 3. Devuelve un listado con los departamentos que no tienen profesores
-- asociados.
SELECT d.*
FROM departamento d
LEFT JOIN profesor p ON d.id = p.id_departamento
WHERE p.id_profesor IS NULL;

-- 4. Devuelve un listado con los profesores que no imparten ninguna asignatura.
SELECT p.*
FROM profesor p
LEFT JOIN asignatura a ON p.id_profesor = a.id_profesor
WHERE a.id IS NULL;

-- 5. Devuelve un listado con las asignaturas que no tienen un profesor asignado.
SELECT a.*
FROM asignatura a
LEFT JOIN profesor p ON a.id_profesor = p.id_profesor
WHERE p.id_profesor IS NULL;

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


-- 1. Devuelve el número total de alumnas que hay.
SELECT COUNT(*) AS total_alumnas
FROM alumno
WHERE sexo = 'M';

-- 2. Calcula cuántos alumnos nacieron en 1999.
SELECT COUNT(*) AS total_alumnos_1999
FROM alumno
WHERE EXTRACT(YEAR FROM fecha_nacimiento) = 1999;

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

-- 4. Devuelve un listado con todos los departamentos y el número de profesores
-- que hay en cada uno de ellos. Tenga en cuenta que pueden existir
-- departamentos que no tienen profesores asociados. Estos departamentos
-- también tienen que aparecer en el listado.
SELECT d.nombre AS nombre_departamento, COUNT(p.id_profesor) AS numero_profesores
FROM departamento d
LEFT JOIN profesor p ON d.id = p.id_departamento
GROUP BY d.nombre
ORDER BY numero_profesores DESC;

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

-- 6. Devuelve un listado con el nombre de todos los grados existentes en la base
-- de datos y el número de asignaturas que tiene cada uno, de los grados que
-- tengan más de 40 asignaturas asociadas.
SELECT g.nombre AS nombre_grado, COUNT(a.id) AS numero_asignaturas
FROM grado g
JOIN asignatura a ON g.id = a.id_grado
GROUP BY g.nombre
HAVING COUNT(a.id) > 40
ORDER BY numero_asignaturas DESC;

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

-- 8. Devuelve un listado que muestre cuántos alumnos se han matriculado de
-- alguna asignatura en cada uno de los cursos escolares. El resultado deberá
-- mostrar dos columnas, una columna con el año de inicio del curso escolar y
-- otra con el número de alumnos matriculados.
SELECT cs.anyo_inicio, COUNT(DISTINCT am.id_alumno) AS numero_alumnos
FROM curso_escolar cs
JOIN alumno_se_matricula_asignatura am ON cs.id = am.id_curso_escolar
GROUP BY cs.anyo_inicio;

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

-- 1. Devuelve todos los datos del alumno más joven.
SELECT *
FROM alumno
WHERE fecha_nacimiento = (SELECT MAX(fecha_nacimiento) FROM alumno);

-- 2. Devuelve un listado con los profesores que no están asociados a un
-- departamento.
SELECT p.*
FROM profesor p
LEFT JOIN departamento d ON p.id_departamento = d.id
WHERE d.id IS NULL;

-- 3. Devuelve un listado con los departamentos que no tienen profesores
-- asociados.
SELECT d.*
FROM departamento d
LEFT JOIN profesor p ON d.id = p.id_departamento
WHERE p.id_profesor IS NULL;

-- 4. Devuelve un listado con los profesores que tienen un departamento
-- asociado y que no imparten ninguna asignatura.
SELECT p.*
FROM profesor p
LEFT JOIN asignatura a ON p.id_profesor = a.id_profesor
WHERE a.id IS NULL AND p.id_departamento IS NOT NULL;

-- 5. Devuelve un listado con las asignaturas que no tienen un profesor asignado.
SELECT a.*
FROM asignatura a
LEFT JOIN profesor p ON a.id_profesor = p.id_profesor
WHERE p.id_profesor IS NULL;

-- 6. Devuelve un listado con todos los departamentos que no han impartido
-- asignaturas en ningún curso escolar.
SELECT d.nombre AS nombre_departamento
FROM departamento d
LEFT JOIN profesor p ON d.id = p.id_departamento
LEFT JOIN asignatura a ON p.id_profesor = a.id_profesor
LEFT JOIN alumno_se_matricula_asignatura am ON a.id = am.id_asignatura
WHERE am.id_curso_escolar IS NULL
GROUP BY d.nombre;
