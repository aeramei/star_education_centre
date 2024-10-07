
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/DB vr3/DataAccess.dart';

class Updatedata extends StatelessWidget {
  const Updatedata({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Myupdate()
    );
  }
}

class Myupdate extends StatefulWidget {
  const Myupdate({super.key});

  @override
  State<Myupdate> createState() => _MyupdateState();
}

class _MyupdateState extends State<Myupdate> {
  TextEditingController searchname=TextEditingController();
  TextEditingController newval=TextEditingController();
  @override
  String? mname,memail,mphone,id='';
  
   updateUser(String sname,String updata) async{
    QuerySnapshot querySnapshot=await DataAccess().getUserInfo(sname);
    id=querySnapshot.docs[0].id;
    DataAccess().updateData(updata, id!);

    mname="${querySnapshot.docs[0]["name"]}";
    memail="${querySnapshot.docs[0]["email"]}";
    mphone="${querySnapshot.docs[0]["phone"]}";
    setState(() {

    });
  }

  searchUser(String sname) async{
    QuerySnapshot querySnapshot=await DataAccess().getUserInfo(sname);
    id=querySnapshot.docs[0].id;
    mname="${querySnapshot.docs[0]["name"]}";
    memail="${querySnapshot.docs[0]["email"]}";
    mphone="${querySnapshot.docs[0]["phone"]}";
    setState(() {

    });
  }
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Data'),
      ),
      body:ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchname,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Search Name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: newval,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Enter  New Email '),
            ),
          ),
          ElevatedButton(
              onPressed: ()  {
                  searchUser(searchname.text);
              },
              child: Text('Search')),

          ElevatedButton(
              onPressed: () {
               updateUser(searchname.text,newval.text);
              },
              child: Text('Update'))
          ,
          mname!=null?Center(child: Text('Name:${mname}')):Container(),
          memail!=null?Center(child: Text('Email:${memail}')):Container(),
          mphone!=null?Center(child: Text('Phone:${mphone}')):Container(),

        ],
      )
    );




  }
}

