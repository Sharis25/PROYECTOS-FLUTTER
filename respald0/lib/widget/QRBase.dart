import 'package:respald0/basedatos/BDHelper.dart';
import 'package:respald0/widget/Mostrar.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';


class  QRBase extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Clase();
  }
}

class Clase extends State<QRBase>{

  
  bool ventana = false;

  void MostrarDatosQR(String numeros){

    String nombre = "", precio = "";

    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text('Dato QR'),
          content: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              Text('Codigo $numeros',
              style: TextStyle(
                backgroundColor: Colors.black12,
                fontSize: 18,
                fontStyle: FontStyle.italic
              ),),

              TextField(
                decoration: InputDecoration(
                  labelText: 'Nombre',
                ),
                onChanged: (value) => nombre = value,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'precio'
                ),
                onChanged: (value) => precio =value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (nombre.isNotEmpty && precio.isNotEmpty) {

                  double pre = double.parse(precio);

                  await BDHelper().insertarProducto(numeros, nombre, pre);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Productos guardados')),);
                }
                setState(() {
                  ventana = false;
                });
              }, 
              child: Text('Guardar'),
              )
          ],
        );
       }
      ).then((_) => ventana = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Aplicacion de QR con base de datos'),
        backgroundColor: const Color.fromARGB(255, 117, 149, 184),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Mostrar())
              );
            },
            icon:Icon(Icons.list),
          ),
        ],
      ),

        body: MobileScanner(
        onDetect: (capture){
          if (ventana) return;

          final codigo = capture.barcodes.first;
          final String numeros = codigo.rawValue ?? "Sin codigo";

          if(numeros != 'Sin codigo'){
            ventana = true;
            MostrarDatosQR(numeros);
          }
        }
      ),
      
    );
  }
}