import 'package:advace_concepts/Shared%20Prefereces/Home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main(){
  runApp(MaterialApp(home: Login_Page(),));
}

class Login_Page extends StatefulWidget {

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {

  TextEditingController uname_Controller = TextEditingController();
  TextEditingController pass_Controller = TextEditingController();

  /// also use this way to create controller
  /// final uname_Controller = TextEditingController();
  /// final pass_Controller = TextEditingController();

  late SharedPreferences preferences;
  late bool newuser;

  @override
  void initState() {
    super.initState();
    cheak_user_already_login();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login"),),
      body: Column(
        children: [
          const Text("Login Page", style: TextStyle(fontSize: 20),),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: uname_Controller,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Username"
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: pass_Controller,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "password"
              ),
            ),
          ),
          ElevatedButton(onPressed: () {
            String username = uname_Controller.text;
            String password = pass_Controller.text;

            if (username != '' && password != '') {
              ///saving data to sharedpreferenes
              preferences.setString("username", username);
              ///00
              preferences.setBool("firstlogin", false);

              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Home()));
            }
          }, child: const Text("Login"))
        ],
      ),
    );
  }

  void cheak_user_already_login() async{
  preferences = await SharedPreferences.getInstance();
  ///if Vpreferences.getBool('firstlogin')== null then value of newuser = true
  newuser = preferences.getBool('firstlogin') ?? true;

  if(newuser==false){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
  }
  }

  @override
  void dispose() {   ///data clear cheyyan
    ///to clear the values of username and password from textfield
    uname_Controller.dispose();
    pass_Controller.dispose();
    super.dispose();
  }

}
