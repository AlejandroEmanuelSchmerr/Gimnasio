import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ManageDietsPage extends StatefulWidget {
  @override
  _ManageDietsPageState createState() => _ManageDietsPageState();
}

class _ManageDietsPageState extends State<ManageDietsPage> {
  List<dynamic> diets = [];
  final _nameController = TextEditingController();
  final _typeController = TextEditingController();
  final _durationController = TextEditingController();
  String? _selectedDietId;

  @override
  void initState() {
    super.initState();
    _fetchDiets(); // Load diets on startup
  }

  Future<void> _fetchDiets() async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost/api.php'),
        body: {'action': 'get_diets'},
      );
      if (response.statusCode == 200) {
        setState(() {
          diets = json.decode(response.body);
        });
      }
    } catch (e) {
      print("Error fetching diets: $e");
    }
  }

  Future<void> _saveDiet() async {
    try {
      final action = _selectedDietId == null ? 'add_diet' : 'edit_diet';
      final response = await http.post(
        Uri.parse('http://localhost/api.php'),
        body: {
          'action': action,
          'id': _selectedDietId ?? '',
          'name': _nameController.text,
          'type': _typeController.text,
          'duration': _durationController.text,
        },
      );
      if (response.statusCode == 200) {
        _fetchDiets(); // Refresh diet list
        _resetForm(); // Reset form
      }
    } catch (e) {
      print("Error saving diet: $e");
    }
  }

  Future<void> _deleteDiet(int id) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost/api.php'),
        body: {
          'action': 'delete_diet',
          'id': id.toString(),
        },
      );
      if (response.statusCode == 200) {
        _fetchDiets(); // Refresh list after deletion
      }
    } catch (e) {
      print("Error deleting diet: $e");
    }
  }

  void _editDiet(dynamic diet) {
    setState(() {
      _selectedDietId = diet['id'].toString();
      _nameController.text = diet['nombre'];
      _typeController.text = diet['tipo'];
      _durationController.text = diet['duracion'];
    });
  }

  void _resetForm() {
    setState(() {
      _selectedDietId = null;
      _nameController.clear();
      _typeController.clear();
      _durationController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Diets'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Nombre')),
                TextField(controller: _typeController, decoration: InputDecoration(labelText: 'Tipo')),
                TextField(controller: _durationController, decoration: InputDecoration(labelText: 'Duración')),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _saveDiet,
                  child: Text(_selectedDietId == null ? 'Agregar Dieta' : 'Guardar Cambios'),
                ),
                if (_selectedDietId != null)
                  TextButton(
                    onPressed: _resetForm,
                    child: Text('Cancelar edición'),
                  ),
              ],
            ),
          ),
          Expanded(
            child: diets.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: diets.length,
                    itemBuilder: (context, index) {
                      final diet = diets[index];
                      return ListTile(
                        title: Text('${diet['nombre']} (${diet['tipo']})'),
                        subtitle: Text('Duración: ${diet['duracion']} días'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () => _editDiet(diet), // Load data for editing
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => _deleteDiet(diet['id']), // Delete diet
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
