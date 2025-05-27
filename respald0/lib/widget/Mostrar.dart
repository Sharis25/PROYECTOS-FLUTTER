import 'package:respald0/basedatos/BDHelper.dart';
import 'package:flutter/material.dart';

class Mostrar extends StatefulWidget{
  const Mostrar({super.key});

  @override
  State<StatefulWidget> createState() {
    return Clase();
  }
}


class Clase extends State<Mostrar>{

  List<Map<String, dynamic>> productos = [];


  void Cargardatos() async{
    final valores = await BDHelper().obtenerProductos();
    setState(() {
      productos = valores;
    });
  }

  void initState(){
    super.initState();
    Cargardatos();
  }

  void mostrarEditarProducto(Map<String, dynamic> producto) {
  final nombreController = TextEditingController(text: producto['nombre']);
  final precioController = TextEditingController(text: producto['precio'].toString());

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Editar Producto'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Código: ${producto['codigo']}'), // no editable
            TextField(
              controller: nombreController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: precioController,
              decoration: InputDecoration(labelText: 'Precio'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              final nuevoNombre = nombreController.text.trim();
              final nuevoPrecioStr = precioController.text.trim();
              if (nuevoNombre.isNotEmpty && nuevoPrecioStr.isNotEmpty) {
                final nuevoPrecio = double.tryParse(nuevoPrecioStr);
                if (nuevoPrecio != null) {
                  // Actualiza en la BD
                  BDHelper().modificarProducto(producto['codigo'], nuevoNombre, nuevoPrecio).then((_) {
                    Navigator.of(context).pop();
                    Cargardatos(); // refresca la lista
                  });
                } else {
                  // Precio inválido
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Precio inválido')),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Completa todos los campos')),
                );
              }
            },
            child: Text('Guardar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancelar'),
          ),
        ],
      );
    },
  );
}


  void EnviarEliminar(String c){
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text('Dato QR'),
          content: Text('¿Desea eliminar el dato QR?'),
          actions: [
          
            TextButton(
              onPressed: (){
                enviarAeliminar(c);
                Navigator.pop(context);
              },
               child: Text('Si'),
              ),
            TextButton
            (onPressed: () => Navigator.pop(context),
             child: Text('No'))
          ],
        );
       }
    );
  }

  void enviarAeliminar(String codigo) async{
    await BDHelper().EliminarProducto(codigo);
    Cargardatos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(
        title: Text('Mostrar datos'),
        backgroundColor: const Color.fromARGB(255, 107, 131, 161),
      ),



      body: productos.isEmpty
        ?Center(child: Text('No tienes productos jeje'))
        :ListView.builder(
          itemCount: productos.length,
          itemBuilder: (context, index) {
            final producto = productos[index];
            return ListTile(
              title: Text('Codigo ${producto['codigo']}'),
              subtitle: Text('Nombre ${producto['nombre']}'),
              trailing: Wrap(
                direction: Axis.vertical,
                children:[ 
                  IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                mostrarEditarProducto(producto);
                },
                ),
                  Text('Precio ${producto['precio']}'),
                  IconButton(
                onPressed: (){
                    EnviarEliminar(producto['codigo']);
                },
                 icon: Icon(Icons.delete)
                 ),
                ],
              ),

            );
          }
        )
      );
     
  }

}