import 'package:flutter/material.dart';
import 'package:simple_note/helper/dbHelper.dart';
import 'package:simple_note/models/konten.dart';
import 'package:simple_note/pages/form.dart';
import 'package:sqflite/sqflite.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Konten> kontenList;
  @override
  void initState() {
    super.initState();
    updateListView();
  }

  Widget build(BuildContext context) {
    if (kontenList == null) {
      // ignore: deprecated_member_use
      kontenList = List<Konten>();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Note"),
      ),
      body: Column(
        children: [
          Expanded(
            child: createListView(),
          ),
          Container()
        ],
      ),
    );
  }

  ListView createListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (buildContext, int index){

    });
  }

  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database){
       //select data
      Future<List<Konten>> itemListFuture = dbHelper.getItemList();
      itemListFuture.then((itemList) {
        setState(() {
          this.kontenList = itemList;
          this.count = itemList.length;
        });
      });
    });
  }

  Future<Konten> navigateToEntryForm(BuildContext context, Konten konten) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return AddNote(konten);
    }));
    return result;
  }

}
