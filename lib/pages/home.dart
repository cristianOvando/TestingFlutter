import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Para abrir el enlace al repositorio

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String universityLogo = 'assets/images/logo_up.jpg'; 
  final String universityName = 'Universidad Politénica de Chiapas';
  final String milogo = 'assets/images/mi_foto.jpg';
  final String career = 'Ingeniería en Software';
  final String subject = 'Aplicaciones Móviles II';
  final String group = '9B';
  final String studentName = 'Martin de Jesús Ochoa Espinosa';
  final String matricula = '221254';
  final String githubUrl = 'https://github.com/cristianOvando/TestingFlutter';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información del Alumno'),
        backgroundColor: Colors.blueAccent, 
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                universityLogo,
                height: 100,
              ),
              const SizedBox(height: 20),

              Text(
                universityName,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),

              Text(
                'Carrera: $career',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
             
              Text(
                'Materia: $subject',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
       
              Text(
                'Grupo: $group',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(milogo),
              ),
              const SizedBox(height: 20),
             
              Text(
                studentName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              
              Text(
                'Matrícula: $matricula',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: () async {
                  final Uri url = Uri.parse(githubUrl);
                  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                    throw 'No se pudo abrir el enlace $url';
                  }
                },
                child: const Text('Visitar mi repositorio en GitHub'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
