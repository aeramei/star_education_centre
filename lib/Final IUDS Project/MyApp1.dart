import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class MyApp1 extends StatelessWidget {
// This widget is the root
// of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase',
      home: Myapp2(),
    );
  }
}


class Myapp2 extends StatefulWidget {
  const Myapp2({super.key});

  @override
  State<Myapp2> createState() => _Myapp2State();
}

class _Myapp2State extends State<Myapp2> {

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
                child: Icon(Icons.add),
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('todaydata')
                      .add(
                      { "name":name.text,
                        "email":email.text,
                        "Phone":'09-1234567',
                      }
                  );
                  print('hello');
                },
              ),
            )

          ],
        )



    );
  }
}



