//aca solo ira el codigo inicial de la clase venta
import 'dart:io';

class Venta {
  final String? userId;
  final String nombre;
  final String ubicacion;
  final String propietario;
  int cantidadArboles;
  int produccionAnual;
  int produccionDisponible;
  double precio;
  String imageUrl;
  File? imageFile;
  String? imagePath;

  Venta({
    this.userId,
    required this.nombre,
    required this.ubicacion,
    required this.propietario,
    required this.cantidadArboles,
    required this.produccionAnual,
    required this.produccionDisponible,
    required this.precio,
    required this.imageUrl,
    this.imageFile,
    this.imagePath,
  });
  //metodo para ver si hay publicaciones iguales
  @override
  bool operator ==(Object other) => // Sobrecarga del operador == para comparar dos publicaciones
      identical(this, other) || other is Venta && runtimeType == other.runtimeType && nombre == other.nombre && propietario == other.propietario;

  @override
  int get hashCode => nombre.hashCode ^ propietario.hashCode; // Hash code para comparar publicaciones
}
