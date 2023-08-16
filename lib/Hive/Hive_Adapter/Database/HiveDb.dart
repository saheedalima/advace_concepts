import 'package:advace_concepts/Hive/Hive_Adapter/model/user_models.dart';
import 'package:hive/hive.dart';

class HiveDB{
  ///this is named constructor
  ///secured aakkan inagne allenkilum cheyyam
  HiveDB._internal();     // _ is private or protected

static HiveDB instance = HiveDB._internal();

factory HiveDB(){   ///factory

  return instance;
}
///databasile ella valuesum edukkanam.athinayi list fo model classname.model classil ella datasum ind.
  ///usernnulla model classile fieldukl vazhi values hivil ninnum fetch aavum
   Future<List<User>> getUser() async {

     final db = await Hive.openBox<User>('userdata');
     return db.values.toList();  ///fetching all the values from hivebox
   }

  Future<void> addUser(User user) async{

   final db=await Hive.openBox<User>('userdata');
   //useril ulla value hivilekk poovan
   //add email and pass to hive using model class
   db.put(user.id, user);

  }

}