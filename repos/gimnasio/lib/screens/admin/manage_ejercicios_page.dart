import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ManageEjerciciosPage extends StatefulWidget {
  @override
  _ManageEjerciciosPageState createState() => _ManageEjerciciosPageState();
}

class _ManageEjerciciosPageState extends State<ManageEjerciciosPage> {
  List<dynamic> ejercicios = [];
  final _nombreController = TextEditingController();
  final _videoUrlController = TextEditingController();
  final _imagenUrlController = TextEditingController();
  final _repeticionesController = TextEditingController();
  final _semanaController = TextEditingController();
  final _diaController = TextEditingController();
  String? _selectedExerciseId;

  // Método para obtener los ejercicios de la API
  Future<void> _fetchEjercicios() async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost/api.php'),
        body: {'action': 'get_exercises'},
      );
      if (response.statusCode == 200) {
        setState(() {
          ejercicios = json.decode(response.body);
        });
      }
    } catch (e) {
      print("Error fetching exercises: $e");
    }
  }

  // Método para agregar o editar un ejercicio
  Future<void> _saveEjercicio() async {
    try {
      final action = _selectedExerciseId == null ? 'add_exercise' : 'edit_exercise';
      final response = await http.post(
        Uri.parse('http://localhost/api.php'),
        body: {
          'action': action,
          'id': _selectedExerciseId ?? '',
          'nombre': _nombreController.text,
          'video_url': _videoUrlController.text,
          'imagen_url': _imagenUrlController.text,
          'repeticiones': _repeticionesController.text,
          'semana': _semanaController.text,
          'dia': _diaController.text,
        },
      );
      if (response.statusCode == 200) {
        _fetchEjercicios(); // Actualizar la lista de ejercicios
        _resetForm();   // Resetear el formulario
      }
    } catch (e) {
      print("Error saving exercise: $e");
    }
  }

  // Método para eliminar un ejercicio
  Future<void> _deleteEjercicio(int id) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost/api.php'),
        body: {
          'action': 'delete_exercise',
          'id': id.toString(),
        },
      );
      if (response.statusCode == 200) {
        _fetchEjercicios(); // Actualizar lista después de eliminar
      }
    } catch (e) {
      print("Error deleting exercise: $e");
    }
  }

  // Método para cargar datos de un ejercicio al formulario para edición
  void _editEjercicio(dynamic ejercicio) {
    setState(() {
      _selectedExerciseId = ejercicio['id'].toString();
      _nombreController.text = ejercicio['nombre'];
      _videoUrlController.text = ejercicio['video_url'];
      _imagenUrlController.text = ejercicio['imagen_url'];
      _repeticionesController.text = ejercicio['repeticiones'].toString();
      _semanaController.text = ejercicio['semana'].toString();
      _diaController.text = ejercicio['dia'].toString();
    });
  }

  // Método para resetear el formulario
  void _resetForm() {
    setState(() {
      _selectedExerciseId = null;
      _nombreController.clear();
      _videoUrlController.clear();
      _imagenUrlController.clear();
      _repeticionesController.clear();
      _semanaController.clear();
      _diaController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchEjercicios(); // Obtener los ejercicios al iniciar la página
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Exercises'),
      ),
      body: Column(
        children: [
          // Formulario para agregar/editar un ejercicio
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _nombreController,
                  decoration: InputDecoration(labelText: 'Nombre'),
                ),
                TextField(
                  controller: _videoUrlController,
                  decoration: InputDecoration(labelText: 'Video URL'),
                ),
                TextField(
                  controller: _imagenUrlController,
                  decoration: InputDecoration(labelText: 'Imagen URL'),
                ),
                TextField(
                  controller: _repeticionesController,
                  decoration: InputDecoration(labelText: 'Repeticiones'),
                ),
                TextField(
                  controller: _semanaController,
                  decoration: InputDecoration(labelText: 'Semana'),
                ),
                TextField(
                  controller: _diaController,
                  decoration: InputDecoration(labelText: 'Día'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _saveEjercicio,
                  child: Text(_selectedExerciseId == null ? 'Agregar Ejercicio' : 'Guardar Cambios'),
                ),
                if (_selectedExerciseId != null)
                  TextButton(
                    onPressed: _resetForm,
                    child: Text('Cancelar edición'),
                  ),
              ],
            ),
          ),

          // Lista de ejercicios
          Expanded(
            child: ejercicios.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: ejercicios.length,
                    itemBuilder: (context, index) {
                      final ejercicio = ejercicios[index];
                      return ListTile(
                        title: Text(ejercicio['nombre']),
                        subtitle: Text('Semana: ${ejercicio['semana']}, Día: ${ejercicio['dia']}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                _editEjercicio(ejercicio); // Cargar datos para editar
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                _deleteEjercicio(ejercicio['id']); // Llamar a la función de eliminar
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
