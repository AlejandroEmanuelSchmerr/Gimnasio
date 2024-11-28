import 'package:flutter/material.dart';
import 'manage_users_page.dart';
import 'manage_dietas_page.dart';
import 'manage_ejercicios_page.dart';
import 'manage_usuariosplanes_page.dart';
import 'manage_userdietas_page.dart';
import 'manage_comidas_page.dart';
import 'manage_planes_page.dart';

class AdminPage extends StatelessWidget {
  final Map<String, dynamic> userData;  // Añade este campo

  AdminPage({required this.userData});  // Asegúrate de requerir userData

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Hola Administrador: ${userData['name']}',  // Usa userData para mostrar el nombre del usuario
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: Text('Manage Users'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ManageUsersPage()),
                    );
                  },
                ),
                ListTile(
                  title: Text('Manage Diets'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ManageDietsPage()),
                    );
                  },
                ),
                ListTile(
                  title: Text('Manage Exercises'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ManageEjerciciosPage()),
                    );
                  },
                ),
                ListTile(
                  title: Text('Manage User Diets'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ManageUserDietsPage()),
                    );
                  },
                ),
                ListTile(
                  title: Text('Manage User Plans'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ManageUserPlansPage()),
                    );
                  },
                ),
                ListTile(
                  title: Text('Manage Plans'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ManagePlansPage()),
                    );
                  },
                ),
                ListTile(
                  title: Text('Manage Meals'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ManageComidasPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
