import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sql.dart';

class SQL_Login {
  ///create table with nametodo and column name as title and task
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE logindatas(  
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

  static Future<int> add_newuser(String username, String password, String email) async {
    final db = await SQL_Login.db();
    final data={
      'username' : username,
      'password': password,
      'email' : email,
    };
    final id = await db.insert('logindatas',data,conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }
  ///puthiya
  static Future<List<Map>> cheack_login(String email, String password) async{
      
    final db  = await SQL_Login.db();
    final data = await db.rawQuery(
    "SELECT * FROM logindatas WHERE email= '$email' AND password = '$password' "
    );
    if(data.isNotEmpty){
      return data;
    }
    return data;
  }

  static Future<List<Map>> userfounded(String email, String password) async {
    final id = await SQL_Login.db();
    final data = await id.rawQuery(
        "SELECT * FROM logindatas WHERE email= '$email' AND password = '$password' "
    );
    return data;

  }

  static Future<Future<List<Map<String, Object?>>>> getAdmin_values() async {
    final id = await SQL_Login.db();
    return id.query('logindatas',orderBy: 'id');
  }
}