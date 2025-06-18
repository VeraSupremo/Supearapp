import 'package:flutter/material.dart';
import 'dart:io'; // Importa para manejar archivos
import 'package:flutter/services.dart'; // Importa para manejar el portapapeles
import 'package:flutter/widgets.dart'; // Importa para usar widgets básicos
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.title});

  final String title;

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  //aca ira la logica de la card que se mostrara para editar al usuario

  File? profileImage;
  //final String title;
  String username = 'Nombre de Usuario';
  String userType = 'Productor y Vendedor';
  final TextEditingController usernameController = TextEditingController();
  //funcion para seleccionar una imagen del perfil
  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        profileImage = File(pickedFile.path);
      });
    }
  }

  //funcion de las cards 0w0
  void editProfile(BuildContext context) {
    usernameController.text =
        username; // Inicializa el controlador con el nombre de usuario actual
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Edicion de Perfil'),
            content: SingleChildScrollView(
              // Permite desplazamiento si el contenido es demasiado grande
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder:
                            (context) => SafeArea(
                              // Asegura que el contenido no se superponga con la barra de estado
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    leading: const Icon(
                                      Icons.photo_library,
                                    ), // Icono para la galería
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
                      );
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          profileImage != null
                              ? FileImage(
                                profileImage!,
                              ) // Si hay una imagen seleccionada, la muestra
                              : const AssetImage('assets/pictures/p1.jpg')
                                  as ImageProvider, // Imagen por defecto
                    ),
                  ),

                  // despues de esto vendra una opcion donde se elegira que si es vendedor o productor o solo consumidor
                  const SizedBox(
                    height: 12,
                  ), // Espacio entre el avatar y el campo de texto
                  TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Nombre de Usuario',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text('Tipo de Usuario:'),
                  DropdownButton<String>(
                    // Dropdown para seleccionar el tipo de usuario
                    isExpanded: true,
                    value: userType,
                    items:
                        [
                          'Productor Vendedor',
                          'Solo Productor',
                          'Comprador',
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        userType = newValue!;
                      });
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text('Cancelar'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder:
                        (context) => AlertDialog(
                          title: const Text('¿Cancelar edicion?'),
                          content: const Text('Todos los cambios se perderán.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: const Text('Si'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('No'),
                            ),
                          ],
                        ),
                  );

                },
              ),
              ElevatedButton( child: const Text('Guardar'),
                onPressed: () {
                  setState(() {
                    username = usernameController.text;
                    // Aqui puedes agregar la logica para guardar los cambios
                    // Por ejemplo, enviar los datos a un servidor o guardarlos localmente
                  });
                  Navigator.pop(context); // Cierra el diálogo
                }
                )
            ],
          ),
    );
  }

  @override
  void initState() {
    void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  //Aqui ira el build de la card que se mostrara para editar al usuario
  @override
  Widget build(BuildContext context) {
     return ProfileView(  //cambiar por vistaprofile y arreglar las variables
      title: widget.title,
      profileImage: profileImage,
      username: username,
      onEditProfilePressed: () => editProfile(context),
    );
  }
}







class Vistaprofile extends StatelessWidget {
  final String title;
  final File? profileImage;
  final String username;
  final VoidCallback onEditProfilePressed;

  const Vistaprofile({
    super.key,
    required this.title,
    required this.profileImage,
    required this.username,
    required this.onEditProfilePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //barra superior
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary, // Cambia el color de la AppBar
        backgroundColor: const Color.fromARGB(
          255,
          20,
          100,
          22,
        ), // Cambia el color de la AppBar
        title: Text(title),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            // Padding para el espacio alrededor del avatar
            // Espacio alrededor del avatar
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                //----------------------------Fila para el avatar y el nombre
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/pictures/p1.jpg'),
                  // Reemplaza con la URL de la imagen
                ),
                const SizedBox(width: 16), // Espacio entre el avatar y el texto
                //--------------------------- Expanded permite que el texto ocupe el espacio restante
                Expanded(
                  child: Column(
                    // Columna para el nombre y los árboles
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Nombre de Usuario', // Reemplaza con el nombre del usuario
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: <Widget>[
                          const Icon(
                            Icons.forest,
                            size: 16,
                            color: Colors.green,
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            '123 árboles',
                            style: TextStyle(fontSize: 14),
                          ), // Reemplaza con el número de árboles),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                const Expanded(child: Divider(thickness: 1)),
                //aqui debe ir otro padding para el icono de la camara y la linea
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(
                    Icons.exit_to_app,
                    size: 32,
                    color: Color.fromARGB(255, 197, 1, 1),
                  ),
                ),
                const Expanded(child: Divider(thickness: 1)),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              // Lista de elementos
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.key_outlined),
                  title: const Text('Configuración de Cuenta'),
                  // Puedes agregar un onTap para la acción
                  onTap: () {
                    // Acción al tocar
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person_outline),
                  title: const Text(
                    'Editar Perfil',
                  ), //                           AQUI SE LLAMA A LA CLASE DE ALLA ARRIBA QUE EDITA EL PERFIL
                  // Puedes agregar un onTap para la acción
                  onTap: onEditProfilePressed,
                ),
                // Agrega más elementos de configuración aquí
                ListTile(
                  leading: const Icon(Icons.privacy_tip_outlined),
                  title: const Text('Privacidad'),
                  // Puedes agregar un onTap para la acción
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
