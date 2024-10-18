import 'package:firebase/pages/home_screen.dart';
import 'package:firebase/pages/list_of_student_screen.dart';
import 'package:firebase/pages/navigation_screen.dart';
import 'package:firebase/pages/register_student_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

/*void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Register());
}*/
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDiLLbun-iegk7zQUh26-K_uk9AiiTYevI",
            authDomain: "star-aera.firebaseapp.com",
            projectId: "star-aera",
            storageBucket: "star-aera.appspot.com",
            messagingSenderId: "304752004739",
            appId: "1:304752004739:web:b1755106c115644053d5b6",
            measurementId: "G-KTZYCQ46BL"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NavigationScreen(),
    );
  }
}
