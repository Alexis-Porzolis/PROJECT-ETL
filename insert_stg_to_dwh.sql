-- Poblamos la tabla dim_tiempo con las fechas de origen y destino de los recorridos.
INSERT INTO dwh.dim_tiempo (fecha, dia, mes, anio, dia_semana, es_fin_de_semana)
SELECT DISTINCT
    fecha_origen_recorrido AS fecha,
    strftime('%d', fecha_origen_recorrido) AS dia,
    strftime('%m', fecha_origen_recorrido) AS mes,
    strftime('%Y', fecha_origen_recorrido) AS anio,
    CASE strftime('%w', fecha_origen_recorrido)
        WHEN '0' THEN 'Domingo'
        WHEN '1' THEN 'Lunes'
        WHEN '2' THEN 'Martes'
        WHEN '3' THEN 'Miércoles'
        WHEN '4' THEN 'Jueves'
        WHEN '5' THEN 'Viernes'
        WHEN '6' THEN 'Sábado'
    END AS dia_semana,
    CASE WHEN strftime('%w', fecha_origen_recorrido) IN ('0', '6') THEN 1 ELSE 0 END AS es_fin_de_semana
FROM stg.trips
UNION
SELECT DISTINCT
    fecha_destino_recorrido AS fecha,
    strftime('%d', fecha_destino_recorrido) AS dia,
    strftime('%m', fecha_destino_recorrido) AS mes,
    strftime('%Y', fecha_destino_recorrido) AS anio,
    CASE strftime('%w', fecha_destino_recorrido)
        WHEN '0' THEN 'Domingo'
        WHEN '1' THEN 'Lunes'
        WHEN '2' THEN 'Martes'
        WHEN '3' THEN 'Miércoles'
        WHEN '4' THEN 'Jueves'
        WHEN '5' THEN 'Viernes'
        WHEN '6' THEN 'Sábado'
    END AS dia_semana,
    CASE WHEN strftime('%w', fecha_destino_recorrido) IN ('0', '6') THEN 1 ELSE 0 END AS es_fin_de_semana
FROM stg.trips;

-- Poblamos la tabla dim_estacion
INSERT INTO dwh.dim_estaciones (id_estacion, nombre, direccion, barrio, comuna, emplazamiento, latitud, longitud)
SELECT DISTINCT 
    "NÚMERO DE ESTACIÓN" AS id_estacion,
    "NOMBRE",
    "DIRECCIÓN" AS direccion,
    "BARRIO",
    "COMUNA",
    "EMPLAZAMIENTO",
    "LATITUD",
    "LONGITUD"
FROM stg.nuevas_estaciones_bicicletas;

-- Poblamos la tabla dim_usuarios
INSERT INTO dwh.dim_usuarios (id_usuario, genero_usuario, edad_usuario, fecha_alta, hora_alta)
SELECT DISTINCT 
    id_usuario,
    genero_usuario,
    edad_usuario,
    fecha_alta,
    hora_alta
FROM stg.usuarios_ecobici;

-- Poblamos la tabla hechos_viajes con los datos de la tabla trips y las tablas dim_tiempo, dim_estaciones y dim_usuarios
INSERT INTO dwh.hechos_viajes (id_recorrido, duracion_recorrido, fecha_origen_recorrido, fecha_destino_recorrido, id_estacion_origen, id_estacion_destino, id_usuario, modelo_bicicleta, genero)
SELECT
    t.Id_recorrido AS id_recorrido,
    t.duracion_recorrido AS duracion_recorrido,
    t.fecha_origen_recorrido AS fecha_origen_recorrido,
    t.fecha_destino_recorrido AS fecha_destino_recorrido,
    e_origen."NÚMERO DE ESTACIÓN" AS id_estacion_origen,
    e_destino."NÚMERO DE ESTACIÓN" AS id_estacion_destino,
    u.id_usuario AS id_usuario,
    t.modelo_bicicleta AS modelo_bicicleta,
    t.género AS genero
FROM stg.trips t
JOIN dwh.nuevas_estaciones_bicicletas e_origen ON t.id_estacion_origen = e_origen."NÚMERO DE ESTACIÓN"
JOIN dwh.nuevas_estaciones_bicicletas e_destino ON t.id_estacion_destino = e_destino."NÚMERO DE ESTACIÓN"
JOIN dwh.usuarios_ecobici u ON t.id_usuario = u.id_usuario;
