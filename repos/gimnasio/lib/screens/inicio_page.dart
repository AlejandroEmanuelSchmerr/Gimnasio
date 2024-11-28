import 'package:flutter/material.dart';
import 'profile_user.dart';
import 'dietas_page.dart';
import 'planes_page.dart';
import 'ayuda_page.dart';
import 'informacion_page.dart';
import 'mis_dietas_page.dart'; 
import 'mis_planes_page.dart'; 

class InicioPage extends StatelessWidget {
  final Map<String, dynamic> userData;

  InicioPage({required this.userData});

  @override
  Widget build(BuildContext context) {
    int userId = int.tryParse(userData['id'].toString()) ?? 0;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Inicio',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.logout, color: Colors.white),
          onPressed: () {
            _cerrarSesion(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildMenuButton(context, Icons.fitness_center, 'Planes', onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlanesPage(userId: userId),
                ),
              );
            }),
            SizedBox(height: 10),
            _buildMenuButton(context, Icons.restaurant_menu, 'Dieta', onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DietasPage(userId),
                ),
              );
            }),
            SizedBox(height: 10),
            _buildMenuButton(context, Icons.fastfood, 'Mis Dietas', onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MisDietasPage(userId: userId), 
                ),
              );
            }),
            SizedBox(height: 10),
            _buildMenuButton(context, Icons.assignment, 'Mis Planes', onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MisPlanesPage(userId: userId),
                ),
              );
            }),
            SizedBox(height: 10),
            _buildMenuButton(context, Icons.person, 'Perfil', onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserProfilePage(userData: userData),
                ),
              );
            }),
            SizedBox(height: 10),
            _buildMenuButton(context, Icons.help, 'Ayuda', onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AyudaPage(),
                ),
              );
            }),
            
            SizedBox(height: 10),
            _buildMenuButton(context, Icons.info, 'Información', onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => InformacionPage(),
    ),
  );
}),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, IconData icon, String label, {VoidCallback? onPressed}) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 60),
        backgroundColor: Colors.grey,
      ),
      onPressed: onPressed ?? () {
        print('$label clicked');
      },
      icon: Icon(icon, size: 30, color: Colors.black),
      label: Text(
        label,
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
      ),
    );
  }

  void _cerrarSesion(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cerrar sesión'),
          content: Text('¿Estás seguro de que deseas cerrar sesión?'),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cerrar sesión'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/login');
              },
            ),
          ],
        );
      },
    );
  }
}
