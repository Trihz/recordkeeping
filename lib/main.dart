import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recordkeeping/splashscreen/splashscreen_ui.dart';

import 'AuthenticationFirebase/auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  /// Initialize Hive
  await Hive.initFlutter();
  await Hive.openBox('Gmail');
  await Hive.openBox('Date3');
  await Hive.openBox('Date6');
  await Hive.openBox('Date12');
  //await Auth().signOut();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}
