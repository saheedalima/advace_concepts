import 'package:advace_concepts/Shared%20Prefereces/Login_Page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late SharedPreferences logindata;
  late String username;
  @override
  void initState() {
    userdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(("My Prfile")),),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text("Welcome $username",style: TextStyle(fontSize: 24),),
            ElevatedButton(onPressed: (){
              logindata.setBool("firstlogin", true);
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Login_Page()));
            }, child: Text("Logout"))
          ],
        ),
      ),
    );
  }

  void userdata() async {
    logindata= await SharedPreferences.getInstance();
    setState(() {
      username= logindata.getString('username')!;
    });
  }
}
