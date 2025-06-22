// database_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'creacionVentas.dart';
import 'venta.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DatabaseHelper { // Clase para manejar la base de datos
  static final _databaseName = "publicaciones.db";
  static final _databaseVersion = 1;

  static final table = 'publicaciones'; // Nombre de la tabla

  static final columnId = 'id';
  static final columnNombre = 'nombre';
  static final columnUbicacion = 'ubicacion';
  static final columnPropietario = 'propietario';
  static final columnCantidadArboles = 'cantidadArboles';
  static final columnProduccionAnual = 'produccionAnual';
  static final columnProduccionDisponible = 'produccionDisponible';
  static final columnPrecio = 'precio';
  static final columnImageFile = 'imageFile';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnNombre TEXT NOT NULL,
        $columnUbicacion TEXT NOT NULL,
        $columnPropietario TEXT NOT NULL,
        $columnCantidadArboles INTEGER NOT NULL,
        $columnProduccionAnual INTEGER NOT NULL,
        $columnProduccionDisponible INTEGER NOT NULL,
        $columnPrecio REAL NOT NULL,
        $columnImageFile TEXT
      )
    ''');
  }

  Future<int> insertPublication(Venta venta) async {
    Database db = await database;
    return await db.insert(table, await _ventaToMap(venta));
  }

  Future<List<Venta>> getPublications() async {
    Database db = await database;
    List<Map> maps = await db.query(table);
    return maps.map((map) => _mapToVenta(map)).toList();
  }

  Future<Map<String, dynamic>> _ventaToMap(Venta venta) async {
    return {
      columnNombre: venta.nombre,
      columnUbicacion: venta.ubicacion,
      columnPropietario: venta.propietario,
      columnCantidadArboles: venta.cantidadArboles,
      columnProduccionAnual: venta.produccionAnual,
      columnProduccionDisponible: venta.produccionDisponible,
      columnPrecio: venta.precio,
      columnImageFile: venta.imagePath ?? await saveImageAndGetPath(venta.imageFile),
    };
  }

  Venta _mapToVenta(Map map) {
    return Venta(
      nombre: map[columnNombre],
      ubicacion: map[columnUbicacion],
      propietario: map[columnPropietario],
      cantidadArboles: map[columnCantidadArboles],
      produccionAnual: map[columnProduccionAnual],
      produccionDisponible: map[columnProduccionDisponible],
      precio: map[columnPrecio],
      imageUrl: map[columnImageFile] ?? '', // Manejo de imagen 
      imageFile: null, // Aquí podrías manejar la imagen si es necesario
    );
  }
  Future<int> updatePublication(Venta venta) async {
    Database db = await database;
    return await db.update(
      table,
      await _ventaToMap(venta),
      where: '$columnNombre = ? AND $columnPropietario = ?',
      whereArgs: [venta.nombre, venta.propietario],
    );
  }
  Future<int> deletePublication(int id) async {
    Database db = await database;
    return await db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
  Future<void> close() async {
    Database db = await database;
    await db.close();
  }
  Future<void> clearDatabase() async {
    Database db = await database;
    await db.delete(table);
  }
  Future<String> saveImageAndGetPath(File? imageFile) async { // Método para guardar una imagen y obtener su ruta
  if (imageFile == null || !await imageFile.exists()) return '';  
  final directory = await getApplicationDocumentsDirectory();
  final imagePath = '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
  await imageFile.copy(imagePath);
  return imagePath;
}
  Future<void> deleteImage(String imagePath) async {
    final file = File(imagePath);
    if (await file.exists()) {
      await file.delete();
    }
  }
}
