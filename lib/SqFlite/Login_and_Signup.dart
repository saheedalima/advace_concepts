import 'package:advace_concepts/Shared%20Prefereces/Login_Page.dart';
import 'package:advace_concepts/SqFlite/Registration_Page.dart';
import 'package:flutter/material.dart';
void main(){
  runApp(MaterialApp(home: Login_and_Signup(),));
}
class Login_and_Signup extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              Text("Hii User...",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.red),),
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: SizedBox(
                  width: 400,
                    height: 40,
                    child: ElevatedButton(onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Login_Page()));
                    }, child: Text("Login"))),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                    width: 400,
                    height: 40,
                    child: ElevatedButton(
                      style: ButtonStyle(),
                        onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Registration_Page()));
                        }, child: Text("Register"))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
