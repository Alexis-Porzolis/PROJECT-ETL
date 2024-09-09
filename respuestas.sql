--1.
--¿Qué porcentaje de viajes por día fueron pagos? Sabiendo que los días hábiles
--los viajes son gratis hasta 35' de duración y los días no hábiles Sábados,
--domingos y feriados) son siempre pagos

SELECT
    fecha_origen_recorrido,
    SUM(CASE
            WHEN es_fin_de_semana OR duracion_recorrido > 35 THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*) AS porcentaje_pagado
FROM dwh.hechos_viajes as h_v
JOIN dwh.dim_tiempo as d_t ON h_v.fecha_origen_recorrido = d_t.fecha
GROUP BY fecha_origen_recorrido;

--Esta es la posible solucion pero no estoy seguro si esta bien, ya que me retorna muchos valores


--2.
--¿Cuál es la edad promedio de las personas que realizaron al menos un viaje
--durante abril de 2024?
SELECT AVG(edad_usuario) AS edad_promedio
FROM dwh.dim_usuarios
WHERE id_usuario IN (
    SELECT DISTINCT id_usuario
    FROM dwh.hechos_viajes
    WHERE fecha_origen_recorrido BETWEEN '2024-04-01' AND '2024-04-30'
);

--Respuesta: 32 años


--3.
--La estación en la que más viajes se iniciaron.
SELECT nombre, COUNT(*) AS cantidad_viajes
FROM dwh.dim_estaciones as d_e
JOIN dwh.hechos_viajes  as h_v ON d_e.id_estacion = h_v.id_estacion_origen
GROUP BY nombre
ORDER BY cantidad_viajes DESC
LIMIT 1;


--Resíesta: PLAZA MACKENNA CON 46922 VIAJES

--4.
--La estación en la que más viajes finalizaron
SELECT nombre, COUNT(*) AS cantidad_viajes
FROM dwh.dim_estaciones as d_e
JOIN dwh.hechos_viajes as h_v ON d_e.id_estacion = h_v.id_estacion_destino
GROUP BY nombre
ORDER BY cantidad_viajes DESC
LIMIT 1;

--Respuesta: PLAZA MACKENNA CON 41114 VIAJES

--5.
-- La combinación de origen y destino más frecuente para cada mes.
WITH frecuencias AS (
    SELECT 
        d_t.mes, 
        h_v.id_estacion_origen, 
        h_v.id_estacion_destino, 
        COUNT(*) AS frecuencia,
        ROW_NUMBER() OVER (PARTITION BY d_t.mes ORDER BY COUNT(*) DESC) AS rn
    FROM hechos_viajes AS h_v
    JOIN dim_tiempo AS d_t ON h_v.fecha_origen_recorrido = d_t.fecha
    GROUP BY d_t.mes, h_v.id_estacion_origen, h_v.id_estacion_destino
)
SELECT 
    mes, 
    id_estacion_origen, 
    id_estacion_destino, 
    frecuencia
FROM frecuencias
WHERE rn = 1
ORDER BY mes;

--La respuesta está subida en formato csv en el archivo respuesta5.csv

--6.
--El promedio de tiempo de viaje para días hábiles y no hábiles.
SELECT es_fin_de_semana, AVG(duracion_recorrido) AS promedio_duracion
FROM dwh.hechos_viajes as h_v
JOIN dwh.dim_tiempo    as d_t ON h_v.fecha_origen_recorrido = d_t.fecha
GROUP BY es_fin_de_semana;

--Respuesta:
-- es_fin_de_semana|promedio_duracion
-- 0               |341.80   
-- 1               |209.35      

--7.
--Porcentaje de viajes por género según las horas del día.
WITH hora_genero AS (
    SELECT
        strftime('%H', fecha_origen_recorrido) AS hora,
        genero,
        COUNT(*) AS cantidad_viajes
    FROM dwh.hechos_viajes
    GROUP BY hora, genero
)
SELECT
    hora,
    genero,
    (cantidad_viajes * 100.0 / SUM(cantidad_viajes) OVER (PARTITION BY hora)) AS porcentaje_viajes
FROM hora_genero;

--La respuesta está subida en formato csv en el archivo respuesta7.csv