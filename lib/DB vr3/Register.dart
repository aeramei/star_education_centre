import 'package:flutter/material.dart';
import 'package:firebase/DB vr3/DataAccess.dart';
import 'package:firebase/DB vr3/Searchdata.dart';
import 'package:firebase/DB vr3/Updatedata.dart';



class Register extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

          // Define the default brightness and colors.
        //  brightness: Brightness.dark,
          primaryColor:Colors.blue,


          // Define the default font family.
          fontFamily: 'Times New Roman',

          // Define the default `TextTheme`. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.

      ),
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Save Data to  Firebase')),
        ),
        body: Form(),
      ),
    );
  }
}

class Form extends StatefulWidget {
  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<Form> {


  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  String ans='';

  uploadFB()async{
    Map<String, dynamic> uploadfb={
    "name":name.text,
    "email":email.text,
    "phone":phone.text,

    };

    await DataAccess().addData(uploadfb);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(

        child: Container(
          margin: EdgeInsets.all(15),
          child: ListView(

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
                      border: OutlineInputBorder(),
                      labelText: 'Enter your Email'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: phone,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your Phone No'),
                ),
              ),
              ElevatedButton(
                  onPressed: () {

                      uploadFB();
                   

                  },
                  child: Text('Register')),
              ElevatedButton(onPressed: (){

              Navigator.push(context, MaterialPageRoute(builder: (context){
                return Searchdata();
              }));
              }, child: Text('Search')),
              ElevatedButton(onPressed: (){

                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return Updatedata();
                }));
              }, child: Text('Update'))
            ],
          ),
        ),
      ),
    );
  }
}
