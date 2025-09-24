import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// If you used `flutterfire configure` you will have this file:
import 'firebase_options.dart';

Future<void> main() async {
  // Ensure Flutter bindings are initialized (required before platform channels / Firebase)
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase. If you have firebase_options.dart use the options version,
  // otherwise just call Firebase.initializeApp() with no args.
  await Firebase.initializeApp(
    // Uncomment the next line if you generated firebase_options.dart via FlutterFire CLI
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(child: Text('App started')),
      ),
    );
  }
}
