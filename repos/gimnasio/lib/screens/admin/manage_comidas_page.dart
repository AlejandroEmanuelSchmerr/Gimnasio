import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ManageComidasPage extends StatefulWidget {
  @override
  _ManageComidasPageState createState() => _ManageComidasPageState();
}

class _ManageComidasPageState extends State<ManageComidasPage> {
  List<dynamic> comidas = [];
  final _dietaIdController = TextEditingController();
  final _diaController = TextEditingController();
  final _tipoComidaController = TextEditingController();
  final _comidaController = TextEditingController();
  final _cantidadController = TextEditingController();
  final _ingredientesController = TextEditingController();
  final _preparacionController = TextEditingController();
  final _semanaController = TextEditingController();
  String? _selectedComidaId;

  @override
  void initState() {
    super.initState();
    _fetchComidas(); // Load meals on startup
  }

  Future<void> _fetchComidas() async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost/api.php'),
        body: {'action': 'get_meals'},
      );
      if (response.statusCode == 200) {
        setState(() {
          comidas = json.decode(response.body);
        });
      }
    } catch (e) {
      print("Error fetching meals: $e");
    }
  }

  Future<void> _saveComida() async {
    try {
      final action = _selectedComidaId == null ? 'add_meal' : 'edit_meal';
      final response = await http.post(
        Uri.parse('http://localhost/api.php'),
        body: {
          'action': action,
          'id': _selectedComidaId ?? '',
          'dieta_id': _dietaIdController.text,
          'dia': _diaController.text,
          'tipo_comida': _tipoComidaController.text,
          'comida': _comidaController.text,
          'cantidad': _cantidadController.text,
          'ingredientes': _ingredientesController.text,
          'preparacion': _preparacionController.text,
          'semana': _semanaController.text,
        },
      );
      if (response.statusCode == 200) {
        _fetchComidas(); // Refresh meal list
        _resetForm(); // Reset form
      }
    } catch (e) {
      print("Error saving meal: $e");
    }
  }

  Future<void> _deleteComida(int id) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost/api.php'),
        body: {
          'action': 'delete_meal',
          'id': id.toString(),
        },
      );
      if (response.statusCode == 200) {
        _fetchComidas(); // Refresh list after deletion
      }
    } catch (e) {
      print("Error deleting meal: $e");
    }
  }

  void _editComida(dynamic comida) {
    setState(() {
      _selectedComidaId = comida['id'].toString();
      _dietaIdController.text = comida['dieta_id'];
      _diaController.text = comida['dia'];
      _tipoComidaController.text = comida['tipo_comida'];
      _comidaController.text = comida['comida'];
      _cantidadController.text = comida['cantidad'];
      _ingredientesController.text = comida['ingredientes'];
      _preparacionController.text = comida['preparacion'];
      _semanaController.text = comida['semana'];
    });
  }

  void _resetForm() {
    setState(() {
      _selectedComidaId = null;
      _dietaIdController.clear();
      _diaController.clear();
      _tipoComidaController.clear();
      _comidaController.clear();
      _cantidadController.clear();
      _ingredientesController.clear();
      _preparacionController.clear();
      _semanaController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Meals'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(controller: _dietaIdController, decoration: InputDecoration(labelText: 'Dieta ID')),
                TextField(controller: _diaController, decoration: InputDecoration(labelText: 'Día')),
                TextField(controller: _tipoComidaController, decoration: InputDecoration(labelText: 'Tipo de Comida')),
                TextField(controller: _comidaController, decoration: InputDecoration(labelText: 'Comida')),
                TextField(controller: _cantidadController, decoration: InputDecoration(labelText: 'Cantidad')),
                TextField(controller: _ingredientesController, decoration: InputDecoration(labelText: 'Ingredientes')),
                TextField(controller: _preparacionController, decoration: InputDecoration(labelText: 'Preparación')),
                TextField(controller: _semanaController, decoration: InputDecoration(labelText: 'Semana')),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _saveComida,
                  child: Text(_selectedComidaId == null ? 'Agregar Comida' : 'Guardar Cambios'),
                ),
                if (_selectedComidaId != null)
                  TextButton(
                    onPressed: _resetForm,
                    child: Text('Cancelar edición'),
                  ),
              ],
            ),
          ),
          Expanded(
            child: comidas.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: comidas.length,
                    itemBuilder: (context, index) {
                      final comida = comidas[index];
                      return ListTile(
                        title: Text('${comida['comida']} (${comida['tipo_comida']})'),
                        subtitle: Text('Día: ${comida['dia']}, Cantidad: ${comida['cantidad']}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () => _editComida(comida), // Load data for editing
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => _deleteComida(comida['id']), // Delete meal
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
