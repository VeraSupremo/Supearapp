import 'package:flutter/material.dart';

/*
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<ProfilePage> createState() => _PPstate();
}






class _PPstate extends State<ProfilePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
*/

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
            // Espacio alrededor del avatar
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                // Fila para el avatar y el nombre
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                    'https://live.staticflickr.com/65535/53752621454_c14ecc01ec_b.jpg',
                  ), // Reemplaza con la URL de la imagen
                ),
                const SizedBox(width: 16), // Espacio entre el avatar y el texto
                // Expanded permite que el texto ocupe el espacio restante
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
                            // Icons.park_outlined,
                            Icons.forest,
                            size: 16,
                            color: Colors.green,
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            '123 árboles', // Reemplaza con el número de árboles
                            style: TextStyle(fontSize: 14),
                          ),
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
