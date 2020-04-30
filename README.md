# COVID-APP

## Introducción

Lo primero de todo me gustaría presentarnos para poner en contexto el origen de la idea y el proyecto expuestos a continuación.  
Somos dos estudiantes del CFGS de desarrollo de aplicaciones multiplataforma en la U-tad. Al ver que se había organizado este hackaton, pensamos que era una buena oportunidad para poner en practica nuestros conocimientos en el desarrollo de aplicaciones y nuestra pasión por la tecnología. Sobre todo esperamos poder ayudar en lo posible en esta situación tan delicada en la que nos encontramos.

## Problemas y soluciones

Hemos enfocado nuestro proyecto a los problemas que habrá en la fase de desescalada del confinamiento. Para concienciar a la población y evitar las aglomeraciones hemos desarrollado una aplicación móvil que permitirá al usuario ver la última información oficial sobre temas relacionados con la pandemia (contagios, fases de desescalada…). <br/> Por otro lado, hemos implementado un chatbot con el que se podrá interactuar de la forma más cercana y amigable posible para tratar temas ya sean informativos o de concienciación. <br/> Por último y más importante, hemos desarrollado una plataforma de reserva de entradas para eventos y lugares públicos para evitar aglomeraciones.<br/>  Se mostrará al usuario una lista con eventos y lugares públicos alos que puede asistir pero con acceso limitado y controlado por la Comunidad de Madrid para evitar aglomeraciones. Para ello, al reservar una entrada, se generará un código QR que servirá como identificador una vez se asista al evento/lugar. 

## Datos

Toda posible solución a la pandemia actual necesita un elemento indispensable, los datos. COVID-APP utiliza varias Apis y un servidor con una base de datos propia.   
  >Pantalla principal:
>>En ésta pantalla se muestra la información general actualizada de la pandemia. Los datos de los municipios se han sacado de [la web de Datos Abiertos de Madrid ](http://datos.comunidad.madrid/catalogo/dataset/covid19_tia_muni_y_distritos/resource/ead67556-7e7d-45ee-9ae5-68765e1ebf7a).
La información a nivel general de la Comunidad de Madrid se ha sacado de la Api de [DatosCovid](https://www.datoscovid.es/datasets/comunidadcovid::afectados-por-coronavirus-por-provincia-en-españa-completa/geoservice?geometry=-133.479%2C-6.347%2C119.646%2C48.204). Aunque nos hubiera gustado mostrar un mapa de Esri, por temas de tiempo y desconocimiento en el tema de mostrar información en mapas, hemos utilizado [una herramienta online](https://app.datawrapper.de) para mostrar los casos confirmados por Covid en la ciudad de Madrid.
>

>Pantalla de eventos:
>>En ésta pantalla se muestran los eventos que tendrán lugar en los próximos 100 días y han sido sacados de [la Api de Datos Abiertos de Madrid ](https://datos.madrid.es/portal/site/egob/menuitem.214413fe61bdd68a53318ba0a8a409a0/?vgnextoid=b07e0f7c5ff9e510VgnVCM1000008a4a900aRCRD&vgnextchannel=b07e0f7c5ff9e510VgnVCM1000008a4a900aRCRD&vgnextfmt=default).
Estos datos se han almacenado en una base de datos en Firebase (un servicio de Google que te permite subir tu base de datos a un servidor) para poder gesstionar el numero de entradas disponibles y la verificación de las mismas por código Qr.
>

## Sistema de códigos Qr

Hemos implemetado un sistema que permite al usuario reservar entradas para eventos. Al reservar, se genera una 'tarjeta' con un código Qr e información relevante sobre el evento(nombre, fecha...). Cuando el usuario asiste al evento, se escaneará su código Qr para comprobar si es correcto. Al escanearlo se hará una comprobación en la base de datos para comprobar dos cosas: si existe la referencia a la reserva que representa el código escaneado, y si ya se ha escaneado anteriormente para evitar fraudes a la hora de asistir al evento.  
Tambien pensamos en aquellas personas que no dispongan de la aplicación para poder reservar entradas. Para que no haya problemas de desigualdad de oportunidades, se pondrán a disposición de los usuarios de la aplicación la mitad de las entradas y la otra mitad se adquirirán por órden de llegada al evento o lugar.  
Este sistema puede ser implantado en otros ámbitos como limitar el acceso a sitios públicos (plazas, terrazas de bares, supermercados...) para tener un control de acceso y prevenir así aglomeraciones.  
Creemos que para los meses venideros de desescalada puede ser una gran herramienta que ayude a la Comunidad de Madrid a superar esta crisis. 


