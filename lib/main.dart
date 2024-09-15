import 'package:flutter/material.dart';
import 'pages/home.dart';  
import 'pages/contact_screen.dart';  
import 'pages/student_form.dart';
import 'pages/student_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MainScreen(),
      routes: {
        '/student_form': (context) => StudentForm(),
        '/student_list': (context) => StudentList(),
      },
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
    const ContactsScreen(),  
    StudentForm(),
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
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.work, color: _selectedIndex == 0 ? Colors.blue : Colors.grey),
            label: 'Mi Proyecto',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard, color: _selectedIndex == 1 ? Colors.blue : Colors.grey),
            label: 'Proyecto 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard, color: _selectedIndex == 2 ? Colors.blue : Colors.grey),
            label: 'Proyecto 2',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
