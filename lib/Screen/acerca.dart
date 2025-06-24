//aqui se implementara una pestaña simple ocn informacion sobre la app para luego dar paso a una encuesta con base de datos
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/entidades/persistent.dart';
import 'package:provider/provider.dart';
import '../entidades/profile_notifier.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_application_1/entidades/database_helper.dart';
import 'package:flutter_application_1/entidades/creacionVentas.dart';
import '../entidades/cuestionario.dart';

class AcercaDe extends StatelessWidget {
  const AcercaDe({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final profileNotifier = Provider.of<ProfileNotifier>(context, listen: true);
    String username = UserPreferences.getUsername();
    final profileImage = UserPreferences.getProfileImage();

    return Scaffold(
      appBar: AppBar(title: const Text('Acerca de')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: const AssetImage(
                'assets/pictures/userphoto.png',
              ),
            ),
            SizedBox(height: 16),
            AutoSizeText(
              'Martin Vera',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Bienvenido a SUPEARAPP, una aplicación dedicada a la producción agricola rural creada con la finalidad de promover un comercio colaborativo entre los campesinos.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 18),
            Text(
              'Si quieres valorarnos y darnos tu opinion agradeceriamos que presiones el boton de ahi abajo.',
              style: TextStyle(fontSize: 10),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Aquí puedes implementar la lógica para abrir una encuesta o formulario
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CuestionarioPage(),
                  ),
                );
              },
              child: Text('Participar en la encuesta'),
            ),
          ],
        ),
      ),
    );
  }
}
