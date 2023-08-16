import 'package:advace_concepts/Database%20(Practise)/Login_Page.dart';
import 'package:advace_concepts/Database%20(Practise)/Shared%20Preferences/Welcome.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {

  @override
  State<Login> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login> {

  final username_controller=TextEditingController();
  final password_controller=TextEditingController();

  late SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Page"),),
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
              controller: password_controller,
              decoration: InputDecoration(
                  hintText: "enter you password",
                  labelText: "password"
              ),
            ),
            ElevatedButton(onPressed: (){
              String username=username_controller.text;
              String password=password_controller.text;

              if(username==''&&password==''){
                sharedPreferences.getString('username');
                sharedPreferences.getString('password');
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Welcome()));
              }else{
                print("No data found");
              }

            }, child: Text("Login"))
          ],
        ),
      ),
    );
  }
}
