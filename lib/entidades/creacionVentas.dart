import 'package:flutter/material.dart';
import '../Screen/mercado.dart';
import 'venta.dart';
import 'persistent.dart';
import '../Screen/profile.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreacionDeVentas extends State<MercadoPage> {
  int selectedIndex = 0;
  late String nombreUsuario;
  
  List<Venta> get _userPublications {
    return _venta.where((venta) {
     // Verifica que tanto usuarioId como currentUsername no sean nulos
      return venta.userId != null && venta.userId == nombreUsuario;
    }).toList();
  }
  @override
  void initState() {
    super.initState();
    nombreUsuario = UserPreferences.getUsername();
  }

  // funcion para añadir nueva publicacion
  void addNewPublication() {
    // Aquí puedes implementar la lógica para añadir una nueva publicación
    // Por ejemplo, abrir un formulario para ingresar los detalles de la venta
    final nuevaPublicacion = Venta(
      nombre: "Nueva Publicación",
      ubicacion: "Ubicación",
      propietario: nombreUsuario,
      cantidadArboles: 0,
      produccionAnual: 0,
      produccionDisponible: 0,
      precio: 0.0,
      imageUrl: 'https://farmbrokers.cl/wp-content/uploads/2024/02/Foto-4.jpeg',
    );

    setState(() {
      _venta.add(nuevaPublicacion);
    });
  }

  //funcion que mostrara la interfaz de agregar publicaciones
  void showAddPublicationDialog(BuildContext context, String currentUsername) {
    final nombreController = TextEditingController();
    final ubicacionController = TextEditingController();
    final propietarioController = TextEditingController();
    final cantidadArbolesController = TextEditingController();
    final produccionAnualController = TextEditingController();
    final produccionDisponibleController = TextEditingController();
    final precioController = TextEditingController();
    File? selectedImage;

    //funcion para seleccionar una imagen
    Future<void> pickImage(ImageSource source) async {
      try {
        final pickedFile = await ImagePicker().pickImage(
          source: source,
          imageQuality: 70,
          maxWidth: 800,
          maxHeight: 800,
        );
        
        if (pickedFile != null) {
          setState(() {
            selectedImage = File(pickedFile.path);
          });
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error al seleccionar imagen: ${e.toString()}")),
          );
        }
      }
  }


    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Agregar Nueva Publicación'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  // Widget para seleccionar imagen
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => SafeArea( // Muestra un modal para seleccionar la fuente de la imagen
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                leading: const Icon(Icons.photo_library),
                                title: const Text('Galería'),
                                onTap: () {
                                  pickImage(ImageSource.gallery);
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.camera_alt),
                                title: const Text('Cámara'),
                                onTap: () {
                                  pickImage(ImageSource.camera);
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ),
                        ),
                      );
                    },
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: selectedImage != null
                          ? Image.file(selectedImage!, fit: BoxFit.cover)
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_photo_alternate, size: 50, color: Colors.grey),
                                Text('Agregar imagen', style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField( // Campo para el nombre de la parcela
                    controller: nombreController,
                    decoration: const InputDecoration(labelText: 'Nombre Parcela'),
                  ),
                  TextField(
                    controller: ubicacionController,
                    decoration: const InputDecoration(labelText: 'Ubicación'),
                  ),
                  TextField(
                    controller: propietarioController,
                    decoration: const InputDecoration(labelText: 'Nombre Propietario'),
                  ),
                  TextField(
                    controller: cantidadArbolesController,
                    decoration: const InputDecoration(
                      labelText: 'Cantidad de Árboles',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: produccionAnualController,
                    decoration: const InputDecoration(
                      labelText: 'Producción Anual (Ton)',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: produccionDisponibleController,
                    decoration: const InputDecoration(
                      labelText: 'Producción Disponible (Ton)',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: precioController,
                    decoration: const InputDecoration(
                      labelText: 'Precio por bin en CLP',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (nombreController.text.isEmpty || ubicacionController.text.isEmpty || produccionDisponibleController.text.isEmpty || precioController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar( // Muestra un mensaje de error si los campos están vacíos
                      const SnackBar(
                        content: Text('Completa todos los campos requeridos'),
                      ),
                    );
                    return;
                  }
                   String imageUrl = selectedImage != null 
                    ? 'local_image_placeholder' // Puedes subir esta imagen a un servidor después
                    : 'assets/pictures/p1.jpg';

                  final nuevaVenta = Venta(
                    userId: currentUsername,
                    nombre: nombreController.text,
                    ubicacion: ubicacionController.text,
                    propietario: currentUsername,
                    cantidadArboles: int.tryParse(cantidadArbolesController.text) ?? 0,
                    produccionAnual: (double.tryParse(produccionAnualController.text) ?? 0.0).toInt(),
                    produccionDisponible: (double.tryParse(produccionDisponibleController.text) ?? 0.0).toInt(),
                    precio: double.tryParse(precioController.text) ?? 0.0,
                    imageUrl: selectedImage != null ? '' : 'assets/pictures/p1.jpg', // URL vacía si es imagen local
                    imageFile: selectedImage, // Guarda la imagen local
                  );
                  

                  setState(() {
                    _venta.add(nuevaVenta);
                  });
                  Navigator.pop(context);
                },
                child: const Text('Guardar'),
                
              ),
            ],
          ),
    );
  }

  final List<Venta> _venta = [
    Venta(
      nombre: "Canto del Angel",
      ubicacion: "Marchigue",
      propietario: "Juan Hecheverria",
      cantidadArboles: 8500,
      produccionAnual: 1700,
      produccionDisponible: 200,
      precio: 57142.857,
      imageUrl: 'https://rastro.com/fotos3/2024/02/24/12150484_foto4.jpg',
    ),
    Venta(
      nombre: "Los Qeules",
      ubicacion: "Cauquenes",
      propietario: "Manuel Martinez",
      cantidadArboles: 720,
      produccionAnual: 144,
      produccionDisponible: 42,
      precio: 12000.000,
      imageUrl:
          'https://www.turismodeobservacion.com/media/fotografias/campo-ganadero-en-la-region-de-la-araucania-chile-72384-xl.jpg',
    ),
    Venta(
      nombre: "Las liebres",
      ubicacion: "Valparaíso",
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
      propietario: "Jostin Jimenez",
      cantidadArboles: 100,
      produccionAnual: 20,
      produccionDisponible: 2,
      precio: 571.000,
      imageUrl: 'https://www.ciperchile.cl/wp-content/uploads/campo.jpg',
    ),
    Venta(
    nombre: "Canto del Angel",
    ubicacion: "Marchigue",
    propietario: "Juan Hecheverria",
    cantidadArboles: 8500,
    produccionAnual: 1700,
    produccionDisponible: 200,
    precio: 57142.857,
    imageUrl: 'https://rastro.com/fotos3/2024/02/24/12150484_foto4.jpg',
  ),
  Venta(
    nombre: "Los Qeules",
    ubicacion: "Cauquenes",
    propietario: "Manuel Martinez",
    cantidadArboles: 720,
    produccionAnual: 144,
    produccionDisponible: 42,
    precio: 12000.000,
    imageUrl: 'https://www.turismodeobservacion.com/media/fotografias/campo-ganadero-en-la-region-de-la-araucania-chile-72384-xl.jpg',
  ),
  Venta(
    nombre: "Las liebres",
    ubicacion: "Valparaíso",
    propietario: "Martin vasquez",
    cantidadArboles: 2200,
    produccionAnual: 440,
    produccionDisponible: 3,
    precio: 857.000,
    imageUrl: 'https://andinoblob.blob.core.windows.net/media/filer_public_thumbnails/filer_public/b3/bd/b3bda1aa-bbc9-47e0-8990-ff72cf1c613f/valparaiso.jpg__1440x760_q85_subsampling-2.jpg',
  ),
  Venta(
    nombre: "Ex Fundo el Peral 2",
    ubicacion: "Parral",
    propietario: "Sergio Masias Mora",
    cantidadArboles: 100,
    produccionAnual: 20,
    produccionDisponible: 0,
    precio: 0,
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYgdQ1IXazX-c70Zwxe9Z5WC43_pdNrui1Rg&s',
  ),
  Venta(
    nombre: "El Mirador",
    ubicacion: "Paine",
    propietario: "Familia Soto",
    cantidadArboles: 5000,
    produccionAnual: 1000,
    produccionDisponible: 150,
    precio: 42857.143,
    imageUrl: 'https://listingsprod.blob.core.windows.net/ourlistings-chl/76f92bfa-04ab-464c-b2ac-ac2fe00fe12e/aaa2dae3-338c-4ddc-a0cc-43cffcd5c3ea-w',
  ),
  Venta(
    nombre: "Rincón de la Patagonia",
    ubicacion: "Coyhaique",
    propietario: "Ana Luchsinger",
    cantidadArboles: 300,
    produccionAnual: 60,
    produccionDisponible: 10,
    precio: 1714.286,
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQu7tD7WtLXX4Ezt0uuKZEnMZz1N0LAUIo5_gsNNZZlCvbli68W-dY2uhTM6uNJvEIx0ww&usqp=CAU',
  ),
  Venta(
    nombre: "Viña del Viento",
    ubicacion: "Valle de Casablanca",
    propietario: "Viña Indómita",
    cantidadArboles: 12000,
    produccionAnual: 2400,
    produccionDisponible: 500,
    precio: 142857.143,
    imageUrl: 'https://www.morande.cl/web/wp-content/uploads/2022/07/MOR_CAMPO_BELEN_CASABLANCA_34-Pequeno.jpg',
  ),
  Venta(
    nombre: "Campo de Lavandas",
    ubicacion: "Futrono",
    propietario: "Isidora Amenábar",
    cantidadArboles: 8000,
    produccionAnual: 1600,
    produccionDisponible: 300,
    precio: 85714.286,
    imageUrl: 'https://ppartnersgroupstorage.blob.core.windows.net/property-files/PP-ea3a5a42676dc5ed31813989c4986348_1706112742931_dji_0237jpg.jpg',
  ),
  Venta(
    nombre: "Hacienda Las Vizcachas",
    ubicacion: "San Fernando",
    propietario: "Felipe Correa",
    cantidadArboles: 15000,
    produccionAnual: 3000,
    produccionDisponible: 800,
    precio: 228571.429,
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZTs_6mp2FqibRTVlcBN5zos1PSXOWdmDoFQ&s',
  ),
  Venta(
    nombre: "El Desierto de lo Florido",
    ubicacion: "Vallenar",
    propietario: "Comunidad Agrícola",
    cantidadArboles: 0,
    produccionAnual: 0,
    produccionDisponible: 0,
    precio: 0,
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRVeuxArXRd2ALz_ERaGUsn7ooxGIK5y8hEZw&s',
  ),
  Venta(
    nombre: "Orilla del Lago",
    ubicacion: "Frutillar",
    propietario: "Gerhard Schmidt",
    cantidadArboles: 400,
    produccionAnual: 80,
    produccionDisponible: 15,
    precio: 4285.714,
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ99d8Tta7AwUsHU26xupNwumfhnEW72S_2sQ&s',
  ),
  Venta(
    nombre: "Fundo El Cóndor",
    ubicacion: "Talca",
    propietario: "Agrícola del Maule",
    cantidadArboles: 10000,
    produccionAnual: 2000,
    produccionDisponible: 400,
    precio: 114285.714,
    imageUrl: 'https://http2.mlstatic.com/D_NQ_NP_949925-MLC85189084249_052025-O-campo-27-ha-plano-agua-pavimento-talca-vii-r.webp',
  ),
  Venta(
    nombre: "Pampa Ganadera",
    ubicacion: "Punta Arenas",
    propietario: "Estancia O'Higgins",
    cantidadArboles: 50,
    produccionAnual: 10,
    produccionDisponible: 2,
    precio: 571.429,
    imageUrl: 'https://www.google.com/url?sa=i&url=http%3A%2F%2Flanasdelgalpon.cl%2Fsite%2Fgallery%2Fvida-de-campo%2F&psig=AOvVaw0-6eBxblQuwS5yjIx09kwJ&ust=1750806767902000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCODdr87ViI4DFQAAAAAdAAAAABAE',
  ),
  Venta(
    nombre: "La Araucaria Milenaria",
    ubicacion: "Curacautín",
    propietario: "Comunidad Pehuenche",
    cantidadArboles: 300,
    produccionAnual: 60,
    produccionDisponible: 10,
    precio: 2857.143,
    imageUrl: 'https://www.cr2.cl/wp-content/uploads/2024/06/foto-1-1.jpg',
  ),
  Venta(
    nombre: "Valle del Elqui Estelar",
    ubicacion: "Vicuña",
    propietario: "Daniela Rojas",
    cantidadArboles: 3500,
    produccionAnual: 700,
    produccionDisponible: 100,
    precio: 28571.429,
    imageUrl: 'https://www.ecoturismolaserena.cl/wp-content/uploads/2016/02/valle-de-elqui-1-1-scaled.jpg',
  ),
  Venta(
    nombre: "Nativo Chiloté",
    ubicacion: "Ancud",
    propietario: "ONG Parcelas del Sur",
    cantidadArboles: 2500,
    produccionAnual: 500,
    produccionDisponible: 75,
    precio: 21428.571,
    imageUrl: 'https://www.toppropiedades.cl/imagenes/b_c1294u3380co1a8c21.jpg',
  ),
  Venta(
    nombre: "Palmar de Ocoa",
    ubicacion: "La Cruz",
    propietario: "Parque Nacional La Campana",
    cantidadArboles: 600,
    produccionAnual: 120,
    produccionDisponible: 20,
    precio: 5714.286,
    imageUrl: 'https://laderasur.com/wp-content/uploads/2019/07/jubaea.jpg',
  ),
  Venta(
    nombre: "Atardecer en Colchagua",
    ubicacion: "Santa Cruz",
    propietario: "Familia Montes",
    cantidadArboles: 7000,
    produccionAnual: 1400,
    produccionDisponible: 250,
    precio: 71428.571,
    imageUrl: 'https://www.cumbreandina.cl/img/valle_colchagua/valle_colchagua_800x533.jpg',
  ),
  Venta(
    nombre: "Lomas de Lo Aguirre",
    ubicacion: "Chanco",
    propietario: "Inversiones San Guillermo",
    cantidadArboles: 100,
    produccionAnual: 20,
    produccionDisponible: 3,
    precio: 857.143,
    imageUrl: 'https://www.farocarranza.cl/wp-content/uploads/2023/01/portada2-1.jpg',
  ),
  ];

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: selectedIndex == 1  // Tus Publicaciones
        ? ListView.builder( // Cambia a ListView.builder para mostrar las publicaciones del usuario
            padding: const EdgeInsets.all(16.0), // Añade padding para que se vea mejor
            itemCount: _userPublications.length, // Muestra solo las publicaciones del usuario actual
            itemBuilder: (context, index) {
              final venta = _userPublications[index];
              return GestureDetector(
                onTap: () => _showDetailsDialog(context, venta, editable: true),
                child: _buildEditableVentaCard(venta),
              );
            },
          )
        : ListView.builder( // Centro de ventas
            padding: const EdgeInsets.all(16.0), // Añade padding para que se vea mejor
            itemCount: _venta.length,
            itemBuilder: (context, index) {
              final venta = _venta[index];
              return GestureDetector( // Cambia a GestureDetector para manejar el tap
                onTap: () => _showDetailsDialog(context, venta),
                child: ParcelaCard(venta: venta),
              );
            },
          ),

      floatingActionButton: selectedIndex == 1
    ? FloatingActionButton(
        onPressed: () => showAddPublicationDialog(context, nombreUsuario),
        backgroundColor: const Color.fromARGB(255, 36, 116, 29),
        child: const Icon(Icons.add, color: Colors.white),
        tooltip: 'Agregar nueva publicación', // Texto que aparece al mantener presionado
      )
    : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (value) {
          if (value == 2) { // Índice del botón "Centro de Acopio"
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Página en construcción'),
                content: Text('Esta sección se encuentra actualmente en desarrollo. ¡Pronto estará disponible!'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
            return; // Evita cambiar el índice seleccionado
          }
          if (value == 1 && UserPreferences.getUserType() != UserType.productorVendedor || UserPreferences.getUserType() != UserType.soloProductor ) {
            // Índice del botón "Tus Publicaciones"
            final userType = UserPreferences.getUserType();
            if (userType != UserType.productorVendedor && userType != UserType.soloProductor) {
              showDialog(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: Text('Acceso restringido'),
                      content: Text(
                        'Solo los productores vendedores pueden acceder a esta sección',
                      ),
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
           BottomNavigationBarItem(
            icon: const Icon(
              Icons.store,
              color: Color.fromARGB(255, 190, 0, 0),
              size: 30,
            ),
            activeIcon: const Icon(
              Icons.storefront,
              color: Color.fromARGB(255, 36, 116, 29),
              size: 30,
            ),
            label: "Centro de ventas",
            backgroundColor: const Color.fromARGB(255, 190, 0, 0),
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.edit,
              color: Color.fromARGB(255, 243, 239, 7),
            ),
            activeIcon: const Icon(
              Icons.edit_note,
              color: Color.fromARGB(255, 36, 116, 29),
              size: 30,
            ),
            label: "Tus Publicaciones",
            backgroundColor: const Color.fromARGB(255, 95, 170, 88),
          ),
         
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.group,
              color: Color.fromARGB(255, 111, 0, 255),
            ),
            activeIcon: const Icon(
              Icons.group_outlined,
              color: Color.fromARGB(255, 201, 166, 233),
              size: 30,
            ),
            label: "Centro de Acopio",
            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          ),
        ],
      ),
    );
  }

  Widget buildPublicacionesUser() { //el buil lo que hace es construir la interfaz de usuario
    if (_userPublications.isEmpty) {
      return Center(
        child: Text(
          'No tienes publicaciones',
          style: TextStyle(fontSize: 20, color: Colors.grey),
        ),
      );
    }
    return ListView.builder(
      itemCount: _venta.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.all(8),
          child: ListTile(
            leading: Image.network(
              _venta[index].imageUrl,
              width: 50,
              height: 50,
            ),
            title: Text(_venta[index].nombre),
            subtitle: Text(
              '${_venta[index].produccionDisponible} Ton disponibles',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => editPublication(context, _venta[index]),
                ),
                Switch(
                  value: _venta[index].produccionDisponible > 0,
                  onChanged: (value) {
                    setState(() {
                      _venta[index].produccionDisponible = value ? 1 : 0;
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void editPublication(BuildContext context, Venta venta) {
    final cantidadProduccionController = TextEditingController(
      text: venta.produccionDisponible.toString(),
    );
    final precioController = TextEditingController(
      text: venta.precio.toString(),
    );
    // Aquí puedes implementar la lógica para editar la publicación
    // Por ejemplo, abrir un formulario para editar los detalles de la venta
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Editar Publicación'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: cantidadProduccionController,
                  decoration: InputDecoration(
                    labelText: 'Toneladas disponibles',
                  ),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: precioController,
                  decoration: InputDecoration(labelText: 'Precio por tonelada'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    double cantidad = double.parse(
                      cantidadProduccionController.text,
                    );
                    venta.produccionDisponible = cantidad.toInt();
                    venta.precio = double.parse(precioController.text);
                  });
                  Navigator.pop(context);
                },
                child: Text('Guardar'),
              ),
            ],
          ),
    );
  }
  // funcion para mostrar las publicaciones: 
  void _showDetailsDialog(BuildContext context, Venta venta, {bool editable = false}){
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text('Detalles de ${venta.nombre}'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ubicación: ${venta.ubicacion}'),
            Text('Propietario: ${venta.propietario}'),
            Text('Cantidad de Árboles: ${venta.cantidadArboles}'),
            Text('Producción Anual: ${venta.produccionAnual} Ton'),
            Text('Producción Disponible: ${venta.produccionDisponible} Ton'),
            Text('Precio por tonelada: \$${venta.precio.toStringAsFixed(2)} CLP'),
            SizedBox(height: 10),
            venta.imageFile != null
                ? Image.file(venta.imageFile!, fit: BoxFit.cover)
                : venta.imageUrl.startsWith('assets/')
                    ? Image.asset(venta.imageUrl, fit: BoxFit.cover)
                    : Image.network(venta.imageUrl, fit: BoxFit.cover),

          ],
        )
      ),
      actions: [
        if (editable)TextButton(onPressed: () {
              Navigator.pop(context);
              showAddPublicationDialog(context, venta.userId ?? '');
            },
            child: const Text('Editar'),
          ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cerrar'),
        ),
      ],
    ),
    );
  }

  //funcion para editar las publicaciones
  Widget _buildEditableVentaCard(Venta venta) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        leading: venta.imageFile != null
          ? Image.file(venta.imageFile!, width: 50, height: 50)
          : venta.imageUrl.startsWith('assets/')
              ? Image.asset(venta.imageUrl, width: 50, height: 50)
              : Image.network(venta.imageUrl, width: 50, height: 50),
        title: Text(venta.nombre),
        subtitle: Text('${venta.produccionDisponible} Ton - \$${venta.precio.toStringAsFixed(2)}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton( //Boton para editar la publicacion
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: () => editPublication(context, venta),
            ),
            Switch( // Switch para activar/desactivar la producción disponible
              activeColor: Colors.green,
              value: venta.produccionDisponible > 0,
              onChanged: (value) {
                setState(() {
                  venta.produccionDisponible = value ? 1 : 0;
                });
              },
            ),
          ],
        ),
      ),
    );
  }  
}