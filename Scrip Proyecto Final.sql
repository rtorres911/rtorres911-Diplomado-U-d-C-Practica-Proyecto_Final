CREATE TABLE delitos_municipales (
    anio INTEGER,
    clave_ent INTEGER,
    entidad VARCHAR(100),
    cve_municipio INTEGER,
    municipio VARCHAR(100),
    bien_juridico_afectado VARCHAR(255),
    tipo_delito VARCHAR(255),
    subtipo_delito VARCHAR(255),
    modalidad VARCHAR(255),
    enero INTEGER,
    febrero INTEGER,
    marzo INTEGER,
    abril INTEGER,
    mayo INTEGER,
    junio INTEGER,
    julio INTEGER,
    agosto INTEGER,
    septiembre INTEGER,
    octubre INTEGER,
    noviembre INTEGER,
    diciembre INTEGER
);

CREATE TABLE poblacion_estados (
    entidad VARCHAR(100),
    poblacion INTEGER
);

-- Insertar los datos de población
INSERT INTO poblacion_estados (entidad, poblacion) VALUES
('Aguascalientes', 1466309),
('Baja California', 3769020),
('Baja California Sur', 798447),
('Campeche', 971377),
('Chiapas', 5730753),
('Chihuahua', 3891362),
('Ciudad de México', 9209944),
('Coahuila', 3165747),
('Colima', 731391),
('Durango', 1832650),
('Estado de México', 17924583),
('Guanajuato', 6228175),
('Guerrero', 3635584),
('Hidalgo', 3253513),
('Jalisco', 8448804),
('Michoacán', 4960073),
('Morelos', 2098843),
('Nayarit', 1316756),
('Nuevo León', 5784442),
('Oaxaca', 4145325),
('Puebla', 6583278),
('Querétaro', 2368145),
('Quintana Roo', 1969957),
('San Luis Potosí', 2972325),
('Sinaloa', 3026943),
('Sonora', 3176776),
('Tabasco', 2395272),
('Tamaulipas', 3652613),
('Tlaxcala', 1447833),
('Veracruz', 8453267),
('Yucatán', 2485330),
('Zacatecas', 1666426);

-- Revision de Estados (Delitos)
SELECT DISTINCT entidad
FROM delitos_municipales
ORDER BY entidad;

-- Revision de Estados (Poblacion)
SELECT DISTINCT entidad
FROM poblacion_estados
ORDER BY entidad;

-- Cambiar "Estado de México" a "México"  (Hubo diferencias en los nombres, aqui esta la correccion)
UPDATE poblacion_estados
SET entidad = 'México'
WHERE entidad = 'Estado de México';

-- Cambiar "Michoacán" a "Michoacán de Ocampo"
UPDATE poblacion_estados
SET entidad = 'Michoacán de Ocampo'
WHERE entidad = 'Michoacán';

-- Cambiar "Veracruz" a "Veracruz de Ignacio de la Llave"
UPDATE poblacion_estados
SET entidad = 'Veracruz de Ignacio de la Llave'
WHERE entidad = 'Veracruz';

-- Cambiar "Coahuila" a "Coahuila de Zaragoza"
UPDATE poblacion_estados
SET entidad = 'Coahuila de Zaragoza'
WHERE entidad = 'Coahuila';



-- Inspeccion de valores Nulos (LIMPIEZA)
SELECT *
FROM delitos_municipales
WHERE enero IS NULL OR febrero IS NULL OR marzo IS NULL OR abril IS NULL OR mayo IS NULL 
OR junio IS NULL OR julio IS NULL OR agosto IS NULL OR septiembre IS NULL OR octubre IS NULL
OR noviembre IS NULL OR diciembre IS NULL;


-- Conversion de valores nulos a 0 (LIMPIEZA)
UPDATE delitos_municipales
SET enero = COALESCE(enero, 0),
    febrero = COALESCE(febrero, 0),
    marzo = COALESCE(marzo, 0),
    abril = COALESCE(abril, 0),
    mayo = COALESCE(mayo, 0),
    junio = COALESCE(junio, 0),
    julio = COALESCE(julio, 0),
    agosto = COALESCE(agosto, 0),
    septiembre = COALESCE(septiembre, 0),
    octubre = COALESCE(octubre, 0),
    noviembre = COALESCE(noviembre, 0),
    diciembre = COALESCE(diciembre, 0);

-- Tipos de bienes juridicos afectados (7)
SELECT DISTINCT bien_juridico_afectado
FROM delitos_municipales;

-- Tipos de Delitos (40)
SELECT DISTINCT tipo_delito
FROM delitos_municipales;

-- Municipios (2334)
SELECT DISTINCT municipio
FROM delitos_municipales;

-- Estados (32)
SELECT DISTINCT entidad
FROM delitos_municipales;



SELECT *
FROM delitos_municipales;

SELECT 
    (SELECT COUNT(*) FROM delitos_municipales) * 
    (SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'delitos_municipales') 
    AS total_celdas_delitos;



SELECT *
FROM poblacion_estados;


SELECT 
    (SELECT COUNT(*) FROM poblacion_estados) * 
    (SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'poblacion_estados') 
    AS total_celdas_poblacion;



/* Años mas violentos (Exceptuando el año en curso o el confinamiento del COVID, cada año consecutivo suele aumentar mas la cantidad de delitos
   Por lo tanto EL MAS VIOLENTO ES EL 2023 Y EL QUE MENOS 2015 */
SELECT 
    anio, 
    SUM(enero + febrero + marzo + abril + mayo + junio + julio + agosto + septiembre + octubre + noviembre + diciembre) AS total_delitos
FROM delitos_municipales
GROUP BY anio
ORDER BY total_delitos DESC;

/* Estados con mas delitos (Los 5 estados mas violentos son: Mexico, Ciudad de Mexico, Jalisco, Guanajuato y Baja California)
   Los 5 estados que menos delitos tienen son: Tlaxcala, Nayarit, Campeche, Yucatan y Chiapas */
SELECT 
    entidad, 
    SUM(enero + febrero + marzo + abril + mayo + junio + julio + agosto + septiembre + octubre + noviembre + diciembre) AS total_delitos
FROM delitos_municipales
GROUP BY entidad
ORDER BY total_delitos DESC;

-- Proporción de delitos por entidad
SELECT 
    entidad,
    ROUND(
        SUM(enero + febrero + marzo + abril + mayo + junio + julio + agosto + septiembre + octubre + noviembre + diciembre) * 100.0 / (
            SELECT SUM(enero + febrero + marzo + abril + mayo + junio + julio + agosto + septiembre + octubre + noviembre + diciembre)
            FROM delitos_municipales
        ), 2
    ) AS porcentaje_total_delitos
FROM delitos_municipales
GROUP BY entidad
ORDER BY porcentaje_total_delitos DESC;

-- Cálculo de la media de delitos por entidad en 2023
SELECT 
    AVG(total_delitos) AS media_delitos_2023
FROM (
    SELECT 
        entidad, 
        SUM(enero + febrero + marzo + abril + mayo + junio + julio + agosto + septiembre + octubre + noviembre + diciembre) AS total_delitos
    FROM delitos_municipales
    WHERE anio = 2023  -- Filtra solo los datos del año 2023
    GROUP BY entidad
) AS subquery;


-- Cálculo de la mediana de delitos por entidad en 2023
SELECT 
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY total_delitos) AS mediana_delitos_2023
FROM (
    SELECT 
        entidad, 
        SUM(enero + febrero + marzo + abril + mayo + junio + julio + agosto + septiembre + octubre + noviembre + diciembre) AS total_delitos
    FROM delitos_municipales
    WHERE anio = 2023  -- Filtra solo los datos del año 2023
    GROUP BY entidad
) AS subquery;



/* Municipios con mas delitos (Los cinco municipios mas violentos son: Tijuana, Ecatepec de Morelos, Guadalajara, Leon y Juarez en ese orden)
   Municipios con menos delitos (EXISTEN 4 MUNICIPIOS SIN REPORTES DE DELITOS EN NINGUN AÑO; "Honduras de la Sierra", "Nuu Savi", "Las Vigas" y "La Pe") */
SELECT 
    municipio, 
    SUM(enero + febrero + marzo + abril + mayo + junio + julio + agosto + septiembre + octubre + noviembre + diciembre) AS total_delitos
FROM delitos_municipales
GROUP BY municipio
ORDER BY total_delitos DESC
LIMIT 20;

-- Municipios con mas delitos porcentuales
SELECT 
    municipio, 
    ROUND(
        SUM(enero + febrero + marzo + abril + mayo + junio + julio + agosto + septiembre + octubre + noviembre + diciembre) * 100.0 / (
            SELECT SUM(enero + febrero + marzo + abril + mayo + junio + julio + agosto + septiembre + octubre + noviembre + diciembre)
            FROM delitos_municipales
        ), 2
    ) AS porcentaje_total_delitos
FROM delitos_municipales
GROUP BY municipio
ORDER BY porcentaje_total_delitos DESC;

-- Cálculo de la media de delitos por municipio
SELECT 
    AVG(total_delitos) AS media_delitos
FROM (
    SELECT 
        municipio, 
        SUM(enero + febrero + marzo + abril + mayo + junio + julio + agosto + septiembre + octubre + noviembre + diciembre) AS total_delitos
    FROM delitos_municipales
    GROUP BY municipio
) AS subquery;


-- Cálculo de la mediana de delitos por municipio
SELECT 
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY total_delitos) AS mediana_delitos
FROM (
    SELECT 
        municipio, 
        SUM(enero + febrero + marzo + abril + mayo + junio + julio + agosto + septiembre + octubre + noviembre + diciembre) AS total_delitos
    FROM delitos_municipales
    GROUP BY municipio
) AS subquery;




/* Delitos mas comunes (El Delito mas comun es el robo, triplicando la cantidad del segundo mas frecuente; la violencia familiar o el tercero; lesiones)
   Drasticamente el DELITO que MENOS INCIDENCIAS tiene es el INCESTO, seguido por el Trafico de menores */
SELECT 
    tipo_delito, 
    SUM(enero + febrero + marzo + abril + mayo + junio + julio + agosto + septiembre + octubre + noviembre + diciembre) AS total_delitos
FROM delitos_municipales
GROUP BY tipo_delito
ORDER BY total_delitos DESC;

-- Proporción de delitos por tipo (Porcentaje de los tipos de delito mas comunes)
SELECT 
    tipo_delito,
    SUM(enero + febrero + marzo + abril + mayo + junio + julio + agosto + septiembre + octubre + noviembre + diciembre) * 100.0 / (
        SELECT SUM(enero + febrero + marzo + abril + mayo + junio + julio + agosto + septiembre + octubre + noviembre + diciembre)
        FROM delitos_municipales
    ) AS porcentaje_total_delitos
FROM delitos_municipales
GROUP BY tipo_delito
ORDER BY porcentaje_total_delitos DESC;


/* Meses con mas delitos en general (MARZO es el mes mas violento y le siguen Mayo y Agosto)
   Los que menos son: Diciembre, Noviembre y Septiembre */
SELECT 
    'Enero' AS mes, SUM(enero) AS total_delitos FROM delitos_municipales
UNION
SELECT 
    'Febrero' AS mes, SUM(febrero) AS total_delitos FROM delitos_municipales
UNION
SELECT 
    'Marzo' AS mes, SUM(marzo) AS total_delitos FROM delitos_municipales
UNION
SELECT 
    'Abril' AS mes, SUM(abril) AS total_delitos FROM delitos_municipales
UNION
SELECT 
    'Mayo' AS mes, SUM(mayo) AS total_delitos FROM delitos_municipales
UNION
SELECT 
    'Junio' AS mes, SUM(junio) AS total_delitos FROM delitos_municipales
UNION
SELECT 
    'Julio' AS mes, SUM(julio) AS total_delitos FROM delitos_municipales
UNION
SELECT 
    'Agosto' AS mes, SUM(agosto) AS total_delitos FROM delitos_municipales
UNION
SELECT 
    'Septiembre' AS mes, SUM(septiembre) AS total_delitos FROM delitos_municipales
UNION
SELECT 
    'Octubre' AS mes, SUM(octubre) AS total_delitos FROM delitos_municipales
UNION
SELECT 
    'Noviembre' AS mes, SUM(noviembre) AS total_delitos FROM delitos_municipales
UNION
SELECT 
    'Diciembre' AS mes, SUM(diciembre) AS total_delitos FROM delitos_municipales
ORDER BY total_delitos DESC;

-- Cálculo de la tasa de delitos por cada 100,000 habitantes a nivel nacional por año
SELECT 
    dm.anio,
    SUM(enero + febrero + marzo + abril + mayo + junio + julio + agosto + septiembre + octubre + noviembre + diciembre) AS total_delitos_anual,
    (SUM(enero + febrero + marzo + abril + mayo + junio + julio + agosto + septiembre + octubre + noviembre + diciembre) * 100000.0) / (
        SELECT SUM(poblacion) FROM poblacion_estados
    ) AS tasa_delitos_por_100k_anual
FROM delitos_municipales dm
GROUP BY dm.anio
ORDER BY dm.anio ASC;

/* Cálculo de la tasa de delitos por cada 100,000 habitantes por estado
   Los cinco estados con las tasas más altas de delitos por cada 100,000 habitantes son
   COLIMA, Baja California, Baja California Sur, Aguascalientes y Ciudad de México.
   Los cinco estados con las tasas más bajas de delitos por cada 100,000 habitantes son 
   Chiapas, Tlaxcala, Nayarit, Yucatán y Guerrero.
        */
SELECT 
    dm.entidad,
    SUM(enero + febrero + marzo + abril + mayo + junio + julio + agosto + septiembre + octubre + noviembre + diciembre) AS total_delitos,
    p.poblacion,
    (SUM(enero + febrero + marzo + abril + mayo + junio + julio + agosto + septiembre + octubre + noviembre + diciembre) * 100000.0) / p.poblacion AS tasa_delitos_por_100k
FROM delitos_municipales dm
JOIN poblacion_estados p ON dm.entidad = p.entidad
GROUP BY dm.entidad, p.poblacion
ORDER BY tasa_delitos_por_100k DESC;


-- Cálculo de la tasa promedio anual de delitos por cada 100,000 habitantes en el 2023
SELECT 
    dm.entidad,
    COUNT(DISTINCT dm.anio) AS num_anios,
    SUM(enero + febrero + marzo + abril + mayo + junio + julio + agosto + septiembre + octubre + noviembre + diciembre) AS total_delitos,
    p.poblacion,
    ROUND(
        (SUM(enero + febrero + marzo + abril + mayo + junio + julio + agosto + septiembre + octubre + noviembre + diciembre) * 100000.0) / (p.poblacion * COUNT(DISTINCT dm.anio)), 
        2
    ) AS tasa_promedio_anual_por_100k
FROM delitos_municipales dm
JOIN poblacion_estados p ON dm.entidad = p.entidad
WHERE dm.anio IN (2023)
GROUP BY dm.entidad, p.poblacion
ORDER BY tasa_promedio_anual_por_100k DESC;


-- Cálculo de incremento delictivo porcentual
WITH delitos_por_anio AS (
    SELECT 
        anio,
        SUM(enero + febrero + marzo + abril + mayo + junio + julio + agosto + septiembre + octubre + noviembre + diciembre) AS total_delitos
    FROM delitos_municipales
    GROUP BY anio
    ORDER BY anio
)

SELECT 
    anio,
    total_delitos,
    LAG(total_delitos) OVER (ORDER BY anio) AS delitos_anio_anterior,
    CASE
        WHEN LAG(total_delitos) OVER (ORDER BY anio) IS NULL THEN 0  -- Crecimiento 0% en el primer año (2015)
        ELSE ROUND((total_delitos - LAG(total_delitos) OVER (ORDER BY anio)) * 100.0 / LAG(total_delitos) OVER (ORDER BY anio), 2)
    END AS porcentaje_crecimiento
FROM delitos_por_anio;


-- Promedio de crecimiento delictivo en el mandato de AMLO
WITH delitos_por_anio AS (
    SELECT 
        anio,
        SUM(enero + febrero + marzo + abril + mayo + junio + julio + agosto + septiembre + octubre + noviembre + diciembre) AS total_delitos
    FROM delitos_municipales
    WHERE anio BETWEEN 2018 AND 2023  -- Incluimos 2018 para obtener el valor del año anterior
    GROUP BY anio
    ORDER BY anio
)

SELECT 
    ROUND(AVG(porcentaje_crecimiento), 2) AS promedio_porcentaje_crecimiento
FROM (
    SELECT 
        anio,
        total_delitos,
        LAG(total_delitos) OVER (ORDER BY anio) AS delitos_anio_anterior,
        CASE
            WHEN LAG(total_delitos) OVER (ORDER BY anio) IS NULL THEN 0  -- Crecimiento 0% para el primer año del rango (2018)
            ELSE (total_delitos - LAG(total_delitos) OVER (ORDER BY anio)) * 100.0 / LAG(total_delitos) OVER (ORDER BY anio)
        END AS porcentaje_crecimiento
    FROM delitos_por_anio
) AS subquery
WHERE anio BETWEEN 2019 AND 2023;  -- Filtrar solo los años de interés (2019-2023)

-- Codigo
WITH delitos_por_anio AS (
    SELECT 
        anio,
        SUM(enero + febrero + marzo + abril + mayo + junio + julio + agosto + septiembre + octubre + noviembre + diciembre) AS total_delitos
    FROM delitos_municipales
    WHERE anio BETWEEN 2015 AND 2024  -- Cambia este rango según lo que desees analizar
    GROUP BY anio
    ORDER BY anio
)

SELECT 
    anio,
    total_delitos,
    LAG(total_delitos) OVER (ORDER BY anio) AS delitos_anio_anterior,
    CASE
        WHEN LAG(total_delitos) OVER (ORDER BY anio) IS NULL THEN 0
        ELSE ROUND((total_delitos - LAG(total_delitos) OVER (ORDER BY anio)) * 100.0 / LAG(total_delitos) OVER (ORDER BY anio), 2)
    END AS porcentaje_crecimiento
INTO TEMP tabla_crecimiento
FROM delitos_por_anio;

-- Cálculo del promedio del crecimiento en el rango de años seleccionado
SELECT 
    ROUND(AVG(porcentaje_crecimiento), 2) AS promedio_crecimiento
FROM tabla_crecimiento
WHERE anio BETWEEN 2019 AND 2023;  -- Cambia este rango según lo que desees analizar

-- Porcentaje de aumento delictivo 2019-2023 (AMLO)
SELECT 
    ROUND(
        (SUM(CASE WHEN anio = 2023 THEN 
            (enero + febrero + marzo + abril + mayo + junio + julio + agosto + septiembre + octubre + noviembre + diciembre)
        ELSE 0 END) - 
        SUM(CASE WHEN anio = 2019 THEN 
            (enero + febrero + marzo + abril + mayo + junio + julio + agosto + septiembre + octubre + noviembre + diciembre)
        ELSE 0 END)) * 100.0 / 
        SUM(CASE WHEN anio = 2019 THEN 
            (enero + febrero + marzo + abril + mayo + junio + julio + agosto + septiembre + octubre + noviembre + diciembre)
        ELSE 0 END), 2
    ) AS porcentaje_aumento_2019_2023
FROM delitos_municipales
WHERE anio IN (2019, 2023);

-- Diferencia en delitos entre el año 2019 y 2023
SELECT 
    (SUM(CASE WHEN anio = 2023 THEN 
        (enero + febrero + marzo + abril + mayo + junio + julio + agosto + septiembre + octubre + noviembre + diciembre)
    ELSE 0 END) - 
    SUM(CASE WHEN anio = 2019 THEN 
        (enero + febrero + marzo + abril + mayo + junio + julio + agosto + septiembre + octubre + noviembre + diciembre)
    ELSE 0 END)) AS diferencia_delitos_2019_2023
FROM delitos_municipales
WHERE anio IN (2019, 2023);



