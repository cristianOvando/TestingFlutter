import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View"),
      ),
      body: Center(
        child: TextButton(
          onPressed: () async {
            final Uri phoneUri = Uri(scheme: 'tel', path: '21213123123');
            if (await canLaunchUrl(phoneUri)) {
              await launchUrl(phoneUri);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('No se puede abrir la aplicación de teléfono')),
              );
            }
          },
          child: Text("Call me"),
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}
