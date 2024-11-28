import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../services/api_service.dart';
import 'dieta_detail_page.dart';
import 'mis_dietas_page.dart';

class DietasPage extends StatefulWidget {
  final int userId;

  DietasPage(this.userId);

  @override
  _DietasPageState createState() => _DietasPageState();
}

class _DietasPageState extends State<DietasPage> {
  List<Map<String, dynamic>> dietas = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchDietas();
  }

  Future<void> fetchDietas() async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost/api.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'action': 'get_dietas'}),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        setState(() {
          dietas = jsonResponse.map((e) {
            int id = int.tryParse(e['id'].toString()) ?? 0;
            e['id'] = id;
            return Map<String, dynamic>.from(e);
          }).toList();
          loading = false;
        });
      } else {
        print('Error en la solicitud de dietas: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al obtener las dietas: $e');
    }
  }

  Future<void> agregarADieta(Map<String, dynamic> nuevaDieta) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost/api.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'action': 'assign_dieta',
          'user_id': widget.userId,
          'dieta_id': nuevaDieta['id'],
        }),
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        if (result['status'] == 'success') {
          print('Dieta agregada a Mis Dietas');
          
          
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MisDietasPage(userId: widget.userId),
            ),
          );
        } else {
          print('Error al agregar la dieta: ${result['message']}');
        }
      } else {
        print('Error al agregar la dieta: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al agregar la dieta: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Dietas',
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
                  builder: (context) => MisDietasPage(userId: widget.userId),
                ),
              );
            },
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: dietas.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.grey,
                  child: ListTile(
                    title: Text(dietas[index]['nombre'], style: TextStyle(color: Colors.black)),
                    subtitle: Text(dietas[index]['tipo'], style: TextStyle(color: Colors.black)),
                    leading: Image.asset(
                      'assets/images/${dietas[index]['imagen']}',
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
                        agregarADieta(dietas[index]); 
                      },
                    ),
                  
                  ),
                );
              },
            ),
    );
  }
}
