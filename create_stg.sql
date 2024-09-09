--TRIPS
CREATE TABLE stg.trips (
	"Id_recorrido"	INTEGER,
	"duracion_recorrido"	TEXT,
	"fecha_origen_recorrido"	TEXT,
	"id_estacion_origen"	INTEGER,
	"nombre_estacion_origen"	TEXT,
	"direccion_estacion_origen"	TEXT,
	"long_estacion_origen"	REAL,
	"lat_estacion_origen"	REAL,
	"fecha_destino_recorrido"	TEXT,
	"id_estacion_destino"	INTEGER,
	"nombre_estacion_destino"	TEXT,
	"direccion_estacion_destino"	TEXT,
	"long_estacion_destino"	REAL,
	"lat_estacion_destino"	REAL,
	"id_usuario"	INTEGER,
	"modelo_bicicleta"	TEXT,
	"género"	TEXT
);

--USUARIOS
CREATE TABLE stg.usuarios_ecobici (
	"id_usuario"	INTEGER,
	"genero_usuario"	TEXT,
	"edad_usuario"	INTEGER,
	"fecha_alta"	TEXT,
	"hora_alta"	TEXT
);

--ESTACIONES
CREATE TABLE stg.nuevas_estaciones_bicicletas (
	"NÚMERO DE ESTACIÓN"	INTEGER,
	"NOMBRE"	TEXT,
	"DIRECCIÓN"	TEXT,
	"BARRIO"	TEXT,
	"COMUNA"	TEXT,
	"EMPLAZAMIENTO"	TEXT,
	"LATITUD"	REAL,
	"LONGITUD"	REAL
);

