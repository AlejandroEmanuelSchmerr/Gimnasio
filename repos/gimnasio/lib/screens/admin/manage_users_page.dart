import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ManageUsersPage extends StatefulWidget {
  @override
  _ManageUsersPageState createState() => _ManageUsersPageState();
}

class _ManageUsersPageState extends State<ManageUsersPage> {
  List<dynamic> users = [];
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _genderController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _goalController = TextEditingController();
  String? _selectedUserId;

  // Método para obtener los usuarios de la API
  Future<void> _fetchUsers() async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost/api.php'),
        body: {'action': 'get_users'},
      );
      if (response.statusCode == 200) {
        setState(() {
          users = json.decode(response.body);
        });
      }
    } catch (e) {
      print("Error fetching users: $e");
    }
  }

  // Método para agregar o editar un usuario
  Future<void> _saveUser() async {
    try {
      final action = _selectedUserId == null ? 'add_user' : 'edit_user';
      final response = await http.post(
        Uri.parse('http://localhost/api.php'),
        body: {
          'action': action,
          'id': _selectedUserId ?? '',
          'name': _nameController.text,
          'surname': _surnameController.text,
          'gender': _genderController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
          'age': _ageController.text,
          'height': _heightController.text,
          'weight': _weightController.text,
          'goal': _goalController.text,
        },
      );
      if (response.statusCode == 200) {
        _fetchUsers(); // Actualizar lista después de agregar/editar
        _resetForm();  // Resetear el formulario después de guardar
      }
    } catch (e) {
      print("Error saving user: $e");
    }
  }

  // Método para eliminar un usuario
  Future<void> _deleteUser(int id) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost/api.php'),
        body: {
          'action': 'delete_user',
          'id': id.toString(),
        },
      );
      if (response.statusCode == 200) {
        _fetchUsers(); // Actualizar lista después de eliminar
      }
    } catch (e) {
      print("Error deleting user: $e");
    }
  }

  // Método para editar un usuario
  void _editUser(dynamic user) {
    setState(() {
      _selectedUserId = user['id'].toString();
      _nameController.text = user['nombre'];
      _surnameController.text = user['apellido'];
      _genderController.text = user['genero'];
      _emailController.text = user['email'];
      _passwordController.text = user['password'];
      _ageController.text = user['edad'].toString();
      _heightController.text = user['altura'].toString();
      _weightController.text = user['peso'].toString();
      _goalController.text = user['objetivo'];
    });
  }

  // Método para resetear el formulario
  void _resetForm() {
    setState(() {
      _selectedUserId = null;
      _nameController.clear();
      _surnameController.clear();
      _genderController.clear();
      _emailController.clear();
      _passwordController.clear();
      _ageController.clear();
      _heightController.clear();
      _weightController.clear();
      _goalController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchUsers(); // Obtener los usuarios al iniciar la página
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Users'),
      ),
      body: Column(
        children: [
          // Formulario para agregar/editar usuario
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Nombre'),
                ),
                TextField(
                  controller: _surnameController,
                  decoration: InputDecoration(labelText: 'Apellido'),
                ),
                TextField(
                  controller: _genderController,
                  decoration: InputDecoration(labelText: 'Género'),
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Correo Electrónico'),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Contraseña'),
                  obscureText: true,
                ),
                TextField(
                  controller: _ageController,
                  decoration: InputDecoration(labelText: 'Edad'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _heightController,
                  decoration: InputDecoration(labelText: 'Altura (cm)'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _weightController,
                  decoration: InputDecoration(labelText: 'Peso (kg)'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _goalController,
                  decoration: InputDecoration(labelText: 'Objetivo'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _saveUser,
                  child: Text(_selectedUserId == null ? 'Agregar Usuario' : 'Guardar Cambios'),
                ),
                if (_selectedUserId != null)
                  TextButton(
                    onPressed: _resetForm,
                    child: Text('Cancelar edición'),
                  ),
              ],
            ),
          ),

          // Lista de usuarios
          Expanded(
            child: users.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return ListTile(
                        title: Text('${user['nombre']} ${user['apellido']}'),
                        subtitle: Text(user['email']),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                _editUser(user); // Cargar datos para editar
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                _deleteUser(user['id']); // Llamar a la función de eliminar
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
