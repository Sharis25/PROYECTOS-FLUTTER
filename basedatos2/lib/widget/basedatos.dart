
import 'package:basedatos2/basedatos/BD.dart';
import 'package:basedatos2/widget/Mostrardatos.dart';
import 'package:flutter/material.dart';

class Basedatos extends StatefulWidget{
  const Basedatos({super.key});

  @override
  State<StatefulWidget> createState() {
    return BaseDatos();
  }
}

class BaseDatos extends State<Basedatos>{

  final TextEditingController usuario = TextEditingController();
  final TextEditingController password = TextEditingController();

  void agregar() async {
    String u = usuario.text;
    String p = password.text;

    if(u.isNotEmpty && p.isNotEmpty){
      await BD().insertarUsuario(u,p);
      usuario.clear();
      password.clear();
      
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      appBar: AppBar(
        title: Text("Practica"),
        backgroundColor: const Color.fromARGB(255, 165, 170, 186),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 400,
                color: const Color.fromARGB(255, 167, 200, 228),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      TextField(
                        controller: usuario,
                        decoration: InputDecoration(
                          hintText: 'Escribe usuario:'
                        ),
                      ),
                    
                      TextField(
                        controller: password,
                        decoration: InputDecoration(
                          hintText: 'Escribe el password'
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: agregar, 
                          child: Text('aceptar'),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: (){
                            Navigator.push(
                              context, 
                              MaterialPageRoute(
                                builder: (context) => Mostrardatos(),
                              ),
                            );
                          },
                           child: Text('Mostrar Datos'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}