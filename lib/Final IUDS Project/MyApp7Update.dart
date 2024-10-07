import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Final IUDS Project/DbAccess.dart';


class MyApp7Update extends StatelessWidget {
  const MyApp7Update({super.key});

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
  String? mname,memail,id='';

  updateUser(String sname,String updata) async{
    QuerySnapshot querySnapshot=await DbAccess().getUserInfo(sname);
    id=querySnapshot.docs[0].id;
    DbAccess().updateData(updata, id!);
    mname="${querySnapshot.docs[0]["name"]}";
    memail="${querySnapshot.docs[0]["email"]}";

  }

  searchUser(String sname) async{
    QuerySnapshot querySnapshot=await DbAccess().getUserInfo(sname);
    id=querySnapshot.docs[0].id;
    mname="${querySnapshot.docs[0]["name"]}";
    memail="${querySnapshot.docs[0]["email"]}";

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
                  setState(() {
                    searchUser(searchname.text);
                  });

                },
                child: Text('Search')),

            ElevatedButton(
                onPressed: () {
                  setState(() {
                    updateUser(searchname.text,newval.text);
                  });

                },
                child: Text('Update'))
            ,
            mname!=null?Center(child: Text('Name:${mname}')):Container(child: Center(child: Text('no data')),),
            memail!=null?Center(child: Text('Email:${memail}')):Container(child: Center(child: Text('no data')),),


          ],
        )
    );




  }
}

