import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController edadController = TextEditingController();
  final TextEditingController alturaController = TextEditingController();
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController objetivoController = TextEditingController();
  final TextEditingController semanasController = TextEditingController();
  String? _selectedGender;

  Future<void> registerUser() async {
    
    if (nombreController.text.isEmpty || 
        apellidoController.text.isEmpty || 
        emailController.text.isEmpty || 
        passwordController.text.isEmpty ||
        edadController.text.isEmpty ||
        alturaController.text.isEmpty ||
        pesoController.text.isEmpty ||
        objetivoController.text.isEmpty ||
        semanasController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor complete todos los campos.')),
      );
      return;
    }

    final response = await http.post(
      Uri.parse('http://localhost/api.php'), 
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'action': 'registrar',
        'nombre': nombreController.text,
        'apellido': apellidoController.text,
        'genero': _selectedGender ?? 'masculino',
        'email': emailController.text,
        'password': passwordController.text,
        'edad': edadController.text,
        'altura': alturaController.text,
        'peso': pesoController.text,
        'objetivo': objetivoController.text,
        'semanas': semanasController.text,
      }),
    );

    
    if (response.statusCode != 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error de conexión: ${response.statusCode}')),
      );
      return;
    }

    final data = json.decode(response.body);

    if (data['status'] == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registro exitoso!')),
      );
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${data['message']}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/background.jpg',
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'REGISTRO',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  Text('Nombre', style: TextStyle(color: Colors.white, fontSize: 16)),
                  TextField(
                    controller: nombreController,
                    decoration: InputDecoration(fillColor: Colors.white, filled: true, hintText: 'Ingrese su nombre', border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 10),
                  Text('Apellido', style: TextStyle(color: Colors.white, fontSize: 16)),
                  TextField(
                    controller: apellidoController,
                    decoration: InputDecoration(fillColor: Colors.white, filled: true, hintText: 'Ingrese su apellido', border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 10),
                  Text('Género', style: TextStyle(color: Colors.white, fontSize: 16)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: RadioListTile<String>(
                          title: Text('Hombre', style: TextStyle(color: Colors.white)),
                          value: 'masculino',
                          groupValue: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value;
                            });
                          },
                          activeColor: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          title: Text('Mujer', style: TextStyle(color: Colors.white)),
                          value: 'femenino',
                          groupValue: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value;
                            });
                          },
                          activeColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text('Correo Electrónico', style: TextStyle(color: Colors.white, fontSize: 16)),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(fillColor: Colors.white, filled: true, hintText: 'Ingrese su correo electrónico', border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 10),
                  Text('Contraseña', style: TextStyle(color: Colors.white, fontSize: 16)),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(fillColor: Colors.white, filled: true, hintText: 'Ingrese su contraseña', border: OutlineInputBorder()),
                    obscureText: true,
                  ),
                  SizedBox(height: 10),
                  Text('Edad', style: TextStyle(color: Colors.white, fontSize: 16)),
                  TextField(
                    controller: edadController,
                    decoration: InputDecoration(fillColor: Colors.white, filled: true, hintText: 'Ingrese su edad', border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 10),
                  Text('Altura (metros)', style: TextStyle(color: Colors.white, fontSize: 16)),
                  TextField(
                    controller: alturaController,
                    decoration: InputDecoration(fillColor: Colors.white, filled: true, hintText: 'Ingrese su altura en metros (ej. 1.75)', border: OutlineInputBorder()),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                  ),
                  SizedBox(height: 10),
                  Text('Peso (kg)', style: TextStyle(color: Colors.white, fontSize: 16)),
                  TextField(
                    controller: pesoController,
                    decoration: InputDecoration(fillColor: Colors.white, filled: true, hintText: 'Ingrese su peso (kg)', border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 10),
                  Text('Meta', style: TextStyle(color: Colors.white, fontSize: 16)),
                  TextField(
                    controller: objetivoController,
                    decoration: InputDecoration(fillColor: Colors.white, filled: true, hintText: 'Ingrese su meta', border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 10),
                  Text('Semanas', style: TextStyle(color: Colors.white, fontSize: 16)),
                  TextField(
                    controller: semanasController,
                    decoration: InputDecoration(fillColor: Colors.white, filled: true, hintText: 'Ingrese las semanas', border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: registerUser,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    child: Text('Registrar'),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: Text('¿Ya tienes una cuenta? Inicia sesión', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
