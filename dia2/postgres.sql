create table personas(
    id_persona serial primary key,
    nombre varchar(100),
    apellido varchar(100),
    municipio_nacimiento varchar(100),
    municipio_domicilio varchar(100)
);

create table region(
    id_region serial primary key,
    region varchar(80),
    departamento varchar(80),
    codigo_departamento int,
    municipio varchar(80),
    codigo_municipio int 
);

select * from personas;
select * from region;

--crear una vista que muestre las regiones con sus respectivos departamentos.
--en esta vista generar una columna que muestre la cantidad de municipios
--por cada departamento.

create view ejercicio1 as
select region, departamento, count(municipio) as cantidad_municipio
from region
group by region, departamento;

select * from ejercicio1;

--crear una vista que muestre los departamentos con sus respectivos municipios.
--en esta vista generar la columna de codigo de municipio completo, esto es, codigo
--de departamento concatenado con el codigo de municipio.

create view ejercicio2 as
select 
    departamento, municipio, codigo_departamento, codigo_municipio,
    concat(codigo_departamento, codigo_municipio) as codigo_municipio_completo
from 
    region;

select * from ejercicio2;
   
--agregar dos columnas a la tabla de municipios que permitan llevar el conteo de
--personas que viven y trabajan en cada municipio, y con base en esas columnas,
--implementar un disparador que actualice esos conteos toda vez que se agregue,
--modifique o elimine un dato de municipio de nacimiento y/o domicilio.
  
alter table region
add column personas_viviendo int default 0,
add column personas_trabajando int default 0;

create or replace function actualizar_conteo_municipios()
returns trigger as $$
begin
    -- incrementar o decrementar conteo de personas que viven en un municipio
    if (tg_op = 'insert') then
        update region
        set personas_viviendo = personas_viviendo + 1
        where municipio = new.municipio_domicilio;

    elsif (tg_op = 'delete') then
        update region
        set personas_viviendo = personas_viviendo - 1
        where municipio = old.municipio_domicilio;

    elsif (tg_op = 'update') then
        -- si el domicilio cambió, actualizar los conteos de los municipios involucrados
        if (old.municipio_domicilio <> new.municipio_domicilio) then
            update region
            set personas_viviendo = personas_viviendo - 1
            where municipio = old.municipio_domicilio;

            update region
            set personas_viviendo = personas_viviendo + 1
            where municipio = new.municipio_domicilio;
        end if;
    end if;

    return new;
end;
$$ language plpgsql;

-- trigger para inserciones
create trigger trigger_insertar_persona
after insert on personas
for each row
execute function actualizar_conteo_municipios();

-- trigger para actualizaciones
create trigger trigger_actualizar_persona
after update on personas
for each row
execute function actualizar_conteo_municipios();

-- trigger para eliminaciones
create trigger trigger_eliminar_persona
after delete on personas
for each row
execute function actualizar_conteo_municipios();

--agregar las columnas de conteos a la vista que muestra la lista de departamentos
-- y municipios. (modificar vista)

create or replace view ejercicio2 as
select 
    departamento, municipio, codigo_departamento, codigo_municipio,
    concat(codigo_departamento, codigo_municipio) as codigo_municipio_completo,
    personas_viviendo, personas_trabajando
from 
    region;
