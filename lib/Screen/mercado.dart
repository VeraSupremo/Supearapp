import 'package:flutter/material.dart';
//import 'package:flutter_application_1/entidades/creacionVentas.dart';
import '/entidades/venta.dart';
import '../entidades/creacionVentas.dart';
import 'package:http/http.dart' as http;

class MercadoPage extends StatefulWidget {
  const MercadoPage({super.key, required this.title});

  final String title;

  @override
  State<MercadoPage> createState() => CreacionDeVentas();
}

class ParcelaCard extends StatelessWidget {
  const ParcelaCard({required this.venta});

  final Venta venta;
  Future<ImageProvider> getNewImage() async {
  // Si hay una imagen local, usarla
  if (venta.imageFile != null && await venta.imageFile!.exists()) {
    return FileImage(venta.imageFile!);
  }
  
  // Si es una imagen de assets
  if (venta.imageUrl.startsWith('assets/')) {
    return AssetImage(venta.imageUrl);
  }

  // Si es una URL de internet
  try {
    final response = await http.get(Uri.parse(venta.imageUrl));
    if (response.statusCode == 200) {
      return NetworkImage(venta.imageUrl);
    }
  } catch (e) {
    // Si falla, usar imagen por defecto
    debugPrint('Error cargando imagen de red: $e');
  }
  
  return AssetImage("assets/pictures/IconoApp2.png");
}







  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FutureBuilder<ImageProvider>(
            future: getNewImage(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Container(
                  width: 100,
                  height: 100,
                  color:Colors.grey[200], 
                  child: const Center(
                    child: CircularProgressIndicator( // Indicador de carga
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>( // Color verde
                        Color.fromARGB(255, 36, 116, 29),
                      ),
                    ),
                  ),
                );
              }
              if(snapshot.hasError || snapshot.data == null){
                return Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey[200],
                  child: const Center(
                    child: Icon(Icons.error, color: Colors.red), // Icono de error
                  ),
                );
              }

              final imageProvider = snapshot.data!; // Imagen obtenida de la función getNewImage
              // Retornar el contenedor con la imagen
              // Si la imagen es una URL, se mostrará una imagen de red
              return Container( // Contenedor para la imagen
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
          // Divider para separar la imagen del contenido
          const Divider(height: 2, color: Color.fromARGB(255, 36, 116, 29)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  venta.nombre,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.location_on,
                      size: 12,
                      color: Color.fromARGB(255, 255, 37, 37),
                    ),
                    const SizedBox(width: 2),
                    Text(
                      venta.ubicacion,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: <Widget>[
                    const Icon(Icons.fire_truck, size: 14, color: Colors.green),
                    const SizedBox(width: 2),
                    Text(
                      '${venta.produccionDisponible} Ton',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.money_rounded,
                      size: 32,
                      color: Color.fromARGB(239, 204, 174, 3),
                    ),
                    const SizedBox(width: 2),
                    Text('Precio: \$${venta.precio.toString()}'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
