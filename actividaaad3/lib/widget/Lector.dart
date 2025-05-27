import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class Lector extends StatefulWidget {
  const Lector({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Lector();
  }
}

class _Lector extends State<Lector> {
  bool ventana = false;

  void MostrarDatos(String numeros) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Dato QR'),
          content: SizedBox(
            width: 300,
            height: 100,
            child: Text('Código: $numeros'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  ventana = false;
                });
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    ).then((_) =>
        ventana = false); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text(
          'Lector de QR',
          style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
        ),
        backgroundColor: Colors.blueGrey,
      ),

      
      body: MobileScanner(
        onDetect: (capture) {
          if (!ventana) {
            final codigo = capture.barcodes.first;
            final String numeros = codigo.rawValue ?? 'sin código';
            if (numeros != 'sin código') {
              ventana = true; 
              MostrarDatos(numeros);
            }
          }
        },
      ),
    );
  }
}