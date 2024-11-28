# **Aplicación de Gimnasio - Flutter y API PHP**

Esta es una aplicación móvil diseñada para gestionar actividades relacionadas con gimnasios. Incluye funcionalidades para registrar usuarios, gestionar dietas, planes de entrenamiento, y más. El backend está desarrollado en PHP, y la aplicación móvil utiliza **Dart** con **Flutter**.

## **Descripción del funcionamiento**

### **Pantalla de inicio**
- **Opciones principales**:
  - **Ingresar**: Redirige a la pantalla de inicio de sesión.
  - **Registrarse**: Redirige a la pantalla de registro de usuario.

### **Registro de usuario**
- Permite a los nuevos usuarios crear una cuenta ingresando sus datos.
- Al completar el registro, redirige automáticamente a la pantalla de inicio de sesión.
- También incluye la opción **"Ya tienes cuenta, inicia sesión"**, que redirige a la pantalla de inicio de sesión.

### **Inicio de sesión**
- Los usuarios ingresan sus credenciales para acceder a la aplicación.
- Una vez iniciada la sesión, se muestra un botón para cerrar sesión y las siguientes opciones en el menú principal:
  - **Dietas**: Permite asignarse una dieta al usuario.
  - **Planes**: Permite asignarse un plan de entrenamiento al usuario.
  - **Mis dietas**: Muestra las dietas asignadas al usuario.
  - **Mis planes**: Muestra los planes asignados al usuario.
  - **Perfil**: Permite al usuario visualizar y actualizar sus datos (excepto la contraseña).
  - **Ayuda**: Incluye preguntas frecuentes, redes sociales, políticas de seguridad, y guías de uso.
  - **Información**: Muestra características de la aplicación y políticas de seguridad.

### **Gestión de dietas**
- En la sección **Dietas**, el usuario puede asignarse una dieta.
- En **Mis dietas**, se visualizan todas las dietas asignadas.
- Al seleccionar una dieta, se muestra el detalle semanal con la comida asignada para cada día.

### **Gestión de planes**
- En la sección **Planes**, el usuario puede asignarse un plan de entrenamiento.
- En **Mis planes**, se visualizan todos los planes asignados.
- Al seleccionar un plan, se muestran las semanas correspondientes, con la rutina diaria, imágenes y videos.

### **Perfil del usuario**
- Muestra la información del usuario registrada.
- Permite actualizar datos como nombre, email, etc., pero no la contraseña.

### **Sección de Ayuda**
- Incluye:
  - Preguntas frecuentes.
  - Redes sociales.
  - Políticas de seguridad.
  - Guías para usar dietas y planes.
  - Explicación de las opciones en el apartado de perfil.

### **Sección de Información**
- Muestra:
  - Características de la aplicación.
  - Políticas de seguridad.

---

## **Tecnologías utilizadas**
- **Frontend**: Dart, Flutter.
- **Backend**: PHP.
- **Entorno de desarrollo**: Visual Studio Code.
- **Base de datos**: MySQL.

---

## **Pasos de instalación**

### **Requisitos**
1. **Flutter**: Descárgalo desde [flutter.dev](https://flutter.dev/).
2. **Dart**: Incluido al instalar Flutter.
3. **Visual Studio Code**: Descárgalo desde [code.visualstudio.com](https://code.visualstudio.com/).
4. **Servidor local**: XAMPP para ejecutar el backend en PHP.

### **Configuración**
1. **Instalar Flutter y configurar el entorno**:
   - Sigue la guía oficial de instalación de Flutter.
   - Verifica la instalación con:
     ```bash
     flutter doctor
     ```
2. **Instalar XAMPP**:
   - Descárgalo desde [apachefriends.org](https://www.apachefriends.org/).
   - Activa el módulo **Apache** desde el panel de control de XAMPP.

3. **Clonar el repositorio**:
   - Descarga este proyecto o clónalo desde el repositorio.

4. **Configurar la base de datos**:
   - Importa el archivo `gimnasio.sql` en phpMyAdmin:
     1. Abre phpMyAdmin desde XAMPP (generalmente en `http://localhost/phpmyadmin`).
     2. Crea una base de datos llamada `gimnasio`.
     3. Importa el archivo `gimnasio.sql`.

5. **Colocar la API en XAMPP**:
   - Copia el archivo `api.php` en la carpeta `htdocs`.

6. **Ejecutar el proyecto**:
   - Abre el proyecto en Visual Studio Code.
   - En la terminal, navega a la carpeta del proyecto Flutter.
   - Ejecuta el comando:
     ```bash
     flutter run
     ```
   - Elige la opción 2 para ejecutar el proyecto.

---

## **Estado del proyecto**
El proyecto está pendiente y faltan muchas funcionalidades por implementar.

---

## **Autor**
- **Nombre**: Emanuel Schmer  
- **Correo**: emanuelschmer@hotmail.com  

---

## **Agradecimientos**
Gracias por tomarte el tiempo de ver este proyecto. 😊
