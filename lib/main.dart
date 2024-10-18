import 'package:firebase/pages/login_screen.dart';
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
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
