import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase/Final IUDS Project/DbAccess.dart';
class Myapp6Search extends StatefulWidget {
  const Myapp6Search({super.key});

  @override
  State<Myapp6Search> createState() => _Myapp6SearchState();
}

class _Myapp6SearchState extends State<Myapp6Search> {
  @override


  String? mname,memail,mphone,id;
  TextEditingController sname=TextEditingController();

  searchData(String sname) async{
    QuerySnapshot querySnapshot= await DbAccess().getUserInfo(sname);
    id=querySnapshot.docs[0].id;
    mname="${querySnapshot.docs[0]["name"]}";
    memail="${querySnapshot.docs[0]["email"]}";

  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
        appBar: AppBar(
          title:Text('Search Data')
        ),
        body: Container(
          child: ListView(
             children: [
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: TextField(
                    controller: sname,
                       decoration: InputDecoration(
                       border: OutlineInputBorder(), labelText: 'Enter your Name'),
                 ),
               ),
               ElevatedButton(onPressed: (){
                 setState(() {
                searchData(sname.text);
                 });
               },
                   child: Text('Search')
               ),

               Center(child: Text('$mname')),
               Center(child: Text('$memail')),



               mname!=null? Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Text('$mname'),
                  ):Container(
                 child: Center(child: Text('No Data')),
               ),

                memail!=null? Padding(
                  padding: EdgeInsets.all(8.0),
                    child: Text('$memail')
                ):Center(child: Text('No Data'))

             ]

          ),

        ),
      )
    );
  }
}
