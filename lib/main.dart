import 'package:flutter/material.dart';
import 'pages/home.dart';  
import 'pages/input_and_text.dart';  
import 'pages/student_form.dart';
import 'pages/chatbot.dart';
import 'pages/student_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/home', 
      routes: {
        '/home': (context) => const HomeScreen(), 
        '/input_and_text': (context) => const InputAndText(),
        '/student_form': (context) => StudentForm(),
        '/student_list': (context) => StudentList(),
        '/chatbot': (context) => const ChatbotPage(), 
      },
    );
  }
}
