import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'screens/login_page.dart';
import 'screens/register_page.dart';
import 'screens/inicio_page.dart';
import 'screens/dietas_page.dart'; 
import 'screens/dieta_detail_page.dart';
import 'screens/profile_user.dart';  
import 'screens/line_chart_painter.dart'; 
import 'screens/planes_page.dart';
import 'screens/mis_dietas_page.dart';
import 'screens/mis_planes_page.dart';
import 'screens/informacion_page.dart';
import 'screens/ayuda_page.dart';




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ATHLOS GYM',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/inicio': (context) => InicioPage(userData: {'nombre': 'Usuario', 'id': 1}),
        '/dietas': (context) => DietasPage(1), 
        '/profile': (context) => UserProfilePage(userData: {}),
        '/chart': (context) => LineChartScreen(), 
        '/planes': (context) => PlanesPage(userId: 1),
        '/ayuda': (context) => AyudaPage(), 
        '/misdietas': (context) => MisDietasPage(userId: 1),
        '/misplanes': (context) => MisPlanesPage(userId: 1),
        '/informacion': (context) => InformacionPage(),




      },
    );
  }
}

class LineChartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<double> dataPoints = [50, 100, 150, 100, 200, 250, 150];

    return Scaffold(
      appBar: AppBar(
        title: Text('Line Chart'),
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 200,
          child: CustomPaint(
            painter: LineChartPainter(dataPoints: dataPoints),
          ),
        ),
      ),
    );
  }
}
