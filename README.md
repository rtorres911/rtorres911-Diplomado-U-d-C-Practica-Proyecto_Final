# ANÁLISIS SOBRE LA INCIDENCIA DELICTIVA EN LOS ESTADOS DE LA REPÚBLICA MEXICANA
En este repositorio se encuentra todo el desarrollo del proyecto final del diplomado en Análisis de Datos.

Los integrantes del grupo son: 

**JAVIER ISMAEL SAMPABLO CUEVAS**

**RIGOBERTO TORRES CISNEROS**

**ANA ISABEL HERNÁNDEZ DÍAZ**

**FELIPE DE JESÚS ARREOLA GARCÍA**

**MARIANNE ELVIRA HERNÁNDEZ HERNÁNDEZ**

**DELIA PAULINA GUTIÉRREZ ZAMORA**




## 1 SELECCIÓN Y JUSTIFICACIÓN DE LA BASE DE DATOS
Actualmente nos encontramos ante una crisis de inseguridad que afecta a toda la república mexicana generando una percepción colectiva de un aumento de violencia que nos impacta al momento de transitar con tranquilidad por los espacios públicos. Cuando hablamos de inseguridad y violencia nos referimos a diversas acciones que se clasifican en tipos y subtipos de delitos que al ser cometidos dejan una afectación o daño a derechos personales y derechos colectivos, a los cuales se les conoce por el concepto de bien jurídico, pues representan un valor protegido por el orden jurídico. Con el objetivo de conocer con mayor detalle los tipos de delitos cometidos en todas las entidades del país, se seleccionó una base de datos proporcionada por el Secretariado Ejecutivo del Sistema Nacional de Seguridad Pública que proporciona una clasificación de delitos cometidos por estado desde el año 2015 al 2024, así mismo nos aporta datos sobre los bienes jurídicos afectados en cada delito. Con lo anterior se pretende desarrollar un análisis exploratorio para resolver interrogantes como cuál es el estado con mayor incidencia delictiva o conocer cuál es el tipo de delito más frecuente en cada entidad, ente otras cuestiones de interés colectivo.

![Captura de pantalla 2024-10-05 132420](https://github.com/user-attachments/assets/0e3961d1-7884-4b91-a116-e75684a0dce6)

## 2 PREPARACIÓN Y LIMPIEZA DE LOS DATOS

  ### 2.1 Descripción de la Base de Datos.
  **2.1.1 Número de registros y variables/campos:**
  
  La base de datos está conformada por un total de 5 tablas, de las cuales, hay dos tablas importantes, que son las que tienen la información general sobre los delitos, en las que tenemos la tabla que tiene    el   dato por entidad, la cual tiene 31,360 registros, y otra tabla con el dato por municipio, la cual tiene 2,319,072 registros.
	Estas dos tablas están conformadas por cerca de 20 columnas cada una, en las que tenemos información sobre los delitos, subtipos de delito, el bien jurídico afectado, la modalidad, es decir, la forma específica   en que el delito fue cometido, la entidad o municipio, la clave de dicha entidad, y el año en que se cometieron los delitos, los 12 restantes campos corresponden a los 12 meses del año.

  **2.1.2 Tipos de datos:**    

  Los datos presentados son numéricos, pues son la representación de las cifras de los delitos cometidos. Sin embargo, también son categóricos, ya que al existir distintos tipos de delitos, estos se dividen en      subtipos para una mejor exposición del tema. Además, se utilizan fechas para ubicar la temporalidad en que fueron realizados, empleando un rango de tiempo desde 2015 a 2024.

  ![Captura de pantalla 2024-10-05 134023](https://github.com/user-attachments/assets/faf07019-99fe-41dc-9720-f60378bef1bc)

  ### 2.2 Limpieza de Datos. 
  **2.2.1 Identificación y manejo de valores faltantes:**

  Al manipular la base de datos, se pudo observar que era necesario añadir columnas de identificación (ID) para un mejor manejo de los datos, debido a que, el análisis está centrado en los 32 estados de la          República Mexicana junto con 7 categorías principales de delitos, dando un total de 20 columnas y 31,360 registros para las entidades, y 2,19,702 registros para la información por municipios.

  
  **2.2.2 Corrección de errores en los datos:**

  Los datos muestran coherencia entre sí y cada cifra es relevante con las otras, por lo que se optó por añadir los ID, y unas correcciones menores a los datos.
	Un cambio que se aplicó para las tablas, fue el corregir datos nulos a numéricos en los meses de incidencia, para esto primero analizamos la información y observamos que era un detalle a corregir.

  ![Captura de pantalla 2024-10-11 164131](https://github.com/user-attachments/assets/8ba1b0fc-6993-4b52-b6f6-0c67483819c3)

  Otro punto a corregir, fue la parte de completar información para los estados, o corregir los nombres de los mismos
  
![Captura de pantalla 2024-10-11 164245](https://github.com/user-attachments/assets/aab59e6d-4433-4379-8de6-0a680baee6a5)


  **2.2.3 Transformaciones necesarias**

  A cada estado y bien jurídico afectado se le asignó un ID, lo que nos permitió poder filtrar de forma más oportuna la información. Adicionalmente, la base de datos tuvo su origen en Excel, para ello,   se       
  añadieron pestañas para colocar el ID por identidad y por bien jurídico afectado. Por último, se añadió una columna que hace el recuento anual de las cifras, por lo que es posible conocer un total global por      año.


## 3 ANÁLISIS EXPLOTARIO DE DATOS

  ### 3.1.1 Análisis Descriptivo: 
  
  El empleo de SQL como software de análisis nos permite realizar distintas consultas al combinar tablas y categorías, lo que da como resultado una exploración variada y detallada, pues al existir más de 30 mil     registros la información es inmensa, por lo que de este modo se puede resumir y mostrar los datos más relevantes.

  **Tasa promedio del año 2023 por cada 100k habitantes.**
  Colima encabeza a las demás entidades en este sentido.
  
 ![Captura de pantalla 2024-10-11 164814](https://github.com/user-attachments/assets/43ba6b74-6478-4a80-9d32-51def35c115b)

  En los delitos separados por mes, existe un patrón dónde se reducen la cantidad de estos en los meses más festivos del año, en las fechas próximas a la navidad los meses anteriores y posteriores se denota una     baja en la incidencia delictiva.
  
![Captura de pantalla 2024-10-11 165049](https://github.com/user-attachments/assets/34c3038e-d1b9-49df-8687-e8ea36a37d52)

Los tipos de delito en representación porcentual son muy inconsistentes, más de la mitad de los tipos de delito (26) representan menos del 1% en la sumatoria de los delitos de todo el país. **El robo triplica la incidencia del segundo delito más común,** este sería el más grande problema que enfrenta la nación.
![Captura de pantalla 2024-10-11 165142](https://github.com/user-attachments/assets/efb7f377-de46-43cd-83db-fa2dc63213be)

**Representación porcentual de la incidencia delictiva de cada entidad.**

![Captura de pantalla 2024-10-11 165224](https://github.com/user-attachments/assets/0e80323d-1dd9-41ff-8e56-c2134ed09411)

**Análisis del sexenio de AMLO**

![WhatsApp Image 2024-10-12 at 12 43 27 PM](https://github.com/user-attachments/assets/0e20b654-5bdd-498b-a9b2-a02730cf2f1c)


**Cálculo de media delictiva por Entidad del año 2023.**

![Captura de pantalla 2024-10-11 165305](https://github.com/user-attachments/assets/f7906f32-faea-41db-909f-82e0fa917203)

**Cálculo de mediana delictiva por Entidad del año 2023.**
![Captura de pantalla 2024-10-11 165341](https://github.com/user-attachments/assets/9efb14d2-8b1f-44b1-bf37-0887d6a28a0c)

*Consultas:*
![Captura de pantalla 2024-10-11 165445](https://github.com/user-attachments/assets/119eb14a-afb5-48ff-b0b2-5854ac2ab173)

![Captura de pantalla 2024-10-11 165509](https://github.com/user-attachments/assets/8ba16766-a5cd-4a59-a65f-3ad43adfc9e7)

![Captura de pantalla 2024-10-11 165532](https://github.com/user-attachments/assets/dd2ad4a3-aba8-4e60-b54c-10ae731f0a41)

## 4 VISUALIZACIÓN DE DATOS 
  ### 4.1 Herramienta de visualización
  El software que se escogió fue Power BI. Esta decisión se tomó con base en la practicidad de la herramienta, además de poder visualizar de forma interactiva la exposición de los datos. Inicialmente, la base de   datos se manejó en Excel, por lo que al pertenecer al mismo grupo de sistemas, fue muy fácil poder trasladar y plasmar la información.


  ### 4.2 Principales visualizaciones
  
  Tomando el período 2015-2024, se observa que la Ciudad de México es la entidad con mayor incidencia delictiva, seguido de Jalisco y posteriormente Guanajuato.

![Captura de pantalla 2024-10-11 165645](https://github.com/user-attachments/assets/43d4f195-6715-40ed-884b-f8d454c8ca82)

Tomando el período 2015-2024, se visualiza que, la principal afectación jurídica recae en el patrimonio con un 48.72%, en segundo lugar están otros bienes jurídicos (del fuero común) con un 20.94%, y en tercer lugar la vida e integridad corporal con un 13.09%.
![Captura de pantalla 2024-10-11 165727](https://github.com/user-attachments/assets/b21367ef-3572-43c1-8e5c-5395e83cc442)

De forma más particular, se encuentra un apartado que analiza los datos por entidad, dentro de ella se engloban los delitos y el porcentaje correspondiente al año en que se cometieron.
![Captura de pantalla 2024-10-11 165802](https://github.com/user-attachments/assets/7f5469cf-f0f4-48a8-827e-56f82c4ef957)


## 5 INTERPRETACIÓN Y CONCLUSIONES
  ### 5.1 Resultados del Análisis 
  
  **5.1.1 Resumen de los hallazgos más importantes** 

  La incidencia delictiva presenta diferencias marcadas entre estados, siendo algunas regiones más vulnerables a la violencia y otros mostrando niveles más bajos de criminalidad, dicha criminalidad en México es    el resultado de una combinación de factores socioeconómicos, políticos y culturales. La alta incidencia delictiva afecta la percepción de seguridad y la calidad de vida de los ciudadanos, provocando miedo y      desplazamientos forzados en las áreas más vulneradas.

  **5.1.2 Interpretación de los resultados en el contexto del problema planteado**  

  Los datos muestran que ciertos estados enfrentan niveles alarmantes de violencia, lo que sugiere una desigualdad en el acceso a recursos, oportunidades y seguridad. Esto refuerza la idea de que las soluciones deben ser adaptadas a las realidades locales. La percepción de inseguridad afecta el bienestar de la población y puede tener repercusiones económicas, como la reducción del turismo y la inversión. Esto resalta la necesidad de políticas que no solo aborden la delincuencia, sino que también mejoren la confianza de la comunidad en las instituciones.

  ### 5.2 Conclusiones 
  **5.2.1 Conclusiones generales del proyecto**
  El análisis de datos desglosados por estado y tipo de delito revela patrones específicos que pueden guiar la formulación de políticas dirigidas y eficaces. Las estrategias deben ser personalizadas según las características delictivas de cada región.
El seguimiento de las tendencias en la incidencia delictiva a lo largo del tiempo permite identificar picos de criminalidad y evaluar la efectividad de las políticas implementadas. Esto es crucial para hacer ajustes oportunos en las estrategias de seguridad. La utilización de modelos predictivos basados en datos históricos puede ayudar a anticipar focos de criminalidad y permitir a las autoridades movilizar recursos de manera más eficiente en áreas de alto riesgo.
Evaluar el impacto de intervenciones pasadas a través de análisis de datos puede proporcionar información valiosa sobre qué estrategias han sido efectivas y cuáles no, permitiendo la mejora continua de las políticas de seguridad.
Los datos sugieren correlaciones significativas entre variables socioeconómicas y tasas de criminalidad, señalando que, mejorar indicadores como el ingreso, la educación y el empleo puede ser clave para reducir la delincuencia.

  **5.2.2 Recomendaciones basadas en los resultados obtenidos** 
  Realizar un análisis detallado y segmentado por estado y tipo de delito para identificar áreas críticas y desarrollar intervenciones específicas que aborden las particularidades de cada región.
Efectuar evaluaciones de impacto de las políticas y programas de seguridad a través del análisis de datos, identificando qué estrategias han sido más efectivas y cuáles requieren ajustes. Del mismo modo, invertir en tecnologías de información que faciliten la recopilación y análisis de datos en tiempo real, permitiendo una mejor gestión y respuesta ante situaciones de criminalidad.
Basar la formulación de políticas en evidencias derivadas del análisis de datos, garantizando que las decisiones se alineen con las necesidades reales y patrones delictivos identificados.

  
  **5.2.3 Posibles limitaciones del análisis y sugerencias para trabajos futuros**

La calidad y disponibilidad de datos pueden ser inconsistentes, lo que limita la precisión del análisis. Algunas regiones pueden tener registros incompletos o poco fiables; esto lo confirmamos en periodos donde hay registros en 0, o con datos muy bajos. 
Los datos pueden tener categorías faltantes que ayuden a detallar los reportes, donde detallando estas, ayudará a tener estadísticas más amplias, que aporten a la lectura de la información.
Las diferencias en la clasificación y registro de delitos entre estados pueden dificultar comparaciones precisas y la interpretación de datos, además, la subestimación de delitos denunciados puede llevar a una percepción errónea de la incidencia delictiva, afectando la validez de los resultados, por ejemplo no podemos tener datos precisos de los delitos desde que existe una importante cifra negra de delitos que nunca son denunciados, así mismo en cuanto a la clasificación, podemos ver que hay estados donde hay muy pocos feminicidios y sin embargo hay una significativa cifra de homicidios dolosos de mujeres, lo cual puede abrir la posibilidad de que algunos de esos homicidios no se están clasificando correctamente. 
Cómo recomendaciones se propone desarrollar un sistema estandarizado de recopilación y reporte de datos sobre criminalidad que facilite la comparación entre estados y asegure la calidad de la información así como combinar análisis cuantitativos con enfoques cualitativos, como entrevistas y encuestas a la comunidad, para obtener una perspectiva más amplia sobre la inseguridad y la criminalidad.

  
