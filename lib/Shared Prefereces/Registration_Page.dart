import 'package:advace_concepts/Shared%20Prefereces/Home_Page_2.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){
  runApp(MaterialApp(home: Registratin_Page(),));
}

class Registratin_Page extends StatefulWidget {

  @override
  State<Registratin_Page> createState() => _Registratin_PageState();
}

class _Registratin_PageState extends State<Registratin_Page> {

  final uname_controller=TextEditingController();
  final password_controller=TextEditingController();
  final email_controller=TextEditingController();
  final phone_number_controller=TextEditingController();
  late SharedPreferences sharedPreferences;
  late bool already_registered;

@override
  void initState() {
  getvalue();
  cheack_already_registered();
    super.initState();
  }

  void cheack_already_registered() async{
  sharedPreferences=await SharedPreferences.getInstance();
  already_registered=sharedPreferences.getBool('if_already_registered')?? true;

  if(already_registered==false){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Home_Page_2()));
  }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registration Page"),),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: uname_controller,
              decoration: const InputDecoration(
                hintText: "enter your username",
                labelText: "Username"
              ),
            ),
            TextField(
              controller: password_controller,
              decoration: const InputDecoration(
                  hintText: "enter your username",
                  labelText: "Password"
              ),
            ),
            TextField(
              controller: email_controller,
              decoration: const InputDecoration(
                  hintText: "enter your email",
                  labelText: "Email.."
              ),
            ),
            TextField(
              controller: phone_number_controller,
              decoration: const InputDecoration(
                  hintText: "enter your phone number",
                  labelText: "Phone Number"
              ),
            ),
            ElevatedButton(onPressed: () {
              String username= uname_controller.text;
              String password= password_controller.text;
              String email= email_controller.text;
              String phone_number= phone_number_controller.text;

              if(username!=''&&password!=''&&email!=''&&phone_number!=''){
                sharedPreferences.setString('userame', username);
                sharedPreferences.setString("password", password);
                sharedPreferences.setString('email', email);
                sharedPreferences.setString('phone_number', phone_number);

                sharedPreferences.setBool('if_already_registered', false);
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Home_Page_2()));
              }
            }, child: Text("Register Here"))
          ],
        ),
      ),
    );
  }

  void getvalue() async{

  }
}

