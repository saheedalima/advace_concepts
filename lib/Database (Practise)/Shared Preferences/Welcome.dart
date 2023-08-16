import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome User..."),),
      body: Center(
        child: Text("Welcome "),
      ),
    );
  }
}
