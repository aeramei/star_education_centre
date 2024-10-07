import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase/Final IUDS Project/DbAccess.dart';
import 'package:firebase/Final IUDS Project/MyApp1.dart';
import 'package:firebase/Final IUDS Project/MyApp3.dart';
import 'package:firebase/Final IUDS Project/MyApp5_Delete.dart';
import 'package:firebase/Final IUDS Project/MyApp6_Search.dart';
import 'package:firebase/Final IUDS Project/MyApp7Update.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //runApp(MyApp3());
  //runApp(Myapp6Search());
 // runApp(Myapp5Delete());
  runApp(MyApp7Update());

}
