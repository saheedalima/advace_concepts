import 'package:advace_concepts/Hive/Hive_Adapter/model/user_models.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../Database/HiveDb.dart';

class HiveRegistration extends StatelessWidget {

  final remail_controller=TextEditingController();
  final rpassword_controller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registration"),),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: remail_controller,
                decoration: InputDecoration(
                    hintText: "enter your email",
                    labelText: "email"
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: rpassword_controller,
                decoration: InputDecoration(
                    hintText: "enter your password",
                    labelText: "password"
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(onPressed: () async{
                 ///to fetch all the users from hive
                final userlist=await HiveDB.instance.getUser(); ///oro thavanyum instance vilikkanda
                                                                ///static maatti instance classnam inte koode add cheythu
                validateSignUp(userlist);
                remail_controller.text="";
                rpassword_controller.text="";

              }, child: Text("Registration")),
            ),
          ],
        ),
      ),
    );
  }

  void validateSignUp(List<User> userlist) async{
    final mail= remail_controller.text.trim();
    final pwd= rpassword_controller.text.trim();
    bool isUserFound =false;    ///user ne found cheythal true aakan. initially value illathathu kond false akivachu
    final validate_email = EmailValidator.validate(mail);  ///to validate the email.this result will be in bool

    if(mail !="" && pwd != ""){
      if(validate_email==true){
        ///
        ///one by one aayi oro data edkn
        await Future.forEach(userlist, (user) {   ///hivil inagne oru email undon check chynm
          ///model classin varunna emailum nmml text controlleril adicha emailum same aanonn nkknm
          if(user.email== mail){
            ///confition true aanenki userfoundayi
            isUserFound = true;
          }else{
            isUserFound = false;
          }
        });
        if(isUserFound==true){
          Get.snackbar("error", "user already exist");
        }else{
          final pwdvalidation= cheackpassword(pwd);
          if(pwdvalidation==true) {
            final user = User(email: mail, password: pwd);
            await HiveDB.instance.addUser(user);
            //page close cheyth next previous pagilekk poovan

            Get.back();
            Get.snackbar("Success", "User registration success");

          }
        }
      }else{
        Get.snackbar("error","enetr a valid email");
      }
    }else{
      ///get- statemanagemntinte propertyaanu.but fully statemangment alla
      Get.snackbar("error","fiel musynot be empty");
  }
}
}
bool cheackpassword(String pwd) {
  if(pwd.length<6){
    Get.snackbar("error", "password must be greater than 6",colorText: Colors.red);
    return false;
  }else{
    return true;
  }
}
