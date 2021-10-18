import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'model_database.dart';

class DbHelper{
  String nameTable= "Shortly";
  String shortlyLink= "shortlyLink";
  String originalLink= "originalLink";
  String isCopy= "isCopy";

  static final DbHelper _instance = DbHelper.internal();
  factory DbHelper() => _instance;
  DbHelper.internal();
  static Database? _db;

  Future<Database?> createDatabase() async{

    if(_db != null){
      return _db;
    }
    //define the path to the database
    String path = join(await getDatabasesPath(), 'task.db');
    _db = await openDatabase(path,version: 1,onCreate: (Database db, int version){
      db.execute("CREATE TABLE $nameTable(id integer primary key autoincrement, $shortlyLink varchar(50) , $originalLink varchar(50))");
    });
    return _db;
  }


  Future<List<ShortlyModelDB>> getAllShortlyLinks() async{

    List<ShortlyModelDB> shortlyList ;

    Database? dbClient = await createDatabase();

    List result = await dbClient!.rawQuery("SELECT * FROM $nameTable");

    shortlyList = result.map((e) => ShortlyModelDB.fromJson(e)).toList();

    return shortlyList;


  }

  Future<int> insertDate(ShortlyModelDB shortly) async{
    Database? db = await createDatabase();
    return await db!.insert('$nameTable', shortly.toJson());
  }


  Future<int> deleteCourse(int id) async{
    Database? dbClient = await createDatabase();
    return dbClient!.delete('$nameTable',where: 'id = ?',whereArgs:[id] );
  }





}