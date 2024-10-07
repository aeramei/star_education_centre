import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase/Final IUDS Project/DbAccess.dart';
class Myapp5Delete extends StatefulWidget {
  const Myapp5Delete({super.key});

  @override
  State<Myapp5Delete> createState() => _Myapp5DeleteState();
}

class _Myapp5DeleteState extends State<Myapp5Delete> {
  @override
  TextEditingController name=TextEditingController();

  String ans='';
  String? mname,memail,id;
 // String? mname='';
 // String? memail='';
 // String? id='';


  deleteFb(String sname) async{
    QuerySnapshot querySnapshot=await DbAccess().getUserInfo(sname);
    id=querySnapshot.docs[0].id;
    mname="${querySnapshot.docs[0]["name"]}";
    memail="${querySnapshot.docs[0]["email"]}";


    await DbAccess().deleteData(id!);

    Fluttertoast.showToast(
        msg: "delete Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );

  }



  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
        appBar: AppBar(
          title:Text('Delete Data')
        ),
        body: Container(
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
               ElevatedButton(onPressed: (){
                 setState(() {
                   deleteFb(name.text);
                 });
               },
                   child: Text('Delete')
               ),

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
