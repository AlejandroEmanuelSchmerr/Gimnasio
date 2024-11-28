import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ManagePlansPage extends StatefulWidget {
  @override
  _ManagePlansPageState createState() => _ManagePlansPageState();
}

class _ManagePlansPageState extends State<ManagePlansPage> {
  List<dynamic> planes = [];
  final _nombreController = TextEditingController();
  final _imagenController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _duracionController = TextEditingController();
  String? _selectedPlanId;

  // Método para obtener los planes de la API
  Future<void> _fetchPlanes() async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost/api.php'),
        body: {'action': 'get_plans'},
      );
      if (response.statusCode == 200) {
        setState(() {
          planes = json.decode(response.body);
        });
      }
    } catch (e) {
      print("Error fetching plans: $e");
    }
  }

  // Método para agregar o editar un plan
  Future<void> _savePlan() async {
    try {
      final action = _selectedPlanId == null ? 'add_plan' : 'edit_plan';
      final response = await http.post(
        Uri.parse('http://localhost/api.php'),
        body: {
          'action': action,
          'id': _selectedPlanId ?? '',
          'nombre': _nombreController.text,
          'imagen': _imagenController.text,
          'descripcion': _descripcionController.text,
          'duracion': _duracionController.text,
        },
      );
      if (response.statusCode == 200) {
        _fetchPlanes(); // Actualizar la lista de planes
        _resetForm();   // Resetear el formulario
      }
    } catch (e) {
      print("Error saving plan: $e");
    }
  }

  // Método para eliminar un plan
  Future<void> _deletePlan(int id) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost/api.php'),
        body: {
          'action': 'delete_plan',
          'id': id.toString(),
        },
      );
      if (response.statusCode == 200) {
        _fetchPlanes(); // Actualizar lista después de eliminar
      }
    } catch (e) {
      print("Error deleting plan: $e");
    }
  }

  // Método para cargar datos de un plan al formulario para edición
  void _editPlan(dynamic plan) {
    setState(() {
      _selectedPlanId = plan['id'].toString();
      _nombreController.text = plan['nombre'];
      _imagenController.text = plan['imagen'];
      _descripcionController.text = plan['descripcion'];
      _duracionController.text = plan['duracion'];
    });
  }

  // Método para resetear el formulario
  void _resetForm() {
    setState(() {
      _selectedPlanId = null;
      _nombreController.clear();
      _imagenController.clear();
      _descripcionController.clear();
      _duracionController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchPlanes(); // Obtener los planes al iniciar la página
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Plans'),
      ),
      body: Column(
        children: [
          // Formulario para agregar/editar un plan
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _nombreController,
                  decoration: InputDecoration(labelText: 'Nombre'),
                ),
                TextField(
                  controller: _imagenController,
                  decoration: InputDecoration(labelText: 'Imagen URL'),
                ),
                TextField(
                  controller: _descripcionController,
                  decoration: InputDecoration(labelText: 'Descripción'),
                ),
                TextField(
                  controller: _duracionController,
                  decoration: InputDecoration(labelText: 'Duración'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _savePlan,
                  child: Text(_selectedPlanId == null ? 'Agregar Plan' : 'Guardar Cambios'),
                ),
                if (_selectedPlanId != null)
                  TextButton(
                    onPressed: _resetForm,
                    child: Text('Cancelar edición'),
                  ),
              ],
            ),
          ),

          // Lista de planes
          Expanded(
            child: planes.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: planes.length,
                    itemBuilder: (context, index) {
                      final plan = planes[index];
                      return ListTile(
                        title: Text(plan['nombre']),
                        subtitle: Text('Duración: ${plan['duracion']} días'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                _editPlan(plan); // Cargar datos para editar
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                _deletePlan(plan['id']); // Llamar a la función de eliminar
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
