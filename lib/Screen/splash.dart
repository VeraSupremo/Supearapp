import 'package:flutter/material.dart';
import 'like.dart';

class SplashPref extends StatefulWidget {
  const SplashPref({super.key, required this.title});
  final String title;

  @override
  State<SplashPref> createState() => _SplashPref();
}


class _SplashPref extends State<SplashPref> {

  @override
  void initState() {
    super.initState();
    // Agregar el pasar a otra pantalla 
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context)=> const ProduccionesPage(title: "Terrenos"),
         ),
     );
   });
  }

  Widget build(BuildContext context) {
 
    return Scaffold(

      body: Center(
       
        child: Column(
         
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image(image: AssetImage('assets/pictures/IconoApp.png'),width: 500 , height: 500,),
            Text("SUPEARAPP", style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 16, 138, 0),),),
            const SizedBox(height: 20),// Espacio entre la imagen y el texto
            const Text("Sistema de Produccion Agricola", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(171, 10, 88, 0),),),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}




