import 'package:advace_concepts/SqFlite/Login_Page.dart';
import 'package:advace_concepts/SqFlite/SQFlite_Dtabase_of_Login.dart';
import 'package:flutter/material.dart';
void main(){
  runApp(MaterialApp(home: Registration_Page(),));
}
class Registration_Page extends StatefulWidget {

  @override
  State<Registration_Page> createState() => _Registration_StatefulState();
}

class _Registration_StatefulState extends State<Registration_Page> {

  final username_controller=TextEditingController();
  final password_controller=TextEditingController();
  final email_controller=TextEditingController();
  final confirm_pass_controller=TextEditingController();

  bool showpass=true;
  var formkey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registratin Page"),),
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
                    ///form keyde current state validate aanenki,valdation ok aanenki error illenkii validate1
                    final validate1=formkey.currentState!.validate();
                    if(validate1) {
                      ///if form state is valid data from the textfield will upload to db
                      ///upload cheyyunna value empty alla avide athu pole oru value indenkii useralready exist
                      ///allenkii new user
                      var data = await SQL_Login.userfounded(username_controller.text,email_controller.text);
                      if(data.isNotEmpty){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
                          "user already exist"
                        )));
                      }else {
                        addnewuser(
                            username_controller.text, email_controller.text,
                            password_controller.text);
                      }
                    }
                    }, child: Text("Register")),
              ),
            )
          ],
        ),
      ),
    );
  }
  void addnewuser(String name, String email, String password) async {
    var id= await SQL_Login.add_newuser(name,email,password);
    ///if registratino is success go to login
    ///databasilekk values store aayitundenkil or id null allenki loginpagilek povuka
    if(id!=null){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Login_Page()));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registration not successful")));
    }
  }
}
