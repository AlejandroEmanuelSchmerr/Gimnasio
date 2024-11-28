import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ManageUserDietsPage extends StatefulWidget {
  @override
  _ManageUserDietsPageState createState() => _ManageUserDietsPageState();
}

class _ManageUserDietsPageState extends State<ManageUserDietsPage> {
  List<dynamic> userDiets = [];
  final _userIdController = TextEditingController();
  final _dietaIdController = TextEditingController();
  String? _selectedUserDietId;

  // Método para obtener las dietas de los usuarios desde la API
  Future<void> _fetchUserDiets() async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost/api.php'),
        body: {'action': 'get_user_diets'},
      );
      if (response.statusCode == 200) {
        setState(() {
          userDiets = json.decode(response.body);
        });
      }
    } catch (e) {
      print("Error fetching user diets: $e");
    }
  }

  // Método para agregar o editar una dieta de usuario
  Future<void> _saveUserDiet() async {
    try {
      final action = _selectedUserDietId == null ? 'add_user_diet' : 'edit_user_diet';
      final response = await http.post(
        Uri.parse('http://localhost/api.php'),
        body: {
          'action': action,
          'id': _selectedUserDietId ?? '',
          'user_id': _userIdController.text,
          'dieta_id': _dietaIdController.text,
        },
      );
      if (response.statusCode == 200) {
        _fetchUserDiets(); // Actualizar la lista después de agregar/editar
        _resetForm();      // Limpiar el formulario
      }
    } catch (e) {
      print("Error saving user diet: $e");
    }
  }

  // Método para eliminar una dieta de usuario
  Future<void> _deleteUserDiet(int id) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost/api.php'),
        body: {
          'action': 'delete_user_diet',
          'id': id.toString(),
        },
      );
      if (response.statusCode == 200) {
        _fetchUserDiets(); // Actualizar lista después de eliminar
      }
    } catch (e) {
      print("Error deleting user diet: $e");
    }
  }

  // Método para editar una dieta de usuario (cargar datos en el formulario)
  void _editUserDiet(dynamic userDiet) {
    setState(() {
      _selectedUserDietId = userDiet['id'].toString();
      _userIdController.text = userDiet['user_id'];
      _dietaIdController.text = userDiet['dieta_id'];
    });
  }

  // Método para resetear el formulario
  void _resetForm() {
    setState(() {
      _selectedUserDietId = null;
      _userIdController.clear();
      _dietaIdController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchUserDiets(); // Obtener las dietas de usuario al iniciar la página
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage User Diets'),
      ),
      body: Column(
        children: [
          // Formulario para agregar/editar dieta de usuario
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _userIdController,
                  decoration: InputDecoration(labelText: 'ID Usuario'),
                ),
                TextField(
                  controller: _dietaIdController,
                  decoration: InputDecoration(labelText: 'ID Dieta'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _saveUserDiet,
                  child: Text(_selectedUserDietId == null ? 'Agregar Dieta de Usuario' : 'Guardar Cambios'),
                ),
                if (_selectedUserDietId != null)
                  TextButton(
                    onPressed: _resetForm,
                    child: Text('Cancelar Edición'),
                  ),
              ],
            ),
          ),

          // Lista de dietas de usuario
          Expanded(
            child: userDiets.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: userDiets.length,
                    itemBuilder: (context, index) {
                      final userDiet = userDiets[index];
                      return ListTile(
                        title: Text('Usuario ID: ${userDiet['user_id']} - Dieta ID: ${userDiet['dieta_id']}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                _editUserDiet(userDiet); // Cargar datos para editar
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                _deleteUserDiet(userDiet['id']); // Eliminar dieta de usuario
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
