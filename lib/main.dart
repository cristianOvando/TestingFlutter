import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const Home(),
    const OtherScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: 'Contactos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Otros',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  Future<void> _openContacts(BuildContext context, String phoneNumber) async {
    final Uri contactUri = Uri(
      scheme: 'content',
      path: 'contacts/people/1',
      queryParameters: {'phone': phoneNumber},
    );

    if (await canLaunchUrl(contactUri)) {
      await launchUrl(contactUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo abrir la aplicación de contactos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Sample contacts
    final List<Map<String, String>> _contacts = [
      {'name': 'Martín de Jesús Ochoa Espinosa', 'phone': '9651193170'},
      {'name': 'Cristian Ovando Gómez', 'phone': '9651257602'},
      {'name': 'Diego Antonio Ortiz Cruz', 'phone': '9181071656'}
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts List'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: _contacts.map((contact) {
          return ListTile(
            title: Text(contact['name']!),
            trailing: TextButton(
              onPressed: () => _openContacts(context, contact['phone']!),
              child: const Text('Open Contacts'),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class OtherScreen extends StatelessWidget {
  const OtherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Other Screen'),
      ),
      body: Center(
        child: const Text('Próximamente'),
      ),
    );
  }
}
