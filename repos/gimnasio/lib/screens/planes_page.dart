import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'mis_planes_page.dart'; 

class PlanesPage extends StatefulWidget {
  final int userId;

  PlanesPage({required this.userId});

  @override
  _PlanesPageState createState() => _PlanesPageState();
}

class _PlanesPageState extends State<PlanesPage> {
  List<Map<String, dynamic>> planes = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchPlanes();
  }

  Future<void> fetchPlanes() async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost/api.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'action': 'get_planes'}),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        print(jsonResponse); 
        setState(() {
          planes = jsonResponse.map((e) {
            int id = int.tryParse(e['id'].toString()) ?? 0;
            e['id'] = id;
            return {
              'id': id,
              'nombre': e['nombre'] ?? 'Nombre no disponible', 
              'duracion': e['duracion'] ?? 'Duración no disponible',
              'imagen': e['imagen'] ?? 'imagen_default.png', 
            };
          }).toList();
          loading = false;
        });
      } else {
        print('Error en la solicitud de planes: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al obtener los planes: $e');
    }
  }

  Future<void> agregarPlan(Map<String, dynamic> nuevoPlan) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost/api.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'action': 'assign_plan',
          'user_id': widget.userId,
          'plan_id': nuevoPlan['id'],
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          print('Plan agregado a Mis Planes');
          
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MisPlanesPage(userId: widget.userId),
            ),
          );
        } else {
          print('Error al agregar el plan: ${responseData['message']}');
        }
      } else {
        print('Error al agregar el plan: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al agregar el plan: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Planes de Entrenamiento',
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
        actions: [
          IconButton(
            icon: Icon(Icons.list, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MisPlanesPage(userId: widget.userId),
                ),
              );
            },
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: planes.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.grey,
                  child: ListTile(
                    title: Text(planes[index]['nombre'], style: TextStyle(color: Colors.black)),
                    subtitle: Text(planes[index]['duracion'], style: TextStyle(color: Colors.black)),
                    leading: Image.asset(
                      'assets/images/${planes[index]['imagen']}',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.image, color: Colors.black);
                      },
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        agregarPlan(planes[index]); 
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
