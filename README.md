Dejo asentado el link a los dos dataset faltantes:
  
  -https://drive.google.com/file/d/1bdeKnUbDx_QvUaaiGW3qxt190QzZtjXO/view?usp=sharing  

  -https://drive.google.com/file/d/1-nFXQ_5P10Wn92LCaXb9_PY8r7_4tqsR/view?usp=sharing


1.Análisis Inicial de los Archivos CSV: 													

  -Realicé una revisión preliminar de los archivos CSV para entender su estructura y contenido.

2.Identificación de Problemas Potenciales:

  -Determiné las posibles problemáticas que podrían surgir en base a los datos de cada CSV, como valores nulos, duplicados y tipos de datos inconsistentes.

3.Definición del Modelo de Datos:

  -Basado en mi experiencia previa con Python (usando pandas) y la versatilidad de SQLite3 para la ingesta de datos, definí un modelo de datos adecuado.

4.Objetivos en la Exploración de Datos:

  -Revisar la cantidad de registros en cada CSV.

  -Entender los tipos de registros presentes en cada CSV.

  -Analizar y resolver registros nulos.
  
  -Analizar y resolver registros duplicados.

5.Arquitectura de la Base de Datos:

  -Planteé una base de datos staging para almacenar los datos limpios provenientes de los scripts.
  
  -Posteriormente, realicé la ingesta final de datos en la base de datos Data Warehouse (DWH).

6.Diseño del Data Warehouse:

  -Diseñé el DWH siguiendo un modelo estrella, con tres tablas dimensionales y una tabla de hechos, de acuerdo a los requerimientos.

7.Demostración en base a querys:
  
  -Finalmente, resolví algunas querys para determinar mi resultado
