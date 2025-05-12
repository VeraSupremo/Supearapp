import 'dart:ffi';

import 'package:flutter/material.dart';

//----------------------------------------------------Cambiar el nombre de este para que sea algo como pearMenu
// Cambiado el nombre de la clase para reflejar su propósito
class ProduccionesPage extends StatefulWidget {
  const ProduccionesPage({super.key, required this.title});

  final String title;

  @override
  State<ProduccionesPage> createState() => _CreacionDeParcelas();
}

// la clase parcela sera la base de los datos a mostrar en la app
//podria agregar uno que se llame "Produccion" para mostrar la produccion de cada parcela
//y otro que diga el nombre del dueño de la parcela
class Parcela {
  final String nombre;
  final String ubicacion;
  final double extencionParcela;
  final String propietario;
  int cantidadArboles;
  int produccionAnual;
  final String imageUrl;

  Parcela({
    // Constructor de la clase Parcela
    required this.nombre,
    required this.ubicacion,
    required this.extencionParcela,
    required this.propietario,
    required this.cantidadArboles,
    required this.produccionAnual,
    required this.imageUrl,
  });
}

// se creara la pagina para mostrar los datos de forma ordendana en una viewlist
class _CreacionDeParcelas extends State<ProduccionesPage> {
  // Datos de ejemplo (reemplaza esto con tus datos reales)
  final List<Parcela> _parcelas = [
    Parcela(
      nombre: "Canto del Angel",
      ubicacion: "Marchihue",
      extencionParcela: 52.8,
      propietario: "Juan Hecheverria",
      cantidadArboles: 8500, //mas adelante la produccion se calculara en base a la cantidad de arboles y un aproximado de la edad de estos
      produccionAnual: 1700,//toneladas
      imageUrl: 'https://rastro.com/fotos3/2024/02/24/12150484_foto4.jpg',
    ),
    Parcela(
      nombre: "Los Qeules",
      ubicacion: "Cauquenes",
      extencionParcela: 1.5,
      propietario: "Manuel Martinez",
      cantidadArboles: 720,//la media que se tomara por arbol en kilos y se pasara a toneladas sera de 200
      produccionAnual: 144,
      imageUrl:'https://www.turismodeobservacion.com/media/fotografias/campo-ganadero-en-la-region-de-la-araucania-chile-72384-xl.jpg',
    ),
    Parcela(
      nombre: "Las liebres",
      ubicacion: "Valparaíso",
      extencionParcela: 25.1,
      propietario: "Martin vasquez",
      cantidadArboles: 2200,
      produccionAnual: 440,
      imageUrl:'https://andinoblob.blob.core.windows.net/media/filer_public_thumbnails/filer_public/b3/bd/b3bda1aa-bbc9-47e0-8990-ff72cf1c613f/valparaiso.jpg__1440x760_q85_subsampling-2.jpg',
    ),
    Parcela(
      nombre: "Ex Fundo el Peral",
      ubicacion: "Parral",
      extencionParcela: 10.0,
      propietario: "Sergio Masias",
      cantidadArboles: 100,
      produccionAnual: 20,
      imageUrl:'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYgdQ1IXazX-c70Zwxe9Z5WC43_pdNrui1Rg&s',
    ),
    Parcela(
      nombre: "Microlote A",
      ubicacion: "Molina",
      extencionParcela: 0.5,
      propietario: "Gerardo jimenez",
      cantidadArboles: 100,
      produccionAnual: 20,
      imageUrl:'https://photos.encuentra24.com/t_or_fh_m/f_auto/v1/cl/29/77/30/18/29773018_c17d9c',
    ),
  ];
  @override
  Widget build(BuildContext context){  //esta es la construccion del wirdget que mostrara las parcelistas
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title), // Usa el título pasado al widget
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), //ajusta la tarjeta para que no se vea fea
        child: ListView.builder(
          itemCount:
              _parcelas.length, //cuenta el numero de parcelas en la lista
          itemBuilder: (context, index){
            // Crea un constructor para cada parcela
            return _ParcelaCard(
              parcela: _parcelas[index],
            ); // Pasa la parcela actual al widget de tarjeta
          },
        ),
      ),
    );
  }
}

// Esta clase representa una tarjeta que muestra la información de una parcela
class _ParcelaCard extends StatelessWidget {
  const _ParcelaCard({required this.parcela});

  final Parcela parcela;

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
          Container( //--------------------------------------------diseño de la imagen
            height: 120,
            width: double.infinity, // Ocupa todo el ancho disponible
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(parcela.imageUrl,), fit: BoxFit.cover,),

              borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0),
              ),
            ),
          ),

          const Divider(height: 2, color: Color.fromARGB(255, 36, 116, 29)), // Línea divisoria entre la imagen y el contenido

          Padding(
            padding: const EdgeInsets.all(8.0), // genera un espacio 
            child: Column( 
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  parcela.nombre, // Usa el nombre de la parcela
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),

                //------------------row sirve para mostrar los iconos y el texto en la misma fila
                //------------------por lo que al querer mostrar en dos filas debemos usar dos row
                Row( //----------------------------diseño de la ubicacion
                  children: <Widget>[
                    const Icon(Icons.location_on, size: 12, color: Color.fromARGB(255, 255, 37, 37)),
                    const SizedBox(width: 2),
                    Text(
                      parcela.ubicacion, // Usa la ubicación de la parcela
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),

                const SizedBox(height: 4), //------------------------------------------------------- Espacio entre la ubicación y la extensión

                Row( //-----------------------------diseño de la cantidad de arboles
                  children: <Widget>[
                    const Icon(Icons.forest, size: 14, color: Colors.green),
                    const SizedBox(width: 2),
                    Text('${parcela.cantidadArboles} árboles', style: const TextStyle(fontSize: 14),// Usa la cantidad de árboles

                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      //aqui se puede agregar un boton para ver mas detalles de la parcela o diseños bajos las cards
      
    );
  }
}
