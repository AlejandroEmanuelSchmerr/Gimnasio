import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'plan_detail_page.dart'; 

class MisPlanesPage extends StatefulWidget {
  final int userId;

  MisPlanesPage({required this.userId});

  @override
  _MisPlanesPageState createState() => _MisPlanesPageState();
}

class _MisPlanesPageState extends State<MisPlanesPage> {
  List<Map<String, dynamic>> misPlanes = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchMisPlanes();
  }

  Future<void> fetchMisPlanes() async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost/api.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'action': 'get_user_planes',
          'user_id': widget.userId,
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        setState(() {
          misPlanes = jsonResponse.map((e) {
            int id = int.tryParse(e['id']?.toString() ?? '0') ?? 0; 
            String nombre = e['nombre'] ?? 'Nombre no disponible'; 
            String tipo = e['tipo'] ?? 'Tipo no disponible'; 
            String imagen = e['imagen'] ?? 'imagen_default.png'; 
            String duracion = e['duracion'] ?? '0 semanas'; 
            String descripcion = e['descripcion'] ?? 'Descripción no disponible'; 

            return {
              'id': id,
              'nombre': nombre,
              'tipo': tipo,
              'imagen': imagen,
              'duracion': duracion,
              'descripcion': descripcion, 
            };
          }).toList();
          loading = false;
        });
      } else {
        print('Error al obtener Mis Planes: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al obtener Mis Planes: $e');
    }
  }

  Future<void> eliminarPlan(int planId) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost/api.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'action': 'remove_plan',
          'user_id': widget.userId,
          'plan_id': planId,
        }),
      );

      if (response.statusCode == 200) {
        
        setState(() {
          misPlanes.removeWhere((plan) => plan['id'] == planId);
        });
      } else {
        print('Error al eliminar el plan: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al eliminar el plan: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Mis Planes',
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
              itemCount: misPlanes.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.grey,
                  child: ListTile(
                    title: Text(
                      misPlanes[index]['nombre'] ?? 'Nombre no disponible',
                      style: TextStyle(color: Colors.black),
                    ),
                    subtitle: Text(
                      '${misPlanes[index]['nombre'] ?? 'Tipo no disponible'} - Duración: ${misPlanes[index]['duracion'] ?? '0 semanas'}',
                      style: TextStyle(color: Colors.black),
                    ),
                    leading: Image.asset(
                      'assets/images/${misPlanes[index]['imagen']}', 
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
                        eliminarPlan(misPlanes[index]['id']);
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlanDetailPage(
                            planId: misPlanes[index]['id'],
                            nombre: misPlanes[index]['nombre'],
                            imagen: misPlanes[index]['imagen'],
                            duracion: misPlanes[index]['duracion'],
                            descripcion: misPlanes[index]['descripcion'],
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
