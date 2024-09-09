-- dim_estaciones
CREATE TABLE dwh.dim_estaciones (
	"id_estacion"	INTEGER,
	"nombre"	TEXT,
	"direccion"	TEXT,
	"barrio"	TEXT,
	"comuna"	TEXT,
	"emplazamiento"	TEXT,
	"latitud"	REAL,
	"longitud"	REAL,
	PRIMARY KEY("id_estacion")
);


--dim_tiempo 
CREATE TABLE dwh.dim_tiempo (
	"fecha"	TEXT,
	"dia"	INTEGER,
	"mes"	INTEGER,
	"anio"	INTEGER,
	"dia_semana"	TEXT,
	"es_fin_de_semana"	BOOLEAN,
	PRIMARY KEY("fecha")
);

--dim_usuario
CREATE TABLE dwh.dim_usuarios (
	"id_usuario"	INTEGER,
	"genero_usuario"	TEXT,
	"edad_usuario"	INTEGER,
	"fecha_alta"	TEXT,
	"hora_alta"	TEXT,
	PRIMARY KEY("id_usuario")
);

--hechos_recorridos
CREATE TABLE dwh.hechos_viajes (
	"id_recorrido"	TEXT,
	"duracion_recorrido"	TEXT,
	"fecha_origen_recorrido"	TEXT,
	"fecha_destino_recorrido"	TEXT,
	"id_estacion_origen"	INTEGER,
	"id_estacion_destino"	INTEGER,
	"id_usuario"	INTEGER,
	"modelo_bicicleta"	TEXT,
	"genero"	TEXT,
	PRIMARY KEY("id_recorrido"),
	FOREIGN KEY("fecha_destino_recorrido") REFERENCES "dim_tiempo"("fecha"),
	FOREIGN KEY("fecha_origen_recorrido") REFERENCES "dim_tiempo"("fecha"),
	FOREIGN KEY("id_estacion_destino") REFERENCES "dim_estaciones"("id_estacion"),
	FOREIGN KEY("id_estacion_origen") REFERENCES "dim_estaciones"("id_estacion"),
	FOREIGN KEY("id_usuario") REFERENCES "dim_usuarios"("id_usuario")
);