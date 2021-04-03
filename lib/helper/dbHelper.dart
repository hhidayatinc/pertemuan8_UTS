import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:simple_note/models/konten.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper{
  static DbHelper _dbHelper;
  static Database _database;

  DbHelper._createObject();
  
  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'konten.db';

    var itemDatabase = openDatabase(path,
        version: 2, onCreate: _createDb);
    return itemDatabase;
  }

  void _createDb(Database db, int version) async{
    var batchTemp = db.batch();
    // ignore: await_only_futures
    await batchTemp.execute('''
        CREATE TABLE kategori (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT
        )
     ''');
    // ignore: await_only_futures
    await batchTemp.execute('''
        CREATE TABLE konten (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        idKategori INTEGER NOT NULL,
        date TEXT,
        title TEXT,
        note TEXT,
        FOREIGN KEY(idKategori) REFERENCES kategori(id) ON DELETE CASCADE ON UPDATE CASCADE
        )
     ''');
     batchTemp.commit();

     await db.insert("kategori", {
       "title" : "Task"
     });

     await db.insert("kategori", {
       "title" : "Event"
     });

     await db.insert("kategori", {
       "title" : "Anniversary"
     });

     await db.insert("kategori", {
       "title" : "Birthday"
     });
  }

  Future<List<Map<String, dynamic>>> select() async {
    Database db = await this.initDb();
    var mapList = await db.query('item', orderBy: 'kodeBarang');
    return mapList;
  }

  //create databases
  Future<int> insert(Konten object) async {
    Database db = await this.initDb();
    int count = await db.insert('item', object.toMap());
    return count;
  }

  //update databases
  Future<int> update(Konten object) async {
    Database db = await this.initDb();
    int count = await db
        .update('item', object.toMap(), where: 'id=?', whereArgs: [object.id]);
    return count;
  }

  //delete databases
  Future<int> delete(int id) async {
    Database db = await this.initDb();
    int count = await db.delete('item', where: 'id=?', whereArgs: [id]);
    return count;
  }

  Future<List<Konten>> getItemList() async {
    var itemMapList = await select();
    int count = itemMapList.length;
    // ignore: deprecated_member_use
    List<Konten> itemList = List<Konten>();
    for (int i = 0; i < count; i++) {
      itemList.add(Konten.fromMap(itemMapList[i]));
    }
    return itemList;
  }

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper;
  }
  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }
}