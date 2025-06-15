class Parcela {
  final String nombre;
  final String ubicacion;
  final double extencionParcela;
  final String propietario;
  int cantidadArboles;
  int produccionAnual;
  final String imageUrl;

  Parcela({
    required this.nombre,
    required this.ubicacion,
    required this.extencionParcela,
    required this.propietario,
    required this.cantidadArboles,
    required this.produccionAnual,
    required this.imageUrl,
  });
}