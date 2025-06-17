import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screen/profile.dart';
import 'package:flutter_application_1/Screen/mercado.dart';
import 'package:flutter_application_1/Screen/produccion.dart';

Drawer obtenerMenuLateral(BuildContext context) {
  return Drawer(
    //añadir a listview al drawer. Esto asegura que el usuario pueda desplazarse
    //a través de las opciones en el cajón si no hay suficiente espacio vertical
    // para encajar todo.
    // El Drawer es un widget que se desliza desde el lado de la pantalla
    //backgroundColor: Color.fromARGB(255, 246, 252, 246),
    child: ListView(
      // Importante: eliminar cualquier relleno de la ListView
      padding: EdgeInsets.zero,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 0,
            right: 0,
            top: 22,
            bottom: 22,
          ),

          //padding: const EdgeInsets.all(4.2),
          child: const DrawerHeader(
            // Encabezado del menú lateral
            // decoration:PictureLayer.network('https://live.staticflickr.com/65535/53752621454_c14ecc01ec_b'),
            decoration: BoxDecoration( 
              image: DecorationImage(
                image: NetworkImage(
                  'https://www.reforestemos.org/content/uploads/bosque-nativo-araucaria-2.jpg',
                  
                ),
                
                fit: BoxFit.cover, // Ajusta la imagen para cubrir el contenedor
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
  );
}
