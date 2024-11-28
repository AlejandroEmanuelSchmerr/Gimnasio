import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DietaDetailPage extends StatefulWidget {
  final int dietaId;
  final String nombre;
  final String imagen;
  final String duracion; 

  DietaDetailPage({
    required this.dietaId,
    required this.nombre,
    required this.imagen,
    required this.duracion,
  });

  @override
  _DietaDetailPageState createState() => _DietaDetailPageState();
}

class _DietaDetailPageState extends State<DietaDetailPage> {
  Map<int, List<Map<String, dynamic>>> comidasPorSemana = {};
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchComidas();
  }

  Future<void> fetchComidas() async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost/api.php'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'action': 'get_comidas', 'dieta_id': widget.dietaId}),
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        
        // Agrupar comidas por semana
        Map<int, List<Map<String, dynamic>>> agrupadas = {};
        for (var comida in jsonResponse) {
          int semana = comida['semana'] ?? 0; 
          if (!agrupadas.containsKey(semana)) {
            agrupadas[semana] = [];
          }
          agrupadas[semana]!.add(comida as Map<String, dynamic>);
        }

        setState(() {
          comidasPorSemana = agrupadas;
          loading = false;
        });
      } else {
        throw Exception('Error al cargar las comidas');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int numeroDeSemanas = int.parse(widget.duracion.split(' ')[0]); 

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          widget.nombre,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: numeroDeSemanas,
              itemBuilder: (context, index) {
                return _buildSemanaCard(context, index + 1);
              },
            ),
    );
  }

  Widget _buildSemanaCard(BuildContext context, int semana) {
    return Card(
      color: Colors.grey,
      child: ListTile(
        title: Text('Semana $semana', style: TextStyle(color: Colors.black)),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ComidasPorSemanaPage(
                semana: semana,
                comidas: comidasPorSemana[semana] ?? [],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ComidasPorSemanaPage extends StatelessWidget {
  final int semana;
  final List<Map<String, dynamic>> comidas;

  ComidasPorSemanaPage({required this.semana, required this.comidas});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Semana $semana',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        itemCount: comidas.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.grey,
            child: ListTile(
              title: Text(
                '${comidas[index]['tipo_comida']}: ${comidas[index]['comida']} (${comidas[index]['cantidad']})',
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text(
                'Día: ${comidas[index]['dia']}',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(comidas[index]['comida']),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Ingredientes: ${comidas[index]['ingredientes']}'),
                          SizedBox(height: 10),
                          Text('Preparación: ${comidas[index]['preparacion']}'),
                        ],
                      ),
                      actions: [
                        TextButton(
                          child: Text('Cerrar'),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
