import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screen/produccion.dart' as prod;
import 'package:flutter_application_1/Screen/produccion.dart'; // Asegúrate de importar donde se define ProduccionesPage
import 'package:flutter_application_1/Screen/profile.dart';
import 'package:flutter_application_1/entidades/persistent.dart';
import 'parcela.dart';
//import '/Screen/profile.dart';
//import '/Screen/mercado.dart';
import 'menu_lateral.dart';

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
      Parcela(
    nombre: "El Mirador",
    ubicacion: "Paine",
    extencionParcela: 30.0,
    propietario: "Familia Soto",
    cantidadArboles: 5000,
    produccionAnual: 1000,
    imageUrl: 'https://listingsprod.blob.core.windows.net/ourlistings-chl/76f92bfa-04ab-464c-b2ac-ac2fe00fe12e/aaa2dae3-338c-4ddc-a0cc-43cffcd5c3ea-w',
  ),
  Parcela(
    nombre: "Rincón de la Patagonia",
    ubicacion: "Coyhaique",
    extencionParcela: 250.0,
    propietario: "Ana Luchsinger",
    cantidadArboles: 300,
    produccionAnual: 60,
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQu7tD7WtLXX4Ezt0uuKZEnMZz1N0LAUIo5_gsNNZZlCvbli68W-dY2uhTM6uNJvEIx0ww&usqp=CAU',
  ),
  Parcela(
    nombre: "Viña del Viento",
    ubicacion: "Valle de Casablanca",
    extencionParcela: 15.5,
    propietario: "Viña Indómita",
    cantidadArboles: 12000,
    produccionAnual: 2400,
    imageUrl: 'https://www.morande.cl/web/wp-content/uploads/2022/07/MOR_CAMPO_BELEN_CASABLANCA_34-Pequeno.jpg',
  ),
  Parcela(
    nombre: "Campo de Lavandas",
    ubicacion: "Futrono",
    extencionParcela: 5.0,
    propietario: "Isidora Amenábar",
    cantidadArboles: 8000,
    produccionAnual: 1600,
    imageUrl: 'https://ppartnersgroupstorage.blob.core.windows.net/property-files/PP-ea3a5a42676dc5ed31813989c4986348_1706112742931_dji_0237jpg.jpg',
  ),
  Parcela(
    nombre: "Hacienda Las Vizcachas",
    ubicacion: "San Fernando",
    extencionParcela: 120.0,
    propietario: "Felipe Correa",
    cantidadArboles: 15000,
    produccionAnual: 3000,
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZTs_6mp2FqibRTVlcBN5zos1PSXOWdmDoFQ&s',
  ),
  Parcela(
    nombre: "El Desierto de lo Florido",
    ubicacion: "Vallenar",
    extencionParcela: 500.0,
    propietario: "Comunidad Agrícola",
    cantidadArboles: 0,
    produccionAnual: 0,
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRVeuxArXRd2ALz_ERaGUsn7ooxGIK5y8hEZw&s',
  ),
  Parcela(
    nombre: "Orilla del Lago",
    ubicacion: "Frutillar",
    extencionParcela: 8.2,
    propietario: "Gerhard Schmidt",
    cantidadArboles: 400,
    produccionAnual: 80,
    imageUrl:'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ99d8Tta7AwUsHU26xupNwumfhnEW72S_2sQ&s' ,
  ),
  Parcela(
    nombre: "Fundo El Cóndor",
    ubicacion: "Talca",
    extencionParcela: 75.0,
    propietario: "Agrícola del Maule",
    cantidadArboles: 10000,
    produccionAnual: 2000,
    imageUrl: 'https://http2.mlstatic.com/D_NQ_NP_949925-MLC85189084249_052025-O-campo-27-ha-plano-agua-pavimento-talca-vii-r.webp',
  ),
  Parcela(
    nombre: "Pampa Ganadera",
    ubicacion: "Punta Arenas",
    extencionParcela: 1500.0,
    propietario: "Estancia O'Higgins",
    cantidadArboles: 50,
    produccionAnual: 10,
    imageUrl: 'https://www.google.com/url?sa=i&url=http%3A%2F%2Flanasdelgalpon.cl%2Fsite%2Fgallery%2Fvida-de-campo%2F&psig=AOvVaw0-6eBxblQuwS5yjIx09kwJ&ust=1750806767902000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCODdr87ViI4DFQAAAAAdAAAAABAE',
  ),
  Parcela(
    nombre: "La Araucaria Milenaria",
    ubicacion: "Curacautín",
    extencionParcela: 18.0,
    propietario: "Comunidad Pehuenche",
    cantidadArboles: 300,
    produccionAnual: 60,
    imageUrl: 'https://www.cr2.cl/wp-content/uploads/2024/06/foto-1-1.jpg',
  ),
  Parcela(
    nombre: "Valle del Elqui Estelar",
    ubicacion: "Vicuña",
    extencionParcela: 22.0,
    propietario: "Daniela Rojas",
    cantidadArboles: 3500,
    produccionAnual: 700,
    imageUrl: 'https://www.ecoturismolaserena.cl/wp-content/uploads/2016/02/valle-de-elqui-1-1-scaled.jpg',
  ),
  Parcela(
    nombre: "Nativo Chiloté",
    ubicacion: "Ancud",
    extencionParcela: 12.5,
    propietario: "ONG Parcelas del Sur",
    cantidadArboles: 2500,
    produccionAnual: 500,
    imageUrl: 'https://www.toppropiedades.cl/imagenes/b_c1294u3380co1a8c21.jpg',
  ),
  Parcela(
    nombre: "Palmar de Ocoa",
    ubicacion: "La Cruz",
    extencionParcela: 40.0,
    propietario: "Parque Nacional La Campana",
    cantidadArboles: 600,
    produccionAnual: 120,
    imageUrl: 'https://laderasur.com/wp-content/uploads/2019/07/jubaea.jpg',
  ),
  Parcela(
    nombre: "Atardecer en Colchagua",
    ubicacion: "Santa Cruz",
    extencionParcela: 9.8,
    propietario: "Familia Montes",
    cantidadArboles: 7000,
    produccionAnual: 1400,
    imageUrl: 'https://www.cumbreandina.cl/img/valle_colchagua/valle_colchagua_800x533.jpg',
  ),
  Parcela(
    nombre: "Lomas de Lo Aguirre",
    ubicacion: "Chanco",
    extencionParcela: 55.0,
    propietario: "Inversiones San Guillermo",
    cantidadArboles: 100,
    produccionAnual: 20,
    imageUrl: 'https://www.farocarranza.cl/wp-content/uploads/2023/01/portada2-1.jpg',
  ),
  ];
  @override
  Widget build(BuildContext context) {
    //esta es la construccion del wirdget que mostrara las parcelistas
    return Scaffold(
      drawer: obtenerMenuLateral(context), // Llama a la función para obtener el menú lateral
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
        backgroundColor: const Color.fromARGB(117,20,100,23,), // Cambia el color de la AppBar
      ),
      // se creara un padding para poder mostrar las parcelas del usuario si el indice es 1

      body: selectedIndex == 1 
          ?buildUserPublications() // Aquí se muestra la lista de publicaciones del usuario
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: _parcelas.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Detalles de ${_parcelas[index].nombre}'),
                          content: Text(
                            'Ubicación: ${_parcelas[index].ubicacion}\n'
                            'Propietario: ${_parcelas[index].propietario}\n'
                            'Extensión: ${_parcelas[index].extencionParcela} ha\n'
                            'Producción anual: ${_parcelas[index].produccionAnual} toneladas',
                          ),
                          actions: [
                          /*   IconButton(onPressed: (){
                              // Aquí puedes agregar la lógica para editar la parcela
                              // Por ejemplo, navegar a una pantalla de edición
                             */
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Cerrar'),
                            ),

                          ],
                        ),
                      );
                    },
                    child: prod.ParcelaCard(
                      parcela: _parcelas[index],
                    ),
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
                 // backgroundColor: Color.fromARGB(235, 248, 248, 248),
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
              if (value == 1 && UserPreferences.getUserType() == UserType.comprador) { // Índice del botón "Tus Publicaciones"
                final userType = UserPreferences.getUserType();
                if (userType == UserType.comprador) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Acceso denegado'),
                      content: Text('No puedes acceder a esta función, solo eres un comprador.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                  return;
                }
              }
              setState(() => selectedIndex = value);
            },
            items: [
          BottomNavigationBarItem( // Primer elemento de la barra de navegación
            icon: const Icon(
              Icons.home_outlined,              
              color: Color.fromARGB(255, 214, 161, 13),

            ),
            activeIcon: const Icon(
              Icons.home,
              color: Color.fromARGB(255, 8, 145, 42), // Color del icono inactivo

            ),
            label: "Inicio",
            backgroundColor: const Color.fromARGB(255, 190, 0, 0),
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.person_3,
              color: Color.fromARGB(255, 1, 85, 241), // Color del icono inactivo
            ),
            activeIcon: const Icon(
              Icons.person_3_outlined,
              color: Color.fromARGB(255, 36, 116, 29),
            ),
            label: "Tus publicaciones",
            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          ),
        ],
      ),
    );
  }
  //Metodo para mostrar las publicaciones del usuario
    Widget buildUserPublications() {
    final userType = UserPreferences.getUserType();
    if (userType == UserType.productorVendedor || userType == UserType.soloProductor) {
      return ListView.builder(
        itemCount: _parcelas.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(_parcelas[index].nombre),
              subtitle: Text('Árboles: ${_parcelas[index].cantidadArboles}'),
              // ... más detalles de la parcela
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Detalles de ${_parcelas[index].nombre}'),
                    content: Text(
                      'Ubicación: ${_parcelas[index].ubicacion}\n'
                      'Propietario: ${_parcelas[index].propietario}\n'
                      'Extensión: ${_parcelas[index].extencionParcela} ha\n'
                      'Producción anual: ${_parcelas[index].produccionAnual} toneladas',
                    ),
                    actions: [
                      IconButton(onPressed: (){
                        // Aquí puedes agregar la lógica para editar la parcela
                        // Por ejemplo, navegar a una pantalla de edición
                        /*Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditarParcelaPage(parcela: _parcelas[index]),
                          ),
                        );*/
                      }, icon: Icon(Icons.edit_outlined, color: Colors.blue)),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cerrar'),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      );
    } else {
      return Center(
        //child: Text('No tienes permisos para ver esta sección'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.block, size: 50, color: Colors.red),
            SizedBox(height: 20),
            Text('No tienes permisos para ver esta sección',
              style: TextStyle(fontSize: 18)),
          ],
        ),
      ); 
    }
  }

}
