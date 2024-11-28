import 'package:flutter/material.dart';

class AyudaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Ayuda',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white, 
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); 
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Preguntas Frecuentes'),
              _buildHelpItem(
                '¿Cuáles son los horarios de las clases?',
                'Las clases están disponibles de lunes a viernes de 6 AM a 10 PM.',
              ),
              _buildHelpItem(
                '¿Qué equipos están disponibles?',
                'Contamos con pesas libres, máquinas de cardio y equipos de resistencia.',
              ),
              _buildHelpItem(
                '¿Qué dietas ofrecen?',
                'Ofrecemos planes personalizados adaptados a tus necesidades.',
              ),
              
              SizedBox(height: 20),



              _buildSectionTitle('Redes Sociales'),
              _buildHelpItem('Síguenos en Instagram: @athlos_gimnasio', ''),
              _buildHelpItem('Encuéntranos en Facebook: Athlos gimnasio', ''),
              SizedBox(height: 20),

              _buildSectionTitle('Política y Seguridad'),
              _buildHelpItem(
                '¿Qué medidas de seguridad tienen en su lugar?',
                'Contamos con protocolos de limpieza y seguridad para tu bienestar.',
              ),
              _buildHelpItem(
                '¿Dónde puedo revisar la política de privacidad?',
                'La política de privacidad está disponible en el apartado de informacion.',
              ),
              SizedBox(height: 20),

              _buildSectionTitle('Dietas y Planes'),
              _buildHelpItem(
                '¿Cómo agrego una dieta a \'Mis Dietas\'?',
                'Selecciona una dieta disponible en la sección \'Dietas\' y pulsa en el boton "+". Se guardará en tu perfil para que puedas seguirla semanalmente.',
              ),
              _buildHelpItem(
                '¿Cómo agrego un plan a \'Mis Planes\'?',
                'Elige un plan de la sección \'Planes\' y pulsa en el boton"+". Esto te permitirá seguir el plan de entrenamiento y ver los ejercicios asignados por semana.',
              ),
              _buildHelpItem(
                '¿Cómo veo las comidas diarias de mi dieta?',
                'En la sección \'Mis Dietas\', selecciona la dieta que has agregado para ver el desglose de las comidas diarias y semanales.',
              ),
              _buildHelpItem(
                '¿Cómo veo mis ejercicios de cada semana?',
                'En la sección \'Mis Planes\', selecciona el plan que has añadido para ver qué ejercicios debes realizar y cómo organizarlos según los días de la semana.',
              ),
              SizedBox(height: 20),

              _buildSectionTitle('Perfil'),
              _buildHelpItem(
                '¿Cómo actualizo mis datos personales?',
                'Puedes actualizar tu información en la sección de \'Perfil\', como tu nombre, edad, y otros datos de contacto. Simplemente edita los campos y guarda los cambios.',
              ),
              
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildHelpItem(String question, String answer) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          if (answer.isNotEmpty) ...[
            SizedBox(height: 4),
            Text(
              answer,
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ],
        ],
      ),
    );
  }
}
