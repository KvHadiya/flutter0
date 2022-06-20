import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter0/ModelData.dart';
import 'package:flutter0/Utils/FireModel.dart';
import 'package:flutter0/Utils/RealDB.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  TextEditingController txt_name = TextEditingController();
  TextEditingController txt_mobile = TextEditingController();
  TextEditingController txt_add = TextEditingController();
  TextEditingController txt_d_name = TextEditingController();
  TextEditingController txt_d_mobile = TextEditingController();
  TextEditingController txt_d_add = TextEditingController();

  List<ModelData> l1 = [];
  List<FireModel> l2 = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              TextField(
                controller: txt_name,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: txt_mobile,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: txt_add,
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  realDB()
                      .addProduct(txt_name.text, txt_mobile.text, txt_add.text);
                },
                child: Text("ADD NEWS"),
              ),
              // Expanded(
              //   child: Container(
              //     child: StreamBuilder(
              //       stream: realDB().getData(),
              //       builder: (context, AsyncSnapshot snapshot) {
              //         if (snapshot.hasError) {
              //           return Center(child: Text("Error = ${snapshot.error}"));
              //         } else if (snapshot.hasData) {
              //           DataSnapshot res = snapshot.data.snapshot;
              //           for (var x in res.children) {
              //             print("=----------- ${x.child("name").value}");
              //             print("=----------- ${x.child("address").value}");
              //             print("=----------- ${x.child("mobile").value}");
              //
              //             ModelData m1 = ModelData(
              //                 x.child("name").value.toString(),
              //                 x.child("mobile").value.toString(),
              //                 x.child("address").value.toString());
              //
              //             l1.add(m1);
              //           }
              //
              //           return Center(
              //             child: ListView.builder(
              //                 itemCount: l1.length,
              //                 itemBuilder: (context, index) {
              //                   return Padding(
              //                     padding: const EdgeInsets.all(8.0),
              //                     child: ListTile(
              //                       leading: Text("${l1[index].name}"),
              //                       title: Text("${l1[index].address}"),
              //                       trailing: Text("${l1[index].mobile}"),
              //                     ),
              //                   );
              //                 }),
              //           );
              //         }
              //         return Center(child: CircularProgressIndicator());
              //       },
              //     ),
              //   ),
              // ),

              Expanded(
                child: StreamBuilder(
                  stream: realDB().getData(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    } else if (snapshot.hasData) {
                      l2.clear();
                      DataSnapshot res = snapshot.data.snapshot;

                      for (var datasnap in res.children) {
                        String add = datasnap.child("name").value.toString();
                        String mobile =
                            datasnap.child("price").value.toString();
                        String name = datasnap.child("qa").value.toString();
                        String key = datasnap.key.toString();

                        FireModel f1 = FireModel(add, name, mobile, key);
                        l2.add(f1);
                      }

                      return ListView.builder(
                          itemCount: l2.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                leading: Text("${l2[index].name}"),
                                title: Text("${l2[index].mobile}"),
                                subtitle: InkWell(
                                    onTap: () {

                                      setState((){
                                        txt_d_name.text = l2[index].name;
                                        txt_d_add.text = l2[index].address;
                                        txt_d_mobile.text = l2[index].mobile;
                                      });

                                      updateDialog(l2[index].key);
                                    },
                                    child: Text("${l2[index].address}")),
                                trailing: InkWell(
                                    onTap: () {
                                      realDB().deleteData(l2[index].key);
                                    },
                                    child: Text("${l2[index].key}")),
                              ),
                            );
                          });
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateDialog(String key) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              TextField(
                controller: txt_d_name,
              ),
              TextField(
                controller: txt_d_mobile,
              ),
              TextField(
                controller: txt_d_add,
              ),
              ElevatedButton(
                onPressed: () {
                    realDB().updateData(txt_d_name.text, txt_d_mobile.text,txt_d_add.text, key);
                    Navigator.pop(context);
                },
                child: Text("Update"),
                style: ElevatedButton.styleFrom(primary: Colors.pinkAccent),
              ),
            ],
          );
        });
  }
}
