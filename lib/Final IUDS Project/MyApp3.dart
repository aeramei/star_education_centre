import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Final IUDS Project/DbAccess.dart';


class MyApp3 extends StatelessWidget {
// This widget is the root
// of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase',
      home: Myapp4(),
    );
  }
}


class Myapp4 extends StatefulWidget {
  const Myapp4({super.key});

  @override
  State<Myapp4> createState() => _Myapp4State();
}

class _Myapp4State extends State<Myapp4> {

  uploadFB()async {
    Map<String, dynamic> dataforsave = {
      "name": name.text,
      "email": email.text,

    };

    await DbAccess().addData(dataforsave);
    print('saving Successful');
  }

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();

  String ans='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("Save Data"),
        ),
        body:ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: name,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Enter your Name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Enter your Email'),
              ),
            ),


            Center(
              child: FloatingActionButton(
                backgroundColor: Colors.green,
                child: Text('Save'),
                onPressed: () {
                  setState(() {
                    uploadFB();
                  });

                },
              ),
            ),


          ],
        )



    );
  }
}



