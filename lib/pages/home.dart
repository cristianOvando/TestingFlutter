import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, Map<String, String>> teamMembers = {
      'Integrante 1': {
        'name': 'Martin de Jesús Ochoa Espinosa',
        'phone': '9651193170',
      },
      'Integrante 2': {
        'name': 'Cristian Ovando Gómez',
        'phone': '9651257602'
      },
      'Integrante 3': {
        'name': 'Diego Antonio Ortiz Cruz',
        'phone': '9181071656'
      },
    };

    final List<Widget> teamMembersList = teamMembers.entries.map((entry) {
      return ListTile(
        subtitle: Text(
          entry.value['name'] ?? '',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(
                  colors: [Colors.greenAccent, Colors.lightGreen],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: IconButton(
                color: Colors.white,
                icon: const Icon(Icons.phone),
                onPressed: () async {
                  final phoneNumber = Uri.parse('tel:${entry.value['phone']}');
                  if (await canLaunchUrl(phoneNumber)) {
                    await launchUrl(phoneNumber);
                  } else {
                    throw 'No se pudo realizar la llamada';
                  }
                },
              ),
            ),
            const SizedBox(width: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(
                  colors: [Colors.orange, Colors.deepOrangeAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: IconButton(
                color: Colors.white,
                icon: const Icon(Icons.message),
                onPressed: () async {
                  final messageNumber = Uri.parse('sms:${entry.value['phone']}');
                  if (await launchUrl(messageNumber)) {
                    await launchUrl(messageNumber);
                  } else {
                    throw 'No se pudo enviar el mensaje';
                  }
                },
              ),
            ),
            const SizedBox(width: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.blueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: IconButton(
                color: Colors.white,
                icon: const Icon(Icons.web),
                onPressed: () async {
                  final url = Uri.parse('https://github.com/cristianOvando/TestingFlutter.git');
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    throw 'No se pudo abrir el perfil de GitHub';
                  }
                },
              ),
            ),
          ],
        ),
      );
    }).toList();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Mi proyecto',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 25),
            Column(
              children: teamMembersList,
            ),
          ],
        ),
      ),
    );
  }
}
