# Grupo-04-DNS_as_Service
Repositorio del Grupo 4 del proyecto final de Prácticas de especialización, Configuración de Azure DNS
Elaborado por:

      •	Oscar Danilo Hernández Reyes  
      •	Julio Alexander Sanchez Ortiz
      •	Rodolfo José Hernández López
      •	David Salvador Cortez Flores
      •	Kenny Neftalí Gonzáles Escoto
      •	Said Emilio Jarquín Espino 

***Introduccion***
El aprovisionamiento de Azure DNS-as-a-Service brinda a las organizaciones una solución eficiente y escalable para administrar zonas de dominio privado en la nube de Azure. Este documento técnico lo guía a través de los pasos necesarios para configurar Azure DNS, desde la creación de zonas de dominio privado hasta la implementación de máquinas virtuales que usan esas zonas. Además, se describirá la finalidad del informe y se analizarán los resultados obtenidos.

*Objetivos General*
•	Crear una zona de dominio privado para el dominio DNS de Azure "mydomain.net"
*Objetivos específicos* 
•	Agregar dos máquinas virtuales (VM) a una zona de dominio privado mediante la resolución de DNS proporcionada por Azure DNS.
•	Verificar que la resolución DNS del nombre de dominio configurado en el área de dominio privado sea correcta.

***Descripcion de algunos terminos***
DNS (Sistema de Nombres de Dominio) es una infraestructura distribuida y jerárquica que se utiliza en Internet y redes de computadoras para traducir nombres de dominio legibles para los humanos en direcciones IP numéricas que las computadoras pueden entender. Esencialmente, actúa como una guía telefónica que permite a las computadoras y dispositivos conectados a Internet encontrar y comunicarse entre sí utilizando nombres de dominio, como "google.com", en lugar de tener que recordar y utilizar direcciones IP numéricas complicadas, como "172.217.12.206".

Cuando un usuario ingresa un nombre de dominio en su navegador web o en cualquier aplicación de red, el sistema operativo o el dispositivo envía una solicitud de resolución de nombres al servidor DNS. El servidor DNS busca en su base de datos para encontrar la dirección IP asociada con el nombre de dominio solicitado y devuelve la dirección IP correspondiente a la computadora o dispositivo del usuario. Luego, la computadora o dispositivo utiliza esa dirección IP para establecer la conexión y acceder al recurso solicitado, como una página web o un servicio en línea.

El sistema DNS se basa en una estructura jerárquica de servidores distribuidos en todo el mundo. Los servidores DNS se organizan en zonas y se agrupan en niveles, cada uno de los cuales es responsable de una parte específica del espacio de nombres de dominio. Cuando un servidor DNS no puede resolver una solicitud, se comunica con otros servidores DNS en niveles superiores para obtener la información necesaria.

El DNS desempeña un papel fundamental en el funcionamiento de Internet y es esencial para facilitar la navegación web, la entrega de correos electrónicos y otras comunicaciones en línea. Gracias al sistema de nombres de dominio, los usuarios pueden acceder a recursos en Internet de manera fácil y rápida sin tener que preocuparse por las direcciones IP subyacentes y complicadas.

*DNS Privada*
Una DNS privada es una implementación de DNS que opera dentro de una red local o privada, como una red corporativa o una nube privada, y que proporciona servicios de resolución de nombres de dominio dentro de ese entorno restringido. A diferencia del DNS público, que funciona en Internet y está abierto al público en general, el DNS privada se utiliza exclusivamente dentro de una organización o red específica y no es accesible desde el exterior.

Las DNS privadas son beneficiosas para empresas y organizaciones que desean mantener el control total sobre la resolución de nombres en su red interna y garantizar que los nombres de dominio se resuelvan correctamente para los recursos y servicios dentro de la red. Algunas características clave de una DNS privada incluyen:

Resolución interna: La DNS privada resuelve los nombres de dominio específicos de la red interna en direcciones IP correspondientes. Esto permite que los dispositivos dentro de la red se comuniquen entre sí utilizando nombres de dominio legibles para los humanos, en lugar de direcciones IP numéricas.

Control y seguridad: Al operar una DNS privada, las organizaciones pueden controlar la información de nombres de dominio y las direcciones IP asociadas en su red interna. Esto proporciona un nivel adicional de seguridad, ya que pueden mantener registros de acceso y asegurarse de que solo los recursos autorizados sean accesibles dentro de la red.

Resolución de nombres locales: La DNS privada puede resolver nombres de dominio que no existen en el DNS público, como nombres de servidores internos o recursos locales que no están disponibles para el público externo.

Integración con servicios internos: La DNS privada permite la integración con otros servicios y sistemas internos de la organización, lo que facilita la administración y el acceso a recursos locales.

En resumen, una DNS privada es una solución de resolución de nombres de dominio específica para una red privada y brinda mayor control, seguridad y eficiencia en la comunicación entre dispositivos y servicios internos. Al utilizar una DNS privada, las organizaciones pueden optimizar el funcionamiento de su red interna y garantizar un acceso rápido y confiable a los recursos dentro de su entorno restringido.

*DNS en Azure*-
En Microsoft Azure, las zonas DNS (Domain Name System) son servicios que permiten a los usuarios administrar y resolver nombres de dominio para sus recursos alojados en la nube de Azure. Proporciona un mecanismo para asignar nombres legibles para los humanos a las direcciones IP numéricas de los recursos, lo que facilita la administración y el acceso a los servicios en la nube.

Características y aplicaciones de las zonas DNS en Microsoft Azure:

Gestión de nombres de dominio: Las zonas DNS de Azure permiten a los usuarios registrar y administrar sus nombres de dominio personalizados, lo que les permite asignar nombres significativos a sus recursos en lugar de utilizar direcciones IP numéricas.

Resolución de nombres en la nube: Con las zonas DNS de Azure configuradas adecuadamente, los recursos en la nube, como máquinas virtuales, servicios web, bases de datos y otros servicios, pueden ser accesibles a través de nombres de dominio en lugar de direcciones IP.

Zonas públicas y privadas: Azure DNS admite tanto zonas DNS públicas como privadas. Las zonas públicas se utilizan para recursos accesibles desde Internet, mientras que las zonas privadas se utilizan para la resolución interna de nombres dentro de una red virtual en Azure.

Integración con servicios de Azure: Las zonas DNS de Azure están estrechamente integradas con otros servicios de Azure, lo que facilita la asignación y administración de nombres de dominio para recursos como VM, Azure Web Apps, SQL Database, etc.

Alta disponibilidad y rendimiento: Las zonas DNS de Azure están diseñadas para ser altamente disponibles y ofrecen un rendimiento rápido y confiable para la resolución de nombres.

Integración con registros de actividad y análisis: Azure DNS proporciona registros de actividad y análisis para realizar un seguimiento del tráfico DNS, lo que ayuda en la supervisión, el diagnóstico y la solución de problemas.

Seguridad y control de acceso: Se pueden configurar reglas de control de acceso en las zonas DNS para garantizar que solo los usuarios autorizados puedan modificar los registros DNS.

Aplicaciones prácticas de las zonas DNS en Azure:

a. Asignación de nombres a sitios web: Permite asignar nombres de dominio personalizados a sitios web alojados en Azure Web Apps.

b. Acceso a aplicaciones y servicios: Facilita el acceso a aplicaciones y servicios en la nube mediante nombres legibles en lugar de direcciones IP.

c. Integración con Active Directory: Las zonas DNS privadas en Azure se pueden usar junto con Active Directory para la resolución de nombres dentro de una red virtual.

d. Gestión de correo electrónico: Permite configurar registros MX para el manejo de correo electrónico y el enrutamiento a través de proveedores de servicios de correo.

***Desarrollo***
1. Creación de la zona de dominio privada:
   - Se accedió al portal de Azure y se seleccionó el servicio Azure DNS.
   - Se creó una nueva zona de dominio privada con el nombre "mydominio.net". (registro de dominio ficticio a falta de uno gratuito)
   - Se configuraron las opciones adicionales según los requisitos del proyecto.

2. Agregar VMs a la zona de dominio privada:
   - Se seleccionaron las VMs existentes o se crearon nuevas VMs.
   - Para cada VM, se configuró la configuración de red para utilizar la zona de dominio privada creada en el paso anterior.

3. Comprobación de la resolución DNS:
   - Se verificó que las VMs estuvieran en ejecución y se estableció conexión con ellas.
   - Se realizaron pruebas de resolución DNS utilizando comandos como `nslookup` o `ping` para asegurarse de que los nombres de dominio configurados en las zonas de dominio privadas se resolvieran correctamente


***Conclusión***
La configuración de Azure DNS como servicio ofrece una solución eficiente y fácil de administrar para gestionar las zonas de dominio privadas en la nube de Azure. A través de los pasos descritos en este informe, se logró crear una zona de dominio privada, agregar VMs que utilizan esta zona y comprobar la correcta resolución DNS. Estas configuraciones permiten a las organizaciones tener un control más granular sobre la gestión de sus nombres de dominio y garantizar la disponibilidad y seguridad de sus aplicaciones en la nube.

En resumen, Azure DNS ofrece una plataforma robusta y flexible para administrar las necesidades de DNS en entornos de nube, brindando a las organizaciones la capacidad de gestionar sus zonas de dominio privadas de manera eficiente y confiable.

**Fuentes**
Documentación oficial de Microsoft Azure: https://docs.microsoft.com/azure/
Documentación de Azure DNS: https://docs.microsoft.com/azure/dns/
Microsoft Learn: https://learn.microsoft.com/
Blog de Microsoft Azure: https://azure.microsoft.com/en-us/blog/
Whitepapers y recursos técnicos de Microsoft relacionados con Azure y DNS.
