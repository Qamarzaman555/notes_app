import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'utils/routes/routes.dart';
import 'utils/routes/routes_name.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        colorScheme: const ColorScheme.light(
          primary: Color.fromRGBO(206, 147, 216, 1),
          onPrimary: Colors.black,
          secondary: Color.fromRGBO(244, 143, 177, 1),
          onSecondary: Colors.white,
          tertiary: Color.fromRGBO(255, 204, 128, 1),
          error: Colors.red,
          outline: Color(0xFF424242),
        ),
        appBarTheme: const AppBarTheme(backgroundColor: Colors.orange),
      ),
      initialRoute: RouteName.backgroundScreen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
