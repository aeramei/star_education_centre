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
        options: FirebaseOptions(
            apiKey: "AIzaSyAkq1yHzP8nkYCkxyq5eDMPy7wuN0nIRjE",
            authDomain: "hnd-53-3d26b.firebaseapp.com",
            projectId: "hnd-53-3d26b",
            storageBucket: "hnd-53-3d26b.appspot.com",
            messagingSenderId: "578754999002",
            appId: "1:578754999002:web:9a1d1a4f1416dea707abe3",
            measurementId: "G-JTZ8J1SXP8"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp1());
}
