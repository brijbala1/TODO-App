import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_app/model/note_model.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? database;

  String noteTable = 'mytable';
  String colId = 'id';
  String colName = 'name';
  String colAge = 'age';
  String colbloodGroup = 'bloodgroup';

  DatabaseHelper._createDataBase();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createDataBase();
    }
    return _databaseHelper!;
  }

  Future<Database> get data async {
    if (database == null) {
      database = await initailizeDatabadse();
    }
    return database!;
  }

  void _createDB(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colName TEXT,$colAge INTEGER,$colbloodGroup TEXT)');
  }

  Future<Database> initailizeDatabadse() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path + 'note.db');
    var noteDB = openDatabase(path, version: 1, onCreate: _createDB);
    return noteDB;
  }

  Future<int> insert(NoteModel note, BuildContext context) async {
    Database db = await data;
    if (db != null) {
      Navigator.pop(context);
    }
    var result = await db.insert(noteTable, note.toMap());
    return result;
  }

  Future<List<Map<String, dynamic>>> getMapList() async {
    Database db = await data;
    var result = await db.query(noteTable);
    return result;
  }

  Future<List<NoteModel>> getNoteList() async {
    var noteModelList = await getMapList();
    int count = noteModelList.length;
    List<NoteModel> note = [];
    for (int i = 0; i < count; i++) {
      print(noteModelList[i]);
      note.add(NoteModel.fromMapObject(noteModelList[i]));
    }
    return note;
  }
}
