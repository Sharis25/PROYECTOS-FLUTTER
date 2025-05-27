import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BD {
  static final BD _instance = BD._internal();
  factory BD() => _instance;

  BD._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'abarrotes.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          Create table productos(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          producto TEXT NOT NULL,
          precio TEXT NOT NULL,
          cantidad TEXT NOT NULL
          )
      ''');
      },
    );
  }

  Future<int> insertarProductos(
      String producto, String precio, String cantidad) async {
    final db = await database;

    return await db.insert(
      'productos', //NOMBRE DE TABLA
      {
        'producto': producto, //CAMPOS
        'precio': precio,
        'cantidad': cantidad,
      },
    );
  }

  //RETRNAR LA BASE DE DATOS A LA TABLA USUARIOS
  Future<List<Map<String, dynamic>>> obtenerProductos() async {
    final db = await database;
    return await db.query('productos'); // SELECIONAR DATOS DE LA TABLA
  }

  //METODO ELIMINAR USUARIOS

  Future<int> EliminarProducto(String producto) async {
    final db = await database;
    return await db
        .delete('productos', where: 'producto = ?', whereArgs: [producto]);
  }
}