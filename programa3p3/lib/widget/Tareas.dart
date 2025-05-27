import 'package:flutter/material.dart';
import 'package:programa3p3/widget/Agregar.dart';
import 'package:programa3p3/widget/Mostrar.dart';

class Tareas extends StatefulWidget {
  const Tareas({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Tareas();
  }
}

class _Tareas extends State<Tareas> {
  int seleccionindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tareas',
          style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
        ),
        backgroundColor: const Color.fromARGB(255, 121, 158, 210),
      ),
      body: seleccionindex == 0 ? Agregar() : Mostrar(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_work),
            label: 'Agregar Tarea',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_work_outlined),
            label: 'Mostrar tareas',
          ),
        ],
        currentIndex: seleccionindex,
        selectedItemColor: const Color.fromARGB(255, 170, 186, 218),
        onTap: (Index) {
          setState(() {
            seleccionindex = Index;
          });
        },
      ),
    );
  }
}