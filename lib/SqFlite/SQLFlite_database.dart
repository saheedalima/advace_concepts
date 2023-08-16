import 'package:flutter/cupertino.dart';
//database creation asynhronus aayirikkum
//sql frmatil edukkanayi as sql
//normally Sqflitinte operationu upayogikkunna keyword sql aanu
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sql.dart';
class SQLHelper{
  //create table with nametodo and column name as title and task
  //created at - system time fetch cheyth databaseil store aavan
  static Future<void> createTables(sql.Database database) async {
    //databsil table create cheyyn upayogikkunna built in functionaanu execute.with no return type.it is an SQL querry
    await database.execute("""CREATE TABLE mycontacts(  
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        cname TEXT,
        cnumber TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )""");
  }
  //creation of database
  //create database  db()
  //sql.database- database nnull classinte ullilaanu database open,athinte path keep cheyyuka,create cheyyuka.etc..
  //anganeyulla ella functinalitiesum varunnath database nnulla classinte ullilayirikkum
  static Future<sql.Database> db() async {
//opendatabase - builtin functionalityanu.database open cheyyan
  //open database- database undenki open cheyyuka illenki create cheyyuka
    return sql.openDatabase(
      // mydatabse is name of database
      // default version - 1 aayirikum number change cheythalum kuzhappamilla
        'mydatabase.db', version: 1,
        //databasinte enna objectum versionum vach databse create cheythirikkkunnu
        onCreate: (sql.Database database, int version) async {
          //databasil create aavanda nammal create cheyyunna methodaanu 'createtables'
          await createTables(database);
        });

  }

//insert data to database
  static Future<int> create_contact(String name, String number)async {

    final db= await SQLHelper.db();      ///to open database since database in secure place and always inclosed
    final data ={"cname" : name , "cnumber" : number};
   // final id = await db.insert("mycontacts", {"cname" : name , "cnumber" : number});  inagnem kodukm
    final id = await db.insert("mycontacts", data,conflictAlgorithm: ConflictAlgorithm.replace);
    //confli

    return id;

  }
//fetch all the datas from database
  static Future<List<Map<String,dynamic>>> getdatas() async{
    final db= await SQLHelper.db();
    //puthiya data edukkan querry
    //id vach ella valuesum edukkan orderBy
    return db.query('mycontacts',orderBy: 'id');
  }

  static Future<int> updateContact(int id, String name, String num) async{
    final db=await SQLHelper.db();
    final newdata={'cname':name,'cnumber':num,'createdAt':DateTime.now().toString()};
    final newid=await db.update('mycontact', newdata,where: 'id = ?',whereArgs: [id]);
    return newid;

  }

  static Future<void> deletecontact(int id)async {
    final db= await SQLHelper.db();
    //enthenkilum exception vanna handle cheyyan
    try{
      await db.delete('mycontacts',where: 'id=?',whereArgs: [id]);
    }catch (e){
      debugPrint('$e something went wrong');
    }

  }
  //read/fetch single value from database
///use your requirments
  // static Future<List<Map<String,dynamic>>> getsingledata(int id )async{
  // final db= await SQLHelper.db();
  // return db.query('mycontacts',where: 'id = ?',whereArgs: [id],limit: 1);}

}