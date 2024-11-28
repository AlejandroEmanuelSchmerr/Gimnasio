import 'package:flutter/material.dart';

class InformacionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Información',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bienvenido a nuestra aplicación de salud y bienestar.',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              SizedBox(height: 20),
              Text(
                'Aquí puedes encontrar planes de entrenamiento y dietas personalizadas para alcanzar tus objetivos.',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Características:',
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                '- Planes de entrenamiento adaptados a tus necesidades.',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                '- Dietas personalizadas para mejorar tu salud.',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                '- Monitoreo de tu progreso y recomendaciones personalizadas.',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Política y Seguridad:',
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                '- Respetamos tu privacidad y seguimos los más altos estándares de seguridad en la protección de tus datos personales.',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                '- Tu información, como nombre, correo electrónico y datos, se almacena de forma segura en nuestros servidores.',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                '- Para acceder a tu cuenta, utiliza contraseñas seguras. ',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              
              Text(
                '- Nuestro equipo sigue estrictos protocolos de limpieza y cuidado en nuestras instalaciones, garantizando tu bienestar físico y sanitario.',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Contáctanos si tienes alguna duda o necesitas ayuda.',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
