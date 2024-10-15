import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'input_and_text.dart';
import 'student_form.dart';
import 'student_list.dart';
import 'chatbot.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // Controla la pestaña activa

  final List<Widget> _pages = [
    const HomeScreenContent(),
    const InputAndText(),
    StudentForm(),
    StudentList(),
    const ChatbotPage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información del Alumno'),
        backgroundColor: Colors.blueAccent,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color.fromARGB(255, 248, 0, 0),
        unselectedItemColor: const Color.fromARGB(179, 0, 0, 0),
        showUnselectedLabels: true,
        currentIndex: _currentIndex, 
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.text_fields),
            label: 'Input/Text',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Formulario',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Lista',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chatbot',
          ),
        ],
      ),
    );
  }
}

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({super.key});

  final String universityLogo = 'assets/images/logo_up.jpg';
  final String githubUrl = 'https://github.com/cristianOvando/TestingFlutter';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(universityLogo, height: 100),
            const SizedBox(height: 20),
            const Text(
              'Universidad Politécnica de Chiapas',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/mi_foto.jpg'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Martin de Jesús Ochoa Espinosa',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              '221254',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Ingería en software',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Aplicación para móviles II',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              '9B',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
    );
  }
}
