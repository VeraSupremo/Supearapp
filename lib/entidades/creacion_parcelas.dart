import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screen/produccion.dart' as prod;
import 'package:flutter_application_1/Screen/produccion.dart'; // Asegúrate de importar donde se define ProduccionesPage
import 'parcela.dart';
import '/Screen/profile.dart';
import '/Screen/mercado.dart';

class CreacionDeParcelas extends State<ProduccionesPage> {
  int selectedIndex = 0;
  
  
  final List<Parcela> _parcelas = [
    Parcela(
      nombre: "Canto del Angel",
      ubicacion: "Marchigue",
      extencionParcela: 52.8,
      propietario: "Juan Hecheverria",
      cantidadArboles: 8500,
      produccionAnual: 1700,
      imageUrl: 'https://rastro.com/fotos3/2024/02/24/12150484_foto4.jpg',
    ),
    Parcela(
      nombre: "Los Qeules",
      ubicacion: "Cauquenes",
      extencionParcela: 1.5,
      propietario: "Manuel Martinez",
      cantidadArboles:
          720, //la media que se tomara por arbol en kilos y se pasara a toneladas sera de 200
      produccionAnual: 144,
      imageUrl:
          'https://www.turismodeobservacion.com/media/fotografias/campo-ganadero-en-la-region-de-la-araucania-chile-72384-xl.jpg',
    ),
    Parcela(
      nombre: "Las liebres",
      ubicacion: "Valparaíso",
      extencionParcela: 25.1,
      propietario: "Martin vasquez",
      cantidadArboles: 2200,
      produccionAnual: 440,
      imageUrl:
          'https://andinoblob.blob.core.windows.net/media/filer_public_thumbnails/filer_public/b3/bd/b3bda1aa-bbc9-47e0-8990-ff72cf1c613f/valparaiso.jpg__1440x760_q85_subsampling-2.jpg',
    ),
    Parcela(
      nombre: "Ex Fundo el Peral",
      ubicacion: "Parral",
      extencionParcela: 10.0,
      propietario: "Sergio Masias",
      cantidadArboles: 100,
      produccionAnual: 20,
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYgdQ1IXazX-c70Zwxe9Z5WC43_pdNrui1Rg&s',
    ),
    Parcela(
      nombre: "Microlote A",
      ubicacion: "Molina",
      extencionParcela: 0.5,
      propietario: "Gerardo jimenez",
      cantidadArboles: 100,
      produccionAnual: 20,
      imageUrl:
          'https://photos.encuentra24.com/t_or_fh_m/f_auto/v1/cl/29/77/30/18/29773018_c17d9c',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    //esta es la construccion del wirdget que mostrara las parcelistas
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //dependiendo de la liena que vqya primero sera el el lado en el que se mostrara
            SizedBox(
              width: 60,
              height: 60,
              child: Image.asset('assets/pictures/IconoApp.png'),
            ),
            Text(widget.title),
            SizedBox(
              width: 60,
              height: 60,
              child: Image.asset('assets/pictures/IconoApp.png'),
            ),
            // Logo de la aplicación
          ],
        ), // Usa el título pasado al widget
        backgroundColor: const Color.fromARGB(117, 20, 100, 23),      // Cambia el color de la AppBar
      ),

      //poner un texto en el appbar que diga "Producciones"
      


      

      body: Padding(
        // Padding para el espacio alrededor de la lista
        padding: const EdgeInsets.all(16.0,), // Ajusta la tarjeta para que no se vea fea
        
        child: ListView.builder(
          itemCount:
              _parcelas.length, // Cuenta el número de parcelas en la lista
          itemBuilder: (context, index) {
            // Crea una tarjeta para cada parcela

            return GestureDetector(
              // Detecta el toque en la tarjeta, para esto se usa el widget GestureDetector
              onTap: () {
                // Acción al tocar la tarjeta
                showDialog(
                  // Mostrar un diálogo al tocar la tarjeta
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: Text('Detalles de ${_parcelas[index].nombre}'),
                        content: Text(
                          'Ubicación: ${_parcelas[index].ubicacion}\n'
                          'Propietario: ${_parcelas[index].propietario}\n'
                          'Extensión: ${_parcelas[index].extencionParcela} ha\n'
                          'Producción anual: ${_parcelas[index].produccionAnual} toneladas',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Cerrar'),
                          ), // cierra el dialogo al tocar el boton
                        ],
                      ),
                );
              },
              child: prod.ParcelaCard(
                parcela: _parcelas[index],
              ), // Pasa la parcela actual al widget de tarjeta
            );
          },
        ),
      ),
      //agregar un boton flotante para agregar una nueva parcela
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Acción al presionar el botón flotante
          // Aquí puedes agregar la lógica para agregar una nueva parcela
          showDialog(
            context: context,
            builder:
                (context) => AlertDialog(
                  title: Text(
                    "¿Desea agregar una nueva parcela?",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  content: Text(
                    "Recuerda que tener en cuenta los valores de la parcela, una vez agregada no podras editar ciertos aspectos como su ubicacion o nombre, se precavido",
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Si",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ), //en todo este lugar es un mensaje que avisa si quiere crear una nueva parcela
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "No",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                  backgroundColor: Color.fromARGB(235, 248, 248, 248),
                ),
          );
        },
        backgroundColor: const Color.fromARGB(255, 36, 116, 29),
        child: const Icon(
          Icons.agriculture_outlined,
          color: Color.fromARGB(255, 255, 253, 253),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      //----------------------------------------------------------------------------------aqui ira la buttonactionbar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },

        items: [
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.edit,
              color: Color.fromARGB(255, 241, 177, 0),
            ),
            activeIcon: const Icon(
              Icons.forest_rounded,
              color: Color.fromARGB(255, 36, 116, 29),
            ),
            label: "Editar Publicaciones",
            backgroundColor: const Color.fromARGB(255, 95, 170, 88),
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.person_3,
              color: Color.fromARGB(255, 1, 85, 241),
            ),
            activeIcon: const Icon(
              Icons.person_3_outlined,
              color: Color.fromARGB(255, 36, 116, 29),
            ),
            label: "Tus Publicaciones",
            backgroundColor: const Color.fromARGB(255, 190, 0, 0),
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.delete_rounded,
              color: Color.fromARGB(255, 61, 61, 61),
            ),
            activeIcon: const Icon(
              Icons.delete_forever,
              color: Color.fromARGB(255, 158, 3, 3),
            ),
            label: "Borrar",
            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          ),
        ],
      ),
    );
  }
}