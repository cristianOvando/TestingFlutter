  import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StudentList extends StatefulWidget {
  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  List<Map<String, dynamic>> students = []; 
  bool isLoading = true; 
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchStudents();
  }

  Future<void> _fetchStudents() async {
    final url = Uri.parse('http://10.0.2.2:5001/api/students'); 

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        await Future.delayed(Duration(seconds: 2));

        if (data.isNotEmpty) {
          setState(() {
            students = data.map((student) {
              return {
                'name': student['name'] ?? 'Nombre no disponible',
                'last_name': student['last_name'] ?? 'Apellido no disponible',
              };
            }).toList();
          });
        } else {
          setState(() {
            errorMessage = 'No hay datos disponibles.';
          });
        }
      } else {
        setState(() {
          errorMessage = 'Error al obtener la lista de alumnos.';
        });
      }
    } catch (error) {
      setState(() {
        errorMessage = 'Error de conexión.';
      });
    } finally {
      setState(() {
        isLoading = false; 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Alumnos Registrados UP'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) 
          : errorMessage.isNotEmpty
          ? Center(child: Text(errorMessage)) 
          : students.isEmpty
          ? Center(child: Text('Lista Vacia, Agregue Alumnos')) 
          : ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
                '${students[index]['name']} ${students[index]['last_name']}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/student_form');
        },
        child: Icon(Icons.arrow_back),
        tooltip: 'Regresar al formulario',
      ),
    );
  }
}