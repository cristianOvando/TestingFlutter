import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Map<String, String>> _contacts = [
    {'name': 'Martín de Jesús Ochoa Espinosa', 'phone': '9651193170'},
    {'name': 'Cristian Ovando Gómez', 'phone': '9651257602'},
    {'name': 'Diego Antonio Ortiz Cruz', 'phone': '9181071656'}
  ];

  // Función para hacer la llamada
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo realizar la llamada')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (var contact in _contacts)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(contact['name']!),
                  ),
                  IconButton(
                    icon: const Icon(Icons.phone),
                    onPressed: () {
                      _makePhoneCall(contact['phone']!);
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
