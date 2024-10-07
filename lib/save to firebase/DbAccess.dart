import 'package:cloud_firestore/cloud_firestore.dart';

class DbAccess{
  Future addData(Map<String,dynamic> reginfo) async{
    return await FirebaseFirestore.instance
        .collection("students")
        .doc()
        .set(reginfo);

  }
  Future <QuerySnapshot> getUserInfo(String sname)async{
    return  await FirebaseFirestore.instance
        .collection("students")
        .where("name",isEqualTo: sname)
        .get();
  }
}