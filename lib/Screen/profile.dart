import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  // Esta clase representa la página de perfil
  const ProfilePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //barra superior
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary, // Cambia el color de la AppBar
        backgroundColor: const Color.fromARGB(255,20,100,22,), // Cambia el color de la AppBar
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
                          const Icon(Icons.forest,size: 16,color: Colors.green,                          ),
                          const SizedBox(width: 4),
                          const Text('123 árboles', style: TextStyle(fontSize: 14),),// Reemplaza con el número de árboles),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(), // Línea divisoria

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
                  title: const Text('Editar Perfil'),
                  // Puedes agregar un onTap para la acción
                  onTap: () {},
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
