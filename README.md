# Proyecto Chq.To

## Descripción
Chq.To es una aplicación web simple para acortar enlaces y rastrear el acceso a ellos. Permite a los usuarios registrarse, acortar enlaces, y gestionar sus enlaces. También proporciona estadísticas básicas de acceso.

## Decisiones de Diseño
* ___Eliminación de Datos No Referenciados:___
  
  - Se elimina automáticamente los enlaces cuando se elimina un usuario.
  - Los accesos se eliminan cuando se elimina un enlace.
  - Esta decisión reduce la basura de datos y mantiene la integridad referencial.

* ___Separación de Responsabilidades con el Modelo Access:___
  
  - Se introduce un modelo Access para gestionar los registros de acceso.
  - Evita que el modelo y controlador de Link se vuelvan demasiado complejos.

* ___Campo accessed_at en el Modelo Access:___
  
  - El campo accessed_at en Access se considera innecesario.
  - La fecha y hora de acceso se registra en created_at.

* ___Campo name Requerido en Link:___
  
  - Se requiere que el campo name en el modelo Link no esté en blanco.
  - Mejora la estética al asegurar que todos los enlaces tengan nombres.

* ___Filtrado de Accesos por IP:___
  
  - El filtrado de accesos por dirección IP puede ser general o específico.
  - Permite una mayor flexibilidad en el análisis de datos.

* ___Configuración de Zona Horaria:___
  
  - La zona horaria se establece en 'America/Argentina/Buenos_Aires'.
  - Configurado en config/application.rb y config/database.yml.

## Requisitos Técnicos
* Ruby: 2.7 o superior.
* Ruby on Rails: 7.1.2.
* Base de Datos: SQLite.

## Pasos para Hacer Funcionar la Aplicación
1. Instalación de Dependencias:
   
   `bundle install`
2. Configuración de Base de Datos:
   
    `rails db:create`
    `rails db:migrate`
3. Cargar Datos del archivo Seeds en la Base de Datos:
   
   `rails db:seed`
4. Ejecutar la Aplicación:
   
   `rails server`
5. Acceder a la Aplicación:
* Abre tu navegador y visita <http://localhost:3000>.
