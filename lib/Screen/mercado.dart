//aqui va algo similar a like.dart pero en vez de ser rectangulos seran cuadrados que usaran 2 columnas, estos mostraran
// ventas de productos con la informacion del nombre del productor y del del terreno
import 'package:flutter/material.dart';

//----------------------------------------------------Cambiar el nombre de este para que sea algo como pearMenu
// Cambiado el nombre de la clase para reflejar su propósito
class MercadoPage extends StatefulWidget {
  const MercadoPage({super.key, required this.title});

  final String title;

  @override
  State<MercadoPage> createState() => _CreacionDeVentas();
}

// la clase parcela sera la base de los datos a mostrar en la app
//podria agregar uno que se llame "Produccion" para mostrar la produccion de cada parcela
//y otro que diga el nombre del dueño de la parcela
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
    // Constructor de la clase Parcela
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



// se creara la pagina para mostrar los datos de forma ordendana en una viewlist
//la conversion de arbol por cantidad de estas es de 200kg por arbol y se expresa en toneladas
//el precio se basa en la cantidad de bins disponibles y el precio por bin
//tomando en cuenta que un bin hace aprox unos 350kg
//el peso de 350kg es de 0.35 toneladas
//el precio por bin es de 100.000 pesos chilenos
class _CreacionDeVentas extends State<MercadoPage> {
  // Datos de ejemplo (reemplaza esto con tus datos reales)
  int selectedIndex = 0; //esta variable obtiene un indice desde 0 para hacer funcionar la barra de navegacion

  final List<Venta> _venta = [
    Venta(
      nombre: "Canto del Angel",
      ubicacion: "Marchigue",
      //extencionParcela: 52.8,
      propietario: "Juan Hecheverria",
      cantidadArboles:
          8500, //mas adelante la produccion se calculara en base a la cantidad de arboles y un aproximado de la edad de estos
      produccionAnual: 1700, //toneladas
      produccionDisponible: 200, //toneladas o 70 bins
      precio: 57142.857, //precio total por la cantidad de bins
      imageUrl: 'https://rastro.com/fotos3/2024/02/24/12150484_foto4.jpg',
    ),
    Venta(
      nombre: "Los Qeules",
      ubicacion: "Cauquenes",
      //extencionParcela: 1.5,
      propietario: "Manuel Martinez",
      cantidadArboles:
          720, //la media que se tomara por arbol en kilos y se pasara a toneladas sera de 200
      produccionAnual: 144,
      produccionDisponible: 42,
      precio: 12000.000,
      imageUrl:
          'https://www.turismodeobservacion.com/media/fotografias/campo-ganadero-en-la-region-de-la-araucania-chile-72384-xl.jpg',
    ),
    Venta(
      nombre: "Las liebres",
      ubicacion: "Valparaíso",
      //extencionParcela: 25.1,
      propietario: "Martin vasquez",
      cantidadArboles: 2200,
      produccionAnual: 440,
      produccionDisponible: 3,
      precio: 857.000,
      imageUrl:
          'https://andinoblob.blob.core.windows.net/media/filer_public_thumbnails/filer_public/b3/bd/b3bda1aa-bbc9-47e0-8990-ff72cf1c613f/valparaiso.jpg__1440x760_q85_subsampling-2.jpg',
    ),
    Venta(
      nombre: "Ex Fundo el Peral",
      ubicacion: "Parral",
      //extencionParcela: 10.0,
      propietario: "Sergio Masias",
      cantidadArboles: 100,
      produccionAnual: 20,
      produccionDisponible: 0,
      precio: 0,
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYgdQ1IXazX-c70Zwxe9Z5WC43_pdNrui1Rg&s',
    ),
    Venta(
      nombre: "Microlote A",
      ubicacion: "Molina",
      //extencionParcela: 0.5,
      propietario: "Gerardo jimenez",
      cantidadArboles: 100,
      produccionAnual: 20,
      produccionDisponible: 1,
      precio: 285.000,
      imageUrl:
          'https://photos.encuentra24.com/t_or_fh_m/f_auto/v1/cl/29/77/30/18/29773018_c17d9c',
    ),
    Venta(
      nombre: "Microlote b",
      ubicacion: "Molina",
      //extencionParcela: 0.5,
      propietario: "Jostin Jimenez",
      cantidadArboles: 100,
      produccionAnual: 20,
      produccionDisponible: 2,
      precio: 571.000,
      imageUrl:
          'https://www.ciperchile.cl/wp-content/uploads/campo.jpg',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    //esta es la construccion del wirdget que mostrara las parcelistas
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title), // Usa el título pasado al widget
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          16.0,
        ), // Ajusta la tarjeta para que no se vea fea
        child: ListView.builder(
          itemCount: _venta.length, // Cuenta el número de parcelas en la lista
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
                        title: Text('Detalles de ${_venta[index].nombre}'),
                        content: Text(
                          'Ubicación: ${_venta[index].ubicacion}\n'
                          'Propietario: ${_venta[index].propietario}\n'
                          //'Produccion disponible: ${_venta[index].produccionDisponible} toneladas',
                          'Precio: \$${_venta[index].precio}',
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
              child: _ParcelaCard(
                venta: _venta[index],
              ), // Pasa la parcela actual al widget de tarjeta
            );
          },
        ),
      ),

      //agregar un boton persistente para agregar una nueva parcela------------------------------------------Agregar botones estaticos para agregar ventas y otras cosas como el centro de acopio
      //persistentFooterButtons: barrapersistente,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Acción al presionar el botón flotante
          // Aquí puedes agregar la lógica para agregar una nueva parcela
          showDialog(
            context: context,
            builder:
                (context) => AlertDialog(
                  title: Text(
                    "¿Desea Vender un producto?",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  content: Text(
                    "Recuerda cotizar los valores del producto en tu zona o unirte a un centro de acopio, una vez publicada no podras editar ciertos aspectos como su ubicacion, se precavido",
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
        child: const Icon(Icons.add, color: Color.fromARGB(255, 255, 253, 253)),
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
            icon: const Icon(Icons.edit, color: Color.fromARGB(255, 243, 239, 7)),
            activeIcon: const Icon(Icons.edit_note, color: Color.fromARGB(255, 36, 116, 29),size: 30),
            label: "Tus Publicaciones",
            backgroundColor: const Color.fromARGB(255, 95, 170, 88),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.store, color:  Color.fromARGB(255, 190, 0, 0),size: 30),
            activeIcon: const Icon(Icons.storefront, color:Color.fromARGB(255, 36, 116, 29),size: 30,),
            label: "Centro de ventas",
            backgroundColor: const Color.fromARGB(255, 190, 0, 0),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.group, color: Color.fromARGB(255, 111, 0, 255)),
            activeIcon: const Icon(Icons.group_outlined, color: Color.fromARGB(255, 201, 166, 233),size: 30),
            label: "Centro de Acopio",
            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          ),
        ],
      ),
    );
  }
}

// Esta clase representa una tarjeta que muestra la información de una parcela
class _ParcelaCard extends StatelessWidget {
  const _ParcelaCard({required this.venta});

  final Venta venta;

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
          Container(
            //--------------------------------------------diseño de la imagen
            height: 120,
            width: double.infinity, // Ocupa todo el ancho disponible
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(venta.imageUrl),
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10.0),
              ), //Bordes redondeados en la parte superior
              color: const Color.fromARGB(248,212,179,255,), // Color de fondo en caso de que la imagen no cargue
            ),
          ),

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
                  venta.nombre,
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
                      venta.ubicacion,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 4,
                ), //------------------------------------------------------- Espacio entre la ubicación y la extensión

                Row(
                  //-----------------------------diseño de la cantidad de arboles
                  children: <Widget>[
                    const Icon(Icons.fire_truck, size: 14, color: Colors.green),
                    const SizedBox(width: 2),
                    Text(
                      '${venta.produccionDisponible} Ton',
                      style: const TextStyle(
                        fontSize: 14,
                      ), // Usa la cantidad de árboles
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ), //------------------------------------------------------- Espacio entre la ubicación y la extensión
                Row(
                  //----------------------------diseño de la ubicacion
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
          // Ubicación del botón
        ],
      ),
      //aqui se puede agregar un boton para ver mas detalles de la parcela o diseños bajos las cards
    );
  }
}
