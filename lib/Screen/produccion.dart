import 'package:flutter/material.dart';
//import 'profile.dart';
//import 'mercado.dart'; // Importa la página de Mercado.
import '../entidades/creacion_parcelas.dart'; // Importa la clase de creación de parcelas
import '../entidades/parcela.dart'; // Importa la base de clase Parcela
import 'package:http/http.dart' as http; // Importa el paquete http para manejar solicitudes de red

//----------------------------------------------------Cambiar el nombre de este para que sea algo como pearMenu
// Cambiado el nombre de la clase para reflejar su propósito
class ProduccionesPage extends StatefulWidget {
  const ProduccionesPage({super.key, required this.title});

  final String title;

  @override
  State<ProduccionesPage> createState() => CreacionDeParcelas();
}

// Esta clase representa una tarjeta que muestra la información de una parcela
class ParcelaCard extends StatelessWidget {
  const ParcelaCard({super.key, required this.parcela});

  //String enlaceverificado ='';
  final Parcela parcela;
  //metodo que verificara si el enlace esta disponible

  Future<ImageProvider> getNewImage() async {
    String newUrl = parcela.imageUrl;
    try {
      final response = await http.get(Uri.parse(newUrl));
      if (response.statusCode != 200)
        {
          newUrl = "";
        }
    } catch (e) {
        newUrl = "";
      
    }

    if (newUrl.isNotEmpty) {
      return NetworkImage(newUrl);
    } else {
      return AssetImage("assets/pictures/IconoApp2.png");
    }
      //return AssetImage("assets/pictures/IconoApp2.png");
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
          //---------------------------Todo el Diseño de las cards -------------------
          FutureBuilder<ImageProvider>(
            future: getNewImage(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Container(
                  width: 100,
                  height: 100,
                  color:
                      Colors
                          .grey[200], // O un CircularProgressIndicator si prefieres
                );
              }

              final imageProvider = snapshot.data!;

              return Container(
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

          /*Container(
            //--------------------------------------------diseño de la imagen
            height: 120,
            width: double.infinity, // Ocupa todo el ancho disponible
            decoration: BoxDecoration(
              image: DecorationImage(
                image:getNewImage(),
                fit: BoxFit.cover, // Ajusta la imagen para cubrir el contenedor
              ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10.0),
              ), //Bordes redondeados en la parte superior
              color: const Color.fromARGB(
                248,
                212,
                179,
                255,
              ), // Color de fondo en caso de que la imagen no cargue
            ),
          ),
          */
          const Divider(
            height: 2,
            color: Color.fromARGB(255, 36, 116, 29),
          ), // Línea divisoria entre la imagen y el contenido

          Padding(
            padding: const EdgeInsets.all(8.0), // genera un espacio
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Usa el nombre de la parcela
                Text(
                  parcela.nombre,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),

                //------------------row sirve para mostrar los iconos y el texto en la misma fila
                //------------------por lo que al querer mostrar en dos filas debemos usar dos row
                Row(
                  //----------------------------diseño de la ubicacion
                  children: <Widget>[
                    const Icon(
                      Icons.location_on,
                      size: 12,
                      color: Color.fromARGB(255, 255, 37, 37),
                    ),
                    const SizedBox(width: 2),
                    Text(
                      parcela.ubicacion,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ), // Usa la ubicación de la parcela
                  ],
                ),

                const SizedBox(
                  height: 4,
                ), //------------------------------------------------------- Espacio entre la ubicación y la extensión

                Row(
                  //-----------------------------diseño de la cantidad de arboles
                  children: <Widget>[
                    const Icon(Icons.forest, size: 14, color: Colors.green),
                    const SizedBox(width: 2),
                    Text(
                      '${parcela.cantidadArboles} árboles',
                      style: const TextStyle(
                        fontSize: 14,
                      ), // Usa la cantidad de árboles
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Ubicación del botón
        ],
      ),
      //aqui se puede agregar un boton para ver mas detalles de la parcela o diseños bajos las cards
    );
  }
}
