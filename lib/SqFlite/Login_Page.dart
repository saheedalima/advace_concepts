import 'package:advace_concepts/SqFlite/Login_and_Signup.dart';
import 'package:advace_concepts/SqFlite/SQFlite_Dtabase_of_Login.dart';
import 'package:advace_concepts/SqFlite/Welcome_Page.dart';
import 'package:flutter/material.dart';

import 'Admin_Page.dart';
void main(){
  runApp(MaterialApp(home: Login_Page(),));
}
class Login_Page extends StatefulWidget {

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
bool showpass=true;
var formkey2=GlobalKey<FormState>();

var username = "saheedalima";
var password="saheed@123";

  final email_controller = TextEditingController();
  final pass_controller =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login Page"),),
      body:  Form(
        key: formkey2,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTiSQoAMHJ3EUBgxQUgupzMJieaObkkAoLjNw&usqp=CAU"))),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Welcome back! login with your credentials",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(bottom: 10, right: 10, left: 10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10,bottom: 10,left: 50,right: 50),
                        child: TextFormField(
                          controller: email_controller,
                          validator: (email){
                            if(email!.isEmpty||email.contains("@")||email.contains(".")){
                              return "enter valid email";
                            }else{
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                            hintText: "Enter your email",
                            labelText: "email",
                            prefixIcon: Icon(Icons.email),
                            suffixIcon: Icon(Icons.email),
                          ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10,bottom: 10,left: 50,right: 50),
                        child: TextFormField(
                          controller: pass_controller,
                          validator: (pass){
                            if(pass!.isEmpty){
                              return "enter values";
                            }else{
                              return null;
                            }
                          },
                          obscureText: showpass,
                          obscuringCharacter: '#',
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                            hintText: "Enter your password",
                            labelText: "password",
                            prefixIcon: Icon(Icons.password),
                            suffixIcon: IconButton(onPressed: (){
                              if(showpass){
                                showpass=false;
                              }else{
                                showpass=true;
                              }
                            }, icon: Icon(showpass==true?Icons.visibility:Icons.visibility_off)),
                          ),),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final validate2=formkey2.currentState!.validate();
                          if(validate2){
                            cheacklogin(email_controller.text,pass_controller.text);
                          }else{}

                          },
                        child: const Text("Login"),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            minimumSize: const Size(300, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {

                  },
                  child: const Text("Sign Up"),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      minimumSize: const Size(300, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> cheacklogin(String email, String password) async{
    if(email=="admin@123"&&password=="admin123"){
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Admin_Page()));
    }else {
      final data = await SQL_Login.cheack_login(email, password);

      if (data.isNotEmpty) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Welcome_Page()));
        print("Login Success");

        ///user not found in db
      } else if (data.isEmpty) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Login_and_Signup()));
        print("Login Failed");
      }
    }
  }
}
