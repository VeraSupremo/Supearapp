import 'package:flutter/material.dart';
import 'dart:async';
import 'produccion.dart'; // Asegúrate de que este import sea correcto según la estructura de tu proyecto.

class SplashPref extends StatefulWidget {
  const SplashPref({super.key, required this.title});
  final String title;

  @override
  State<SplashPref> createState() => _SplashPrefState();
}

class _SplashPrefState extends State<SplashPref> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ProduccionesPage(title: "SUPEARAPP")),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Obtener las dimensiones de la pantalla para hacer el diseño responsivo.
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Se calculan los tamaños de los elementos en proporción al ancho de la pantalla.
    final imageSize = screenWidth * 0.7; // La imagen ocupará el 70% del ancho.
    final titleFontSize = screenWidth * 0.15; // El título principal un 15%.
    final subtitleFontSize = screenWidth * 0.05; // El subtítulo un 5%.

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centra los widgets en el eje vertical.
          children: <Widget>[
            const Spacer(flex: 2), // Empuja el contenido hacia abajo.
            Image.asset(
              'assets/pictures/IconoApp.png',
              width: imageSize,
              height: imageSize,
              fit: BoxFit.contain, // Asegura que la imagen se escale correctamente.
            ),
            const SizedBox(height: 20),
            // FittedBox previene el desbordamiento de texto ajustando su tamaño.
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "SUPEARAPP",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 16, 138, 0),
                ),
              ),
            ),
            const SizedBox(height: 10),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Sistema de Produccion Agricola",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: subtitleFontSize,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(171, 10, 88, 0),
                  ),
                ),
              ),
            ),
            const Spacer(flex: 3), // Da más espacio en la parte inferior.
          ],
        ),
      ),
    );
  }
}
