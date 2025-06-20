import 'package:flutter/material.dart';
import 'package:flutter_application_1/entidades/persistent.dart';
//import 'package:flutter_native_splash/flutter_native_splash.dart';
//import 'Screen/produccion.dart';
import 'Screen/splash.dart';
import 'themes/util.dart';
import 'themes/theme.dart';
import 'entidades/persistent.dart';
import 'entidades/profile_notifier.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Necesario para async en main()
  await UserPreferences.init(); // ¡Carga los datos del pueblo!
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileNotifier()),
      ],
      child: MyApp(),
    ),
  );
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
