import 'package:firebase_database/firebase_database.dart';
import 'package:flutter0/Utils/Auth.dart';
import 'package:flutter0/Utils/SharedPRef.dart';

import 'Constant.dart';

class realDB {
  FirebaseDatabase fd = FirebaseDatabase.instance;
  DatabaseReference? dbRef;
  String? uid;

  void addNews(String name, String mobile, String add) {
    dbRef = fd.ref();
    dbRef!
        .child("News")
        .push()
        .set({"name": "$name", "mobile": "$mobile", "address": "$add"});
  }

  Stream<DatabaseEvent> getData() {
    dbRef = fd.ref();

    return dbRef!.child("Product").child(userid).onValue;
  }

  Stream<DatabaseEvent> getNewsData() {
    //Object
    dbRef = fd.ref();
    return dbRef!.child("News").onValue;
  }

  void deleteData(String key) {
    dbRef = fd.ref();
    dbRef!.child("News").child(key).remove();
  }

  void updateData(String name, String mobile, String add, String key) {
    dbRef = fd.ref();
    dbRef!
        .child("News")
        .child(key)
        .set({"name": name, "mobile": mobile, "address": add});
  }

  void addProduct(String name, String price, String qa) async {
    dbRef = fd.ref();
    String? uid = await getuidSHR();
    dbRef!
        .child("Product")
        .child(uid!)
        .push()
        .set({"name": name, "price": price, "qa": qa});
  }

}
