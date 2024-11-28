import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserProfilePage extends StatefulWidget {
  final Map<String, dynamic> userData;

  UserProfilePage({required this.userData});

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late TextEditingController _nombreController;
  late TextEditingController _apellidoController;
  late TextEditingController _emailController;
  late TextEditingController _edadController;
  late TextEditingController _alturaController;
  late TextEditingController _objetivoController;
  late TextEditingController _pesoController;
  late TextEditingController _semanasController;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.userData['nombre']);
    _apellidoController = TextEditingController(text: widget.userData['apellido']);
    _emailController = TextEditingController(text: widget.userData['email']);
    _edadController = TextEditingController(text: widget.userData['edad'].toString());
    _alturaController = TextEditingController(text: widget.userData['altura'].toString());
    _objetivoController = TextEditingController(text: widget.userData['objetivo']);
    _pesoController = TextEditingController(text: widget.userData['peso'].toString());
    _semanasController = TextEditingController(text: widget.userData['semanas'].toString());
  }

  void _saveProfile() async {
    final updatedUserData = {
      'id': widget.userData['id'],
      'nombre': _nombreController.text,
      'apellido': _apellidoController.text,
      'email': _emailController.text,
      'edad': int.tryParse(_edadController.text) ?? 0,
      'altura': double.tryParse(_alturaController.text) ?? 0.0,
      'objetivo': _objetivoController.text,
      'peso': double.tryParse(_pesoController.text) ?? 0.0,
      'semanas': int.tryParse(_semanasController.text) ?? 0,
      'action': 'update_profile'
    };

    final url = Uri.parse('http://localhost/api.php');
    final response = await http.post(url,
        body: jsonEncode(updatedUserData),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      if (responseBody['status'] == 'success') {
        setState(() {
          widget.userData.addAll(updatedUserData);
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(responseBody['message']),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Error: " + responseBody['message']),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error de conexión con el servidor'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil de Usuario', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTextField('Nombre', _nombreController),
              _buildTextField('Apellido', _apellidoController),
              _buildTextField('Email', _emailController),
              _buildTextField('Edad', _edadController, isNumber: true),
              _buildTextField('Altura (m)', _alturaController, isNumber: true),
              _buildTextField('Objetivo', _objetivoController),
              _buildTextField('Peso (kg)', _pesoController, isNumber: true),
              _buildTextField('Semanas', _semanasController, isNumber: true),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProfile,
                child: Text('Guardar Cambios'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.blueGrey[800],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
