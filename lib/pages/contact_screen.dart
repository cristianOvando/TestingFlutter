import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, Map<String, String>> teamMembers = {
      'Miembro1': {
        'name': 'Yahir Alberto Albores Madrigal',
        'phone': '9613234438',
      },
      'Miembro2': {
        'name': 'Carlos Hiram Culebro Mendez',
        'phone': '9613321460'
      },
      'Miembro3': {
        'name': 'Carlos Eduardo Chanona Aquino',
        'phone': '9614309361'
      },
    };

    final List<Widget> teamMembersList = teamMembers.entries.map((entry) {
      return ListTile(
          subtitle: Text(entry.value['name'] ?? '',
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.greenAccent),
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.orange.withOpacity(0.1),
                ),
                child: IconButton(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  icon: const Icon(Icons.phone),
                  onPressed: () async {
                    final phoneNumber = Uri.parse('tel:${entry.value['phone']}');
                    if (await canLaunchUrl(phoneNumber)) {
                      await launchUrl(phoneNumber);
                    } else {
                      throw 'Could not launch $phoneNumber';
                    }
                  },
                ),
              ),

              const SizedBox(width: 10),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightGreen),
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.orange.withOpacity(0.1),
                ),

                child: IconButton(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  icon: const Icon(Icons.message),
                  onPressed: () async {
                    final menssageNumber = Uri.parse('sms:${entry.value['phone']}');
                    if (await launchUrl(menssageNumber)) {
                      await launchUrl(menssageNumber);
                    } else {
                      throw 'Could not launch $menssageNumber';
                    }
                  },
                ),


              )
            ],
          ));
    }).toList();

    return Scaffold(
        body: Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Equipo de Desarrollo',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 25),
            Column(
              children: teamMembersList,
            ),

          ]),
    ));
  }
}
