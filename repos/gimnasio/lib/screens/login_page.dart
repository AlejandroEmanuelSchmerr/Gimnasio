import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'inicio_page.dart';
import 'admin/admin_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;
  String _errorMessage = '';

  Future<void> _login() async {
    setState(() {
      _loading = true;
      _errorMessage = '';
    });

    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _loading = false;
        _errorMessage = 'Por favor ingrese su correo y contraseña.';
      });
      return;
    }

    FocusScope.of(context).unfocus();  // Cerrar teclado

    try {
      final response = await http.post(
        Uri.parse('http://localhost/api.php'),  // Cambia localhost por tu URL de servidor
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'action': 'login',
          'email': email,
          'password': password,
        }),
      ).timeout(Duration(seconds: 10), onTimeout: () {
        throw Exception('Timeout al conectar con el servidor');
      });

      if (response.statusCode != 200) {
        setState(() {
          _loading = false;
          _errorMessage = 'Error de conexión: ${response.statusCode}';
        });
        return;
      }

      final data = json.decode(response.body);

      setState(() {
        _loading = false;
      });

      if (data['status'] == 'success' && data['user_data'] != null) {
        String role = data['user_data']['role'] ?? '';

        if (role == 'admin') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AdminPage(userData: data['user_data']),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => InicioPage(userData: data['user_data']),
            ),
          );
        }
      } else {
        setState(() {
          _errorMessage = data['message'] ?? 'Error desconocido';
        });
      }
    } catch (e) {
      setState(() {
        _loading = false;
        _errorMessage = 'Error de conexión: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                color: Colors.black.withOpacity(0.85),  // Fondo negro semitransparente
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Correo Electrónico', 
                          fillColor: Colors.white, 
                          filled: true,
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Contraseña', 
                          fillColor: Colors.white, 
                          filled: true,
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: 20),
                      if (_errorMessage.isNotEmpty)
                        Text(
                          _errorMessage,
                          style: TextStyle(color: Colors.red),
                        ),
                      SizedBox(height: 20),
                      _loading
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: _loading ? null : _login,
                              child: Text('Iniciar Sesión'),
                            ),
                      SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegisterPage()),  // Navegar a RegisterPage
                          );
                        },
                        child: Text(
                          '¿No tienes cuenta? Crea una',
                          style: TextStyle(color: Colors.white),  // Texto en blanco
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
