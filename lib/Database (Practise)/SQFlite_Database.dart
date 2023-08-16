import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sql.dart';

class SQFlite_Database{
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE sqflite_database(  
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        username TEXT,
        password TEXT,
        email TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )""");
  }
  static Future<sql.Database> db() async {
    return sql.openDatabase(
      /// mydatabse is name of database
        'mydatabase.db', version: 1,
        onCreate: (sql.Database database, int version) async {
          await createTables(database);
        });
  }

  static Future<int> add_datas(String username, String password, String email) async {
    final id = await SQFlite_Database.db();
    final datas={"username": username,"password":password,"email":email};
    final databse = id.insert("sqflite_database", datas,conflictAlgorithm: ConflictAlgorithm.replace);
    return databse;
  }

  static Future<List<Map<String, dynamic>>> login_cheack(String email, String password) async{
    final db = await SQFlite_Database.db();
    final data=db.rawQuery(
        "SELECT * FROM logindatas WHERE email= '$email' AND password = '$password' "
    );
    return data;
  }

}