import 'package:advace_concepts/Database%20(Practise)/SQFlite_Database.dart';
import 'package:flutter/material.dart';

class Registration_Page extends StatefulWidget {

  @override
  State<Registration_Page> createState() => _Registration_PageState();
}

class _Registration_PageState extends State<Registration_Page> {

  final username_controller=TextEditingController();
  final password_controller=TextEditingController();
  final email_controller=TextEditingController();
  final confirm_pass_controller=TextEditingController();

  bool showpass=true;
  var formkey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registration Page"),),
      body: Form(
        key: formkey,
        child: Column(
          children: [
            Text("Registration",style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold,),),
            Padding(
              padding: const EdgeInsets.only(top: 50,left: 50,right: 50,bottom: 10),
              child: TextFormField(
                controller: username_controller,
                validator: (username){
                  if(username!.isEmpty){
                    return "Name is required" ;
                  }else{
                    return null;
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                  hintText: "Enter your username",
                  labelText: "username",
                  prefixIcon: Icon(Icons.contact_phone),
                ),),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,bottom: 10,left: 50,right: 50),
              child: TextFormField(
                controller: email_controller,
                validator: (email){
                  if(email!.isEmpty){
                    return "Enter valid email format";
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
                controller: password_controller,
                validator: (password){
                  if(password!.isEmpty){
                    return "password required";
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
            Padding(
              padding: const EdgeInsets.only(top: 10,bottom: 10,left: 50,right: 50),
              child: TextFormField(
                controller: confirm_pass_controller,
                validator: (confirm_pass){
                  if(confirm_pass!.isEmpty){
                    return "confirm password required";
                  }else{
                    return null;
                  }
                },
                obscureText: showpass,
                obscuringCharacter: '*',
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                  hintText: "Enter your confirmpassword",
                  labelText: "confirm password",
                  prefixIcon: Icon(Icons.password),
                  suffixIcon: IconButton(onPressed: (){
                    if(showpass){
                      showpass=false;
                    }else{
                      showpass=true;
                    }
                  }, icon: Icon(showpass==true?Icons.visibility:Icons.visibility_off) ),
                ),),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: 200,
                height: 40,
                child: ElevatedButton(
                    style: ButtonStyle(),
                    onPressed: () async {

                      add_datas(username_controller.text,password_controller.text,email_controller.text,);

                    }, child: Text("Register")),
              ),
            )
          ],
        ),
      ),
    );
  }

  void add_datas(String username, String password, String email) async{
    final datas = await SQFlite_Database.add_datas(username,password,email);
  }
}
