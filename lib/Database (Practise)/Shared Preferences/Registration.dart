import 'package:advace_concepts/Database%20(Practise)/Login_Page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Login.dart';
void main(){
  runApp(MaterialApp(home: Registration(),));
}
class Registration extends StatefulWidget {

  @override
  State<Registration> createState() => _Registration_PageState();
}

class _Registration_PageState extends State<Registration> {

  late SharedPreferences sharedPreferences;

  final username_controller=TextEditingController();
  final password_controller=TextEditingController();
  final email_controller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registration Page"),),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: username_controller,
              decoration: InputDecoration(
                  hintText: "enter you username",
                  labelText: "username"
              ),
            ),
            TextField(
              controller: email_controller,
              decoration: InputDecoration(
                  hintText: "enter you email",
                  labelText: "email"
              ),
            ),
            TextField(
              controller: password_controller,
              decoration: InputDecoration(
                  hintText: "enter you password",
                  labelText: "password"
              ),
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: "enter you confirm password",
                  labelText: "confirm passowrd"
              ),
            ),
            ElevatedButton(onPressed: (){
              String username=username_controller.text;
              String password=password_controller.text;
              String email=email_controller.text;

              if(username==''&&password==''&&email==''){
                sharedPreferences.setString('username', username);
                sharedPreferences.setString('password', password);
                sharedPreferences.setString('email', email);
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Login()));
              }
            }, child: Text("Register"))
          ],
        ),
      ),
    );
  }
}
