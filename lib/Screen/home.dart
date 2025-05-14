import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screen/profile.dart';
import 'like.dart'; // Importa la página de Like
//import 'profile.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const appTitle = 'SupearApp'; // Titulo de la app

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Index 0: Inicio', style: optionStyle),
    Text('Index 1: Usuario', style: optionStyle),
    Text('Index 2: Mercado', style: optionStyle),
  ];

  void _onItemTapped(int index) {
    //este metodo es el que se llama cuando se selecciona un elemento del menu
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: Center(child: _widgetOptions[_selectedIndex]),
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
                  color: Color.fromARGB(255, 190, 238, 144),
                  // borderRadius: BorderRadius.circular(10), // Bordes redondeados
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(radius: 50,backgroundImage: AssetImage('assets/pictures/p1.jpg'),),
                    SizedBox(height: 5), // Espacio entre el avatar y el texto
                    Text('Nombre de Usuario',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),
                    ),
                  ],
                ),
              ),
            ),

            ListTile(
              // de aqui en adelante son los elementos del menu lateral
              leading: const Icon(Icons.home_work_outlined),
              title: const Text('Inicio'),
              selected: _selectedIndex == 0,
              onTap: () {
                // Actualiza el estado de la aplicación
                //_onItemTapped(0); //------------------------------------------------------poner navegator push
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => const ProduccionesPage(
                          title: "Produccion de Arboles",
                        ),
                  ),
                );
                // Then close the drawer
                //Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_2_outlined),
              title: const Text('Usuario'),
              selected: _selectedIndex == 1,
              onTap: () {
                // Update the state of the app
                //_onItemTapped(1);//------------------------------------------------------poner navegator push
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
              selected: _selectedIndex == 2,
              onTap: () {
                // Update the state of the app
                // _onItemTapped(2);//------------------------------------------------------poner navegator push
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => const ProduccionesPage(title: "Mercado"),
                  ),
                );
                // Then close the drawer
                //Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
