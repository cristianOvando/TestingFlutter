import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class InputAndText extends StatefulWidget {
  const InputAndText({super.key});

  @override
  State<InputAndText> createState() => _InputAndTextState();
}

class _InputAndTextState extends State<InputAndText> {
  final TextEditingController _inputController = TextEditingController();
  String _displayText = '';
  final LocalAuthentication auth = LocalAuthentication();
  bool _isFaceIDAvailable = false;

  @override
  void initState(){
    super.initState();
    _checkBiometrics();
    
  }

  //Verifica si Face ID o huella dactilar estan disponibles
  Future<void> _checkBiometrics() async {
    List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();
    if (availableBiometrics.contains(BiometricType.face)){
      setState((){
        _isFaceIDAvailable = true; //Face ID esta disponible
      });
    }
  }

  //Metodo para autenticar con Face ID o huella dactilar
  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: _isFaceIDAvailable
        ? 'Por favor ingresa con tu Face ID para enviar el texto'
        : 'Por favor ingresa con tu huella para enviar el texto', //Cambia el mensaje segun el tipo de autenticacion
        options: const AuthenticationOptions(
          biometricOnly: true,
        ),
        
        );
    }catch (e){
      print(e);
    }

    if (authenticated){
      _updateText();
    }
  }
  
 

  void _updateText() {
    setState(() {
      _displayText = _inputController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input and Text'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _inputController,
              decoration: const InputDecoration(
                labelText: 'Enter text',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _authenticate,
              child: const Text('Submit'),
            ),
            const SizedBox(height: 20),
            Container(
              width: 370,
              height: 200,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: Text(
                _displayText,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}