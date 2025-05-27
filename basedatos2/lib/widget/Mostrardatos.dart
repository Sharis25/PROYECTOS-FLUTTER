import 'package:flutter/material.dart';
import 'package:basedatos2/basedatos/BD.dart';

class Mostrardatos extends StatefulWidget {

  @override
  Lista createState() => Lista();

}

class Lista extends State<Mostrardatos> {
  List<Map<String, dynamic>> usuarios = [];

  @override
  
  void initState() {
    super.initState();
    obtenerUsuarios();
  }

  void obtenerUsuarios() async {
    List<Map<String, dynamic>> datos = await BD().obtenerUsuarios();
    setState(() {
      usuarios = datos;
    });
  }

  void EliminarUsuarios(int id, String usu) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Alerta'),
            content: Text('Deseas eliminar el usuario \n Eliminar $usu'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Eliminar(id);
                  Navigator.pop(context);

                },
                child: const Text('SI'),
              ),
            ],
          );
        });
    
  }

  void Eliminar(int id) async {
    await BD().EliminarUsuario(id);
    obtenerUsuarios();
  }

  void ModificarUsuario(int id, String usu, String pass) {

    final TextEditingController u = TextEditingController(text: usu);
    final TextEditingController p = TextEditingController(text: pass);

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Modificar Datos'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Text(
                  '$id',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),

                SizedBox(
                  child: TextField(
                    controller: u,
                    decoration: InputDecoration(
                      labelText: '$usu',
                    ),
                  ),
                ),

                TextField(
                  controller: p,
                  decoration: InputDecoration(
                    labelText: '$pass',
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () async {
                  await BD().ModificarUsuario(id, u.text, p.text);
                  obtenerUsuarios();
                  Navigator.pop(context);
                },

                child: const Text('Modificar'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mostrar Datos ',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color.fromARGB(255, 165, 170, 186),
      ),


      body: usuarios.isEmpty
          ? Center(child: Text('Lista Vacia'))
          : ListView.builder(
              itemCount: usuarios.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.add_a_photo_outlined),
                  title: Text(usuarios[index]['usuario']),
                  subtitle: Text(usuarios[index]['password']),
                  trailing: Wrap(
                    direction: Axis.vertical,
                    spacing: 5,

                    children: [
                      IconButton(
                        onPressed: () {
                          EliminarUsuarios(usuarios[index]['id'],
                              usuarios[index]['usuario']);
                        },
                        icon: Icon(Icons.delete),
                      ),

                      IconButton(
                        onPressed: () {
                          ModificarUsuario(
                            usuarios[index]['id'],
                            usuarios[index]['usuario'],
                            usuarios[index]['password'],
                          );
                        },
                        icon: Icon(Icons.edit),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}