import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlanDetailPage extends StatefulWidget {
  final int planId;
  final String nombre;
  final String imagen;
  final String descripcion;
  final String duracion;

  PlanDetailPage({
    required this.planId,
    required this.nombre,
    required this.imagen,
    required this.descripcion,
    required this.duracion,
  });

  @override
  _PlanDetailPageState createState() => _PlanDetailPageState();
}

class _PlanDetailPageState extends State<PlanDetailPage> {
  Map<int, Map<String, List<dynamic>>> ejerciciosPorSemana = {};
  bool loading = true;
  int duracionSemanas = 4;

  @override
  void initState() {
    super.initState();
    duracionSemanas = _extraerSemanas(widget.duracion);
    fetchEjercicios();
  }

  int _extraerSemanas(String duracion) {
    final match = RegExp(r'(\d+)').firstMatch(duracion);
    return match != null ? int.parse(match.group(0)!) : 4;
  }

  Future<void> fetchEjercicios() async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost/api.php'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'action': 'get_ejercicios', 'plan_id': widget.planId}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        List<dynamic> ejercicios = jsonResponse['ejercicios'] ?? [];
        Map<int, Map<String, List<dynamic>>> agrupados = {};

        for (var ejercicio in ejercicios) {
          int semana = ejercicio['semana'] ?? 0;
          String dia = ejercicio['dia'] ?? 'Sin día';

          agrupados.putIfAbsent(semana, () => {});
          agrupados[semana]!.putIfAbsent(dia, () => []).add(ejercicio);
        }

        setState(() {
          ejerciciosPorSemana = agrupados;
          loading = false;
        });
      } else {
        throw Exception('Error en la conexión: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al cargar los ejercicios: $e');
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.nombre, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: List.generate(duracionSemanas, (index) {
                return _buildSemanaCard(context, index + 1);
              }),
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
              builder: (context) => EjerciciosPorSemanaPage(
                semana: semana,
                ejercicios: ejerciciosPorSemana[semana] ?? {},
              ),
            ),
          );
        },
      ),
    );
  }
}

class EjerciciosPorSemanaPage extends StatelessWidget {
  final int semana;
  final Map<String, List<dynamic>> ejercicios;

  EjerciciosPorSemanaPage({required this.semana, required this.ejercicios});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Semana $semana', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: ejercicios.entries.map((entry) {
          String dia = entry.key;
          List<dynamic> ejerciciosDelDia = entry.value;

          return Card(
            color: Colors.grey,
            child: ExpansionTile(
              title: Text(dia, style: TextStyle(color: Colors.black)),
              children: ejerciciosDelDia.map((ejercicio) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        '${ejercicio['nombre']} (Repeticiones: ${ejercicio['repeticiones']}, Series: ${ejercicio['series']})',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Column(
                      children: [
                        if (ejercicio['imagen_url'] != null) 
                          _loadImage(ejercicio['imagen_url']),
                        if (ejercicio['video_url'] != null) 
                          _loadVideo(ejercicio['video_url']),
                      ],
                    ),
                  ],
                );
              }).toList(),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _loadImage(String url) {
    return Container(
      width: double.infinity,
      height: 300,
      child: Image.asset(
        'assets/images/$url',
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _loadVideo(String url) {
    if (YoutubePlayer.convertUrlToId(url) != null) {
      final String videoId = YoutubePlayer.convertUrlToId(url)!;
      return Container(
        width: double.infinity,
        height: 300,
        child: YoutubePlayer(
          controller: YoutubePlayerController(
            initialVideoId: videoId,
            flags: YoutubePlayerFlags(autoPlay: false, mute: false),
          ),
        ),
      );
    } else {
      try {
        return Container(
          width: double.infinity,
          height: 300,
          child: VideoPlayerWidget(videoUrl: url.startsWith('http') ? url : 'assets/videos/$url'),
        );
      } catch (error) {
        return Center(
          child: Text(
            'Error al cargar el video: $error',
            style: TextStyle(color: Colors.red),
          ),
        );
      }
    }
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  VideoPlayerWidget({required this.videoUrl});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  ChewieController? _chewieController;
  bool _isVideoLoaded = false;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    if (widget.videoUrl.startsWith('http')) {
      _controller = VideoPlayerController.network(widget.videoUrl);
    } else {
      _controller = VideoPlayerController.asset(widget.videoUrl);
    }

    try {
      await _controller.initialize().then((_) {
        setState(() {
          _chewieController = ChewieController(
            videoPlayerController: _controller,
            autoPlay: false,
            looping: false,
            aspectRatio: _controller.value.aspectRatio,
            autoInitialize: true,
            allowFullScreen: true,
            allowMuting: true,
            showControls: true,
          );
          _isVideoLoaded = true;
        });
      });
    } catch (error) {
      print("Error loading video: $error");
      setState(() {
        _isError = true;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isError) {
      return Center(
        child: Text(
          'Error al cargar el video',
          style: TextStyle(color: Colors.red),
        ),
      );
    }

    if (!_isVideoLoaded) {
      return Center(child: CircularProgressIndicator());
    }

    return Chewie(controller: _chewieController!);
  }
}
