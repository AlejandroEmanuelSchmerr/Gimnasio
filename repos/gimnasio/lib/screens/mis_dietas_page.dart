import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dieta_detail_page.dart'; 

class MisDietasPage extends StatefulWidget {
  final int userId;

  MisDietasPage({required this.userId});

  @override
  _MisDietasPageState createState() => _MisDietasPageState();
}

class _MisDietasPageState extends State<MisDietasPage> {
  List<Map<String, dynamic>> misDietas = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchMisDietas();
  }

  Future<void> fetchMisDietas() async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost/api.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'action': 'get_user_dietas',
          'user_id': widget.userId,
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        setState(() {
          misDietas = jsonResponse.map((e) {
            int id = int.tryParse(e['id']?.toString() ?? '0') ?? 0; 
            String nombre = e['nombre'] ?? 'Nombre no disponible'; 
            String tipo = e['tipo'] ?? 'Tipo no disponible'; 
            String imagen = e['imagen'] ?? 'imagen_default.png'; 
            String duracion = e['duracion'] ?? '0 semanas'; 

            return {
              'id': id,
              'nombre': nombre,
              'tipo': tipo,
              'imagen': imagen,
              'duracion': duracion, 
            };
          }).toList();
          loading = false;
        });
      } else {
        print('Error al obtener Mis Dietas: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al obtener Mis Dietas: $e');
    }
  }

  Future<void> eliminarDieta(int dietaId) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost/api.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'action': 'remove_dieta',
          'user_id': widget.userId,
          'dieta_id': dietaId,
        }),
      );

      if (response.statusCode == 200) {
        
        setState(() {
          misDietas.removeWhere((dieta) => dieta['id'] == dietaId);
        });
      } else {
        print('Error al eliminar la dieta: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al eliminar la dieta: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Mis Dietas',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: misDietas.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.grey,
                  child: ListTile(
                    title: Text(
                      misDietas[index]['nombre'] ?? 'Nombre no disponible',
                      style: TextStyle(color: Colors.black),
                    ),
                    subtitle: Text(
                      '${misDietas[index]['tipo'] ?? 'Tipo no disponible'} - Duración: ${misDietas[index]['duracion'] ?? '0 semanas'}',
                      style: TextStyle(color: Colors.black),
                    ),
                    leading: Image.asset(
                      'assets/images/${misDietas[index]['imagen']}', 
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.image, color: Colors.black); 
                      },
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        eliminarDieta(misDietas[index]['id']); 
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DietaDetailPage(
                            dietaId: misDietas[index]['id'],
                            nombre: misDietas[index]['nombre'],
                            imagen: misDietas[index]['imagen'],
                            duracion: misDietas[index]['duracion'], 
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
