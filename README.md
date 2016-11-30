# Taller: Aprendiendo a utilizar DRAGON V5 como código de producción de secciones eficaces.

**Reunión:** III Reunión Anual del Grupo Argentino de Cálculo y Análisis de Reactores.

**Fecha:** 17 de Noviembre de 2016.

**Ubicación:** Sede Central de la Comisión Nacional de Energía Atómica.

**Duración total:** 6 horas.

**Responsable:** Ramiro Vignolo.

## Resumen

DRAGON contiene una serie de modelos que permiten simular el comportamiento de los neutrones en una celda o elemento combustible de un reactor nuclear. Este código incluye las principales características de un código de celda: interpolación de secciones eficaces microscópicas obtenidas a partir de bibliotecas; cálculos de autoapantallamiento en geometrías multidimensionales; cálculos de flujo neutrónico multigrupo y multidimensional; homogeneización de propiedades nucleares para cálculos de núcleo y depleción isotópica. En este taller se aprenderá a utilizar el código de celda DRAGON en su quinta versión, atravesando las diferentes etapas que conforman una entrada genérica y realizando diferentes ejemplos que afiancen el entendimiento de cada una de ellas. Por último, se abordará tanto el uso de herramientas externas al programa y recomendadas por sus desarrolladores como así también por las personas a cargo del taller.

## Consideraciones generales

1. El directorio `taller-dragon-garcar-2016/` contiene las principales carpetas del taller, con las entradas de DRAGON y algunos *scripts* ordenados en 5 directorios numerados del `1.` al `5.`. El orden de numeración respeta el orden de los temas a abordar en el taller.

2. Se recomienda tener instalado GhostView para visualizar PostScripts y gnuplot para realizar gráficos en 2 y 3 dimensiones. Sin embargo, si usted cuenta con pyxplot, los gráficos 2D serán realizados con este programa en lugar de gnuplot.

3. Como editor de texto se recomienda el uso de Kate debido a que hemos escrito el [*syntax highlighting*](https://bitbucket.org/tenuc/dragon-xml) para DRAGON.

4. Es necesario tener instalado DRAGON globalmente y que pueda ser llamado a partir del comando `dragon`. Puede descargarlo desde el servidor [Merlin](http://www.polymtl.ca/merlin/version5.htm).

5. En la sección de descargas se encuentran unas filminas que puede utilizar para acompañar la lectura del taller.

## Descripción de archivos

Los directorios numerados del `1.` al `5.` contienen la totalidad de la parte práctica del taller, que incluye las entradas de DRAGON y scripts. En el caso genérico, un directorio puede contener los siguientes archivos:

1. un archivo con extensión `.x2m` que corresponde al *input* de DRAGON.

2. uno o más archivos con extensión `.c2m` que corresponden a procedimientos de DRAGON.

3. `clean.sh` limpia la información obtenida luego de la ejecución de una entrada (tenga presente que puede modificar a su gusto este script).

4. un *script* llamado `run.sh` que se encarga de ejecutar adecuadamente la entrada de DRAGON. Además, si se da la opción `-g`, imprimirá las salidas PostScript en GhostView. Por otro lado, si es necesario, llamará a otros *scripts* que se detallan a continuación.

5. `xs-plot.sh` realiza gráficos de las secciones eficaces en gnuplot o pyxplot y en 2 y 3 dimensiones según cual sea el caso.

6. `compile.sh` compila las rutinas escritas en C con el uso de bibliotecas GanLib.


Luego de la ejecución del *script* `run.sh` en cada uno de los directorios, en el caso más general se obtendrán archivos del siguiente tipo:

1. el archivo con extensión `.result` posee la salida de DRAGON.

2. los archivos con extensión `.ps` poseen gráficos de las geometrías con la distribución de regiones, *mixtures* o flujo.

3. el archivo con extensión `.m` posee la información del *ray tracing* capaz de ser graficada en Matlab o octave.

4. `Database.dat` se corresponde al archivo generado por el módulo `COMPO:` de DRAGON y convertido a ASCII. Este archivo es la entrada de las rutinas de C que utilizan GanLib para extraer la información pertinente de una corrida.

5. los otros archivos con extensión `.dat` poseen la información de las secciones eficaces una vez procesado `Database.dat` con las rutinas de C.

## Descripción de directorios

Se explicarán brevemente y de forma individual cada directorio del
taller.

### `1.materials`

Este directorio contiene dos subdirectorios, `1.macroscopic` y `2.microscopic`, donde se especifica el formato de entrada para los módulos `MAC:` y `LIB:` respectivamente. Conviene prestar particular atención a, por ejemplo, el formato de las secciones eficaces de *scattering* y a los resultados de las corridas.

### `2.geometries-and-tracking`

En este directorio se encuentran entradas que describen geometrías de diferentes tipos, a las que se les pueden aplicar diferentes módulos de *ray tracing*. Es importante analizar cada una de las geometrías y comprender tanto la definición de materiales como condiciones de contorno. Una vez entendido cada uno de estos casos, proponer una geometría y tratar de realizarla.

### `3.flux-calculation`

Se propone el cálculo de flujo en una misma geometría pero definida de diferentes maneras. Comparar los resultados y comprender el uso de las nuevas herramientas de DRAGON, como los módulos `G2S:` y `SALT:`.

### `4.reference-burnup`

El quemado de referencia es, justamente, una corrida que efectúa la evolución isotópica. La salida de esta corrida son las secciones eficaces en función del quemado. Lo importante es entender tanto el algoritmo utilizado para quemar como las herramientas empleadas para recopilar la información.

### `5.local-perturbations`

Las perturbaciones locales toman al quemado de referencia y lo recorren perturbando localmente algún parámetro. Esto permite obtener las secciones eficaces en función del quemado y de una perturbación local. Al post procesar estos valores pueden obtenerse, por ejemplo, las derivadas de las secciones eficaces respecto al parámetro local y en función del quemado.