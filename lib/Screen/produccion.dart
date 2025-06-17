import 'package:flutter/material.dart';
import 'profile.dart';
import 'mercado.dart'; // Importa la página de Mercado.
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

/*class Parcela {
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
}*/

// se creara la pagina para mostrar los datos de forma ordendana en una viewlist
/*class _CreacionDeParcelas extends State<ProduccionesPage> {
  // Datos de ejemplo (reemplaza esto con tus datos reales)
  int selectedIndex =
      0; // Variable para el índice seleccionado en el BottomNavigationBar
  final List<Parcela> _parcelas = [
    Parcela(
      nombre: "Canto del Angel",
      ubicacion: "Marchigue",
      extencionParcela: 52.8,
      propietario: "Juan Hecheverria",
      cantidadArboles:
          8500, //mas adelante la produccion se calculara en base a la cantidad de arboles y un aproximado de la edad de estos
      produccionAnual: 1700, //toneladas
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
      drawer: Drawer(
        //añadir a listview al drawer. Esto asegura que el usuario pueda desplazarse
        //a través de las opciones en el cajón si no hay suficiente espacio vertical
        // para encajar todo.
        // El Drawer es un widget que se desliza desde el lado de la pantalla
        backgroundColor: Color.fromARGB(255, 246, 252, 246),
        child: ListView(
          // Importante: eliminar cualquier relleno de la ListView
          padding: EdgeInsets.zero,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0,right: 0,top: 22,bottom: 22,),

              //padding: const EdgeInsets.all(4.2),
              child: const DrawerHeader(
                // Encabezado del menú lateral
                // decoration:PictureLayer.network('https://live.staticflickr.com/65535/53752621454_c14ecc01ec_b'),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://www.reforestemos.org/content/uploads/bosque-nativo-araucaria-2.jpg',
                    ),
                    fit:
                        BoxFit
                            .cover, // Ajusta la imagen para cubrir el contenedor
                  ),
                  color: Color.fromARGB(255, 190, 238, 144),
                  // borderRadius: BorderRadius.circular(10), // Bordes redondeados
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/pictures/p1.jpg'),
                    ),
                    SizedBox(height: 5), // Espacio entre el avatar y el texto

                    Text(
                      'Nombre de Usuario',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            /*ListTile(
              title: const Text('Produccion de los fundos'),
              onTap:(){
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProduccionesPage(title: "Produccion de los fundos",),));
              },
            ),*/
            ListTile(
              // de aqui en adelante son los elementos del menu lateral
              leading: const Icon(Icons.home_work_outlined),
              title: const Text('Inicio'),
              onTap: () {
                // Actualiza el estado de la aplicación
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_2_outlined),
              title: const Text('Usuario'),
              onTap: () {
                // Update the state of the app
                //_onItemTapped(1);//------------------------------------------------------poner navegator push
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(title: "Perfil"),
                  ),
                );
                // Then close the drawer
                //Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.store),
              title: const Text('Mercado'),
              onTap: () {
                // Update the state of the app
                // _onItemTapped(2);//------------------------------------------------------poner navegator push
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MercadoPage(title: "Mercado"),
                  ),
                );
                // Then close the drawer
                //Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

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
              child: ParcelaCard(
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
}*/
