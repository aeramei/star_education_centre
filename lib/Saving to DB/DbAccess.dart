import 'package:cloud_firestore/cloud_firestore.dart';

class DbAccess{
  Future addData(Map<String,dynamic> reginfo) async{
    return await FirebaseFirestore.instance
        .collection("Person")
        .doc()
        .set(reginfo);

  }
}