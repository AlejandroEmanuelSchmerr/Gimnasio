import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ManageUserPlansPage extends StatefulWidget {
  @override
  _ManageUserPlansPageState createState() => _ManageUserPlansPageState();
}

class _ManageUserPlansPageState extends State<ManageUserPlansPage> {
  List<dynamic> userPlans = [];
  final _userIdController = TextEditingController();
  final _planIdController = TextEditingController();
  String? _selectedUserPlanId;

  // Método para obtener los planes de los usuarios desde la API
  Future<void> _fetchUserPlans() async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost/api.php'),
        body: {'action': 'get_user_plans'},
      );
      if (response.statusCode == 200) {
        setState(() {
          userPlans = json.decode(response.body);
        });
      }
    } catch (e) {
      print("Error fetching user plans: $e");
    }
  }

  // Método para agregar o editar un plan de usuario
  Future<void> _saveUserPlan() async {
    try {
      final action = _selectedUserPlanId == null ? 'add_user_plan' : 'edit_user_plan';
      final response = await http.post(
        Uri.parse('http://localhost/api.php'),
        body: {
          'action': action,
          'id': _selectedUserPlanId ?? '',
          'user_id': _userIdController.text,
          'plan_id': _planIdController.text,
        },
      );
      if (response.statusCode == 200) {
        _fetchUserPlans(); // Actualizar la lista después de agregar/editar
        _resetForm();      // Limpiar el formulario
      }
    } catch (e) {
      print("Error saving user plan: $e");
    }
  }

  // Método para eliminar un plan de usuario
  Future<void> _deleteUserPlan(int id) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost/api.php'),
        body: {
          'action': 'delete_user_plan',
          'id': id.toString(),
        },
      );
      if (response.statusCode == 200) {
        _fetchUserPlans(); // Actualizar lista después de eliminar
      }
    } catch (e) {
      print("Error deleting user plan: $e");
    }
  }

  // Método para editar un plan de usuario (cargar datos en el formulario)
  void _editUserPlan(dynamic userPlan) {
    setState(() {
      _selectedUserPlanId = userPlan['id'].toString();
      _userIdController.text = userPlan['user_id'];
      _planIdController.text = userPlan['plan_id'];
    });
  }

  // Método para resetear el formulario
  void _resetForm() {
    setState(() {
      _selectedUserPlanId = null;
      _userIdController.clear();
      _planIdController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchUserPlans(); // Obtener los planes de usuario al iniciar la página
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage User Plans'),
      ),
      body: Column(
        children: [
          // Formulario para agregar/editar plan de usuario
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _userIdController,
                  decoration: InputDecoration(labelText: 'ID Usuario'),
                ),
                TextField(
                  controller: _planIdController,
                  decoration: InputDecoration(labelText: 'ID Plan'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _saveUserPlan,
                  child: Text(_selectedUserPlanId == null ? 'Agregar Plan de Usuario' : 'Guardar Cambios'),
                ),
                if (_selectedUserPlanId != null)
                  TextButton(
                    onPressed: _resetForm,
                    child: Text('Cancelar Edición'),
                  ),
              ],
            ),
          ),

          // Lista de planes de usuario
          Expanded(
            child: userPlans.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: userPlans.length,
                    itemBuilder: (context, index) {
                      final userPlan = userPlans[index];
                      return ListTile(
                        title: Text('Usuario ID: ${userPlan['user_id']} - Plan ID: ${userPlan['plan_id']}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                _editUserPlan(userPlan); // Cargar datos para editar
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                _deleteUserPlan(userPlan['id']); // Eliminar plan de usuario
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
