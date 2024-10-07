import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase/DB vr3/DataAccess.dart';


class Searchdata extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        // Define the default brightness and colors.
        //  brightness: Brightness.dark,
        primaryColor:Colors.amber,

        // Define the default font family.
        fontFamily: 'Times New Roman',

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.

      ),
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Searching and Deleting Data')),
        ),
        body: Form1(),
      ),
    );
  }
}

class Form1 extends StatefulWidget {
  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<Form1> {


  TextEditingController name = TextEditingController();
   String ans='';
   String? mname,memail,mphone,id;

   searchUser(String sname) async{
    QuerySnapshot querySnapshot=await DataAccess().getUserInfo(sname);
    id=querySnapshot.docs[0].id;
    mname="${querySnapshot.docs[0]["name"]}";
    memail="${querySnapshot.docs[0]["email"]}";
    mphone="${querySnapshot.docs[0]["phone"]}";
    setState(() {

    });
   }
    deleteFb() async{
  searchUser(name.text);
  await DataAccess().deleteData(id!);

  setState(() {

  });

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

              ElevatedButton(
                  onPressed: () {
                    setState(() {
                    //  deleteFb(name.text);
                      searchUser(name.text);
                    });
                  },
                  child: Text('Search')),

              mname!=null?Center(child: Text('Name:${mname}')):Container(),
              memail!=null?Center(child: Text('Email:${memail}')):Container(),
              mphone!=null?Center(child: Text('Phone:${mphone}')):Container(),
              ElevatedButton(onPressed: (){
                setState(() {
                  deleteFb();
                });


              },
                  child: Text('Delete'))


            ],
          ),
        ),
      ),
    );
  }
}
