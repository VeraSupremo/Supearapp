//aca solo ira el codigo inicial de la clase venta

class Venta {
  final String nombre;
  final String ubicacion;
  final String propietario;
  int cantidadArboles;
  int produccionAnual;
  int produccionDisponible;
  double precio;
  final String imageUrl;

  Venta({
    required this.nombre,
    required this.ubicacion,
    required this.propietario,
    required this.cantidadArboles,
    required this.produccionAnual,
    required this.produccionDisponible,
    required this.precio,
    required this.imageUrl,
  });
}

// la clase parcela sera la base de los datos a mostrar en la app
//podria agregar uno que se llame "Produccion" para mostrar la produccion de cada parcela
//y otro que diga el nombre del dueño de la parcela