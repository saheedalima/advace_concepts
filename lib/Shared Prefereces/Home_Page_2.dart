import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home_Page_2 extends StatefulWidget {

  @override
  State<Home_Page_2> createState() => _Home_Page_2State();
}

class _Home_Page_2State extends State<Home_Page_2> {

  late SharedPreferences homepreferences;
  late String username;

  @override
  void initState() {
    userdata();
    super.initState();
  }

  void userdata() async {
    homepreferences= await SharedPreferences.getInstance();
    username=homepreferences.getString('userame')!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(("Welcme $username"),style: TextStyle(fontSize: 30),)
          ],
        ),
      ),
    );
  }
}

