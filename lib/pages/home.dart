import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  Future<void> makePhoneCall(String phoneNumber) async {
    final PermissionStatus status = await Permission.phone.request();

    if (status.isGranted) {
      final Uri phoneNumberUrl = Uri(
        scheme: 'tel',
        path: phoneNumber,
      );
      if (await canLaunchUrl(phoneNumberUrl)) {
        await launchUrl(phoneNumberUrl);
      } else {
        print('No se pudo lanzar la llamada a $phoneNumberUrl');
        throw 'No se pudo realizar la llamada';
      }
    } else {
      print('Permiso de llamada no concedido');
      throw 'Permiso de llamada no concedido';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, Map<String, String>> teamMembers = {
      'Integrante 1': {
        'name': 'Martin de Jesús Ochoa Espinosa',
        'phone': '+529651193170',
      },
      'Integrante 2': {
        'name': 'Cristian Ovando Gómez',
        'phone': '+529651257602'
      },
      'Integrante 3': {
        'name': 'Diego Antonio Ortiz Cruz',
        'phone': '+529181071656'
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
                  try {
                    await makePhoneCall(entry.value['phone']!);
                  } catch (e) {
                    print(e);
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
                  if (await canLaunchUrl(messageNumber)) {
                    await launchUrl(messageNumber);
                  } else {
                    print('No se pudo enviar el mensaje');
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
                    print('No se pudo abrir el perfil de GitHub');
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
            Image.asset(
              'assets/images/mi_foto.jpg', // Aquí va tu imagen
              width: 100, // Ajusta el tamaño según sea necesario
              height: 100,
            ),
            const SizedBox(height: 20), // Espacio entre la imagen y el texto
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
