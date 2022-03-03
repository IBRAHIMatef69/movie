import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/model/movie.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

final fav = ChangeNotifierProvider<Note>((ref) => Note());

class Note extends ChangeNotifier {
  static Database? _db;
  List<Movie> favList = [];

  Note() {
    getdb();
  }

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDB();
      return _db;
    } else {
      return _db;
    }
  }

  initialDB() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "tododb.db");
    var myDb = await openDatabase(path, version: 4, onCreate: _onCreate);
    return myDb;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE todo1(id INTEGER NOT NULL, vote_average REAL NOT NULL,title TEXT NOT NULL,original_title TEXT NOT NULL,poster_path TEXT NOT NULL,release_date TEXT NOT NULL,backdrop_path TEXT NOT NULL,overview TEXT NOT NULL )');
  }



  chickFav(id){

      favList.removeAt( id);


    notifyListeners();

  }
  addListFav(id){

    favList.add(favList.firstWhere((element) => element.id == id));


    notifyListeners();

  }

  Future insertdb(Map<String, dynamic> data) async {
    Database? db_Clint = await db;
    db_Clint!.insert('todo1', data);
getdb();
    notifyListeners();
  }

  Future<dynamic> deletedb(int id) async {
    Database? db_Clint = await db;
    var result = db_Clint!.rawUpdate('DELETE FROM todo1 WHERE id="$id"');
    notifyListeners();
  }

  void manageFav({productId}) async {
    var existingIndex =
        favList.indexWhere((element) => element.id == productId);
    if (existingIndex >= 0) {
      favList.removeAt(existingIndex);
      deletedb(productId);
    } else {
      favList.add(favList.firstWhere((element) => element.id == productId));
      await insertdb(productId);
    }
    notifyListeners();
  }

  Future<int> Updatedb(String description, int id) async {
    Database? db_Clint = await db;
    var result = db_Clint!.rawUpdate(
        'UPDATE todo1 SET description="description" WHERE id ="$id"');
    return result;
  }

  bool isFavorite(int productId) {
    return favList.any((element) => element.id == productId);

  }


  Future getdb() async {
    favList = [];
    Database? db_Clint = await db;
    var result = await db_Clint!.query('todo1');

    for (var i in result) {
      favList.add(
        Movie(
          id: i["id"] as int,
          vote_average: i["vote_average"] as num,
          title: i["title"] as String,
          original_title: i['original_title'] as String,
          poster_path: i['poster_path'] as String,
          release_date: i['release_date'] as String,
          backdrop_path: i['backdrop_path'] as String,
          overview: i['overview'] as String,
        ),
      );
    }

    notifyListeners();
  }

  Future<int> updateCheck(String done, int id) async {
    Database? db_Clint = await db;
    var result = await db_Clint!.rawUpdate(
      'UPDATE todo1 SET done = ? WHERE id = ?',
      ['$done', id],
    );

    return result;
  }
}
