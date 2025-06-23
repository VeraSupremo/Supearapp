import 'package:flutter/material.dart';
import '../Screen/mercado.dart';
import 'venta.dart';
import 'persistent.dart';
import '../Screen/profile.dart';
import 'package:image_picker/image_picker.dart';
import 'database_helper.dart';
import 'dart:io';

class CreacionDeVentas extends State<MercadoPage> {
  int selectedIndex = 0;
  late String nombreUsuario;
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  

  @override
  void initState() {
    _loadPublications();
    super.initState();
    nombreUsuario = UserPreferences.getUsername();
    
  }
  List<Venta> get _userPublications {
    return _venta.where((venta) {
      // Verifica que tanto usuarioId como currentUsername no sean nulos
      return venta.userId != null && venta.userId == nombreUsuario;
    }).toList();
  }
  
  List<Venta> _venta = [];


  Future<void> _loadPublications() async {
    final publications = await _databaseHelper.getPublications();
    setState(() {
     // _venta.clear();
      _venta.addAll(publications);
    });
  }



  //funcion que mostrara la interfaz de agregar publicaciones
  void showAddPublicationDialog(BuildContext context, String currentUsername) {
    final nombreController = TextEditingController();
    final ubicacionController = TextEditingController();
    final propietarioController = TextEditingController(text: currentUsername);
    final cantidadArbolesController = TextEditingController();
    final produccionAnualController = TextEditingController();
    final produccionDisponibleController = TextEditingController();
    final precioController = TextEditingController();
    File? selectedImage;

    Future<void> pickImage(ImageSource source) async {
      try {
        final pickedFile = await ImagePicker().pickImage(source: source);
        if (pickedFile != null) {
          setState(() {
            selectedImage = File(pickedFile.path);
          });
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error al seleccionar imagen: $e")),
        );
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
                        builder:
                            (context) => SafeArea(
                              // Muestra un modal para seleccionar la fuente de la imagen
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
                      child:
                          selectedImage != null
                              ? Image.file(selectedImage!, fit: BoxFit.cover)
                              : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_photo_alternate,
                                    size: 50,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    'Agregar imagen',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    // Campo para el nombre de la parcela
                    controller: nombreController,
                    decoration: const InputDecoration(
                      labelText: 'Nombre Parcela',
                    ),
                  ),
                  TextField(
                    controller: ubicacionController,
                    decoration: const InputDecoration(labelText: 'Ubicación'),
                  ),
                  TextField(
                    controller: propietarioController,
                    decoration: const InputDecoration(
                      labelText: 'Nombre Propietario',
                    ),
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
                  if (nombreController.text.isEmpty ||
                      ubicacionController.text.isEmpty ||
                      produccionDisponibleController.text.isEmpty ||
                      precioController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      // Muestra un mensaje de error si los campos están vacíos
                      const SnackBar(
                        content: Text('Completa todos los campos requeridos'),
                      ),
                    );
                    return;
                  }
                  String imageUrl =
                      selectedImage != null
                          ? 'local_image_placeholder' // Puedes subir esta imagen a un servidor después
                          : 'assets/pictures/p1.jpg';

                  final nuevaVenta = Venta(
                    userId: currentUsername,
                    nombre: nombreController.text,
                    ubicacion: ubicacionController.text,
                    propietario: currentUsername,
                    cantidadArboles:
                        int.tryParse(cantidadArbolesController.text) ?? 0,
                    produccionAnual:
                        (double.tryParse(produccionAnualController.text) ?? 0.0)
                            .toInt(),
                    produccionDisponible:
                        (double.tryParse(produccionDisponibleController.text) ??
                                0.0)
                            .toInt(),
                    precio: double.tryParse(precioController.text) ?? 0.0,
                    imageUrl:
                        selectedImage != null
                            ? ''
                            : 'assets/pictures/p1.jpg', // URL vacía si es imagen local
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body:
          selectedIndex ==
                  1 // Tus Publicaciones
              ? ListView.builder(
                // Cambia a ListView.builder para mostrar las publicaciones del usuario
                padding: const EdgeInsets.all(
                  16.0,
                ), // Añade padding para que se vea mejor
                itemCount:
                    _userPublications
                        .length, // Muestra solo las publicaciones del usuario actual
                itemBuilder: (context, index) {
                  final venta = _userPublications[index];
                  return GestureDetector(
                    onTap:
                        () =>
                            _showDetailsDialog(context, venta, editable: true),
                    child: _buildEditableVentaCard(venta),
                  );
                },
              )
              : ListView.builder(
                // Centro de ventas
                padding: const EdgeInsets.all(
                  16.0,
                ), // Añade padding para que se vea mejor
                itemCount: _venta.length,
                itemBuilder: (context, index) {
                  final venta = _venta[index];
                  return GestureDetector(
                    // Cambia a GestureDetector para manejar el tap
                    onTap: () => _showDetailsDialog(context, venta),
                    child: ParcelaCard(venta: venta),
                  );
                },
              ),

      floatingActionButton:
          selectedIndex == 1
              ? FloatingActionButton(
                onPressed:
                    () => showAddPublicationDialog(context, nombreUsuario),
                backgroundColor: const Color.fromARGB(255, 36, 116, 29),
                child: const Icon(Icons.add, color: Colors.white),
                tooltip:
                    'Agregar nueva publicación', // Texto que aparece al mantener presionado
              )
              : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() => selectedIndex = value);

          // Solo verificar restricciones si se selecciona "Tus Publicaciones" (índice 1)
          if (value == 1) {
            final userType = UserPreferences.getUserType();
            if (userType != UserType.productorVendedor &&
                userType != UserType.soloProductor) {
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
                          onPressed: () {
                            setState(
                              () => selectedIndex = 0,
                            ); // Volver al índice 0
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
              );
              return;
            }
            _loadPublications();
          }
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

  Widget buildPublicacionesUser() {
    //el buil lo que hace es construir la interfaz de usuario
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
  void _showDetailsDialog(
    BuildContext context,
    Venta venta, {
    bool editable = false,
  }) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Detalles de ${venta.nombre}'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ubicación: ${venta.ubicacion}'),
                  Text('Propietario: ${venta.propietario}'),
                  Text('Cantidad de Árboles: ${venta.cantidadArboles}'),
                  Text('Producción Anual: ${venta.produccionAnual} Ton'),
                  Text(
                    'Producción Disponible: ${venta.produccionDisponible} Ton',
                  ),
                  Text(
                    'Precio por tonelada: \$${venta.precio.toStringAsFixed(2)} CLP',
                  ),
                  SizedBox(height: 10),
                  venta.imageFile != null
                      ? Image.file(venta.imageFile!, fit: BoxFit.cover)
                      : venta.imageUrl.startsWith('assets/')
                      ? Image.asset(venta.imageUrl, fit: BoxFit.cover)
                      : Image.network(venta.imageUrl, fit: BoxFit.cover),
                ],
              ),
            ),
            actions: [
              if (editable)
                TextButton(
                  onPressed: () {
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
        leading:
            venta.imageFile != null
                ? Image.file(venta.imageFile!, width: 50, height: 50)
                : venta.imageUrl.startsWith('assets/')
                ? Image.asset(venta.imageUrl, width: 50, height: 50)
                : Image.network(venta.imageUrl, width: 50, height: 50),
        title: Text(venta.nombre),
        subtitle: Text(
          '${venta.produccionDisponible} Ton - \$${venta.precio.toStringAsFixed(2)}',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              //Boton para editar la publicacion
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: () => editPublication(context, venta),
            ),
            Switch(
              // Switch para activar/desactivar la producción disponible
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

  
  // funcion para añadir nueva publicacion
  Future<void> addNewPublication(Venta nuevaVenta) async {
    await _databaseHelper.insertPublication(nuevaVenta);
    await _loadPublications();
  }

  //funcion para mostrar las publicaciones
  void showPublications(BuildContext context) {
    final venta = _venta[0];
    final nombreController = TextEditingController(text: venta.nombre);
    final ubicacionController = TextEditingController(text: venta.ubicacion);
    final cantidadArbolesController = TextEditingController(
      text: venta.cantidadArboles.toString(),
    );
    final produccionAnualController = TextEditingController(
      text: venta.produccionAnual.toString(),
    );
    final produccionDisponibleController = TextEditingController(
      text: venta.produccionDisponible.toString(),
    );
    final precioController = TextEditingController(
      text: venta.precio.toString(),
    );
    File? selectedImage = venta.imageFile; // Asigna la primera imagen de la lista de ventas como ejemplo

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Tus Publicaciones'),
            content:
                _userPublications.isEmpty
                    ? const Text('No tienes publicaciones')
                    : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            _userPublications.map((venta) {
                              return ListTile(
                                title: Text(venta.nombre),
                                subtitle: Text(
                                  '${venta.produccionDisponible} Ton - \$${venta.precio.toStringAsFixed(2)}',
                                ),
                                onTap:
                                    () => _showDetailsDialog(
                                      context,
                                      venta,
                                      editable: true,
                                    ),
                              );
                            }).toList(),
                      ),
                    ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cerrar'),
              ),
              /* TextButton(onPressed: () async{
            final updateVenta = Venta(
              userId: UserPreferences.getUsername(),
              nombre: nombreController.text,
              ubicacion: ubicacionController.text,
              propietario: UserPreferences.getUsername(),
              cantidadArboles: int.tryParse(cantidadArbolesController.text) ?? 0,
              produccionAnual: (double.tryParse(produccionAnualController.text) ?? 0.0).toInt(),
              produccionDisponible: (double.tryParse(produccionDisponibleController.text) ?? 0.0).toInt(),
              precio: double.tryParse(precioController.text) ?? 0.0,
              imageUrl: selectedImage != null ? '' : 'assets/pictures/p1.jpg', // URL vacía si es imagen local
              imageFile: selectedImage, // Guarda la imagen local
            );
            await _databaseHelper.updatePublication(updateVenta);
            await _loadPublications();
            Navigator.pop(context);
          }, child: const Text('Guardar Cambios')),*/
              TextButton(
                onPressed: () async {
                  if (nombreController.text.isEmpty ||
                      ubicacionController.text.isEmpty ||
                      produccionDisponibleController.text.isEmpty ||
                      precioController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Completa todos los campos requeridos'),
                      ),
                    );
                    return;
                  }

                  final nuevaVenta = Venta(
                    userId: nombreUsuario,
                    nombre: nombreController.text,
                    ubicacion: ubicacionController.text,
                    propietario: nombreUsuario,
                    cantidadArboles:
                        int.tryParse(cantidadArbolesController.text) ?? 0,
                    produccionAnual:
                        (double.tryParse(produccionAnualController.text) ?? 0.0)
                            .toInt(),
                    produccionDisponible:
                        (double.tryParse(produccionDisponibleController.text) ??
                                0.0)
                            .toInt(),
                    precio: double.tryParse(precioController.text) ?? 0.0,
                    imageUrl:
                        selectedImage != null ? '' : 'assets/pictures/p1.jpg',
                    imageFile: selectedImage,
                  );

                  await addNewPublication(nuevaVenta);
                  Navigator.pop(context);
                },
                child: const Text('Guardar'),
              ),
            ],
          ),
    );
  }
}
