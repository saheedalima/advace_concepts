import 'package:advace_concepts/Hive/Hive_Adapter/Database/HiveDb.dart';
import 'package:advace_concepts/Hive/Hive_Adapter/model/user_models.dart';
import 'package:advace_concepts/Shared%20Prefereces/Home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'Home.dart';
import 'Registration.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.openBox<User>('userdata');
  runApp(GetMaterialApp(home: Login(),));
}

class Login extends StatelessWidget {

  final email_controller=TextEditingController();
  final password_controller=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"),),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: email_controller,
              decoration: InputDecoration(
                hintText: "enter your email",
                labelText: "email"
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: password_controller,
                decoration: InputDecoration(
                    hintText: "enter your password",
                    labelText: "password"
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: ()async{

                final users =await HiveDB.instance.getUser();
                cheackuserExist(users);

              }, child: Text("Login")),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HiveRegistration()));
              }, child: Text("Go To Registration")),
            )
          ],
        ),
      ),
    );
  }

  Future<void> cheackuserExist(List<User> users) async {

    final lemail= email_controller.text.trim();
    final lpass = password_controller.text.trim();
    bool userfound = false;
    if(lemail!= "" && lpass!=""){
      await Future.forEach(users, (singleuser) {
        //
        if(lemail==singleuser.email && lpass == singleuser.password){
          userfound = true;
        }else{
          userfound=false;
        }
      });
      if(userfound==true){
        Get.offAll(()=>Home_l(email:lemail));
        Get.snackbar("Success", "Logined as $lemail");
      }else{
        Get.snackbar("error", "Login failed no user exist");
      }
    }else{
      Get.snackbar("Error", "please fill the fields");
    }

  }
}
