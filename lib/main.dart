import 'package:flutter/material.dart';
//import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'Screen/produccion.dart';
import 'Screen/splash.dart';
import 'themes/util.dart';
import 'themes/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
   Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    TextTheme texTheme = createTextTheme(context, 'Josefin Sans', 'Notable');
    MaterialTheme theme = MaterialTheme(texTheme);
    return MaterialApp(
      title: 'SUPEARAPP',
      theme: brightness == Brightness.light? theme.light():theme.dark(), //cambia el tema de acrde al modo del selu 
      home: const SplashPref(title: 'SUPEARAPP'),
    );
  }
}
