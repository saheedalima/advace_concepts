import 'package:flutter/material.dart';
void main(){
  runApp(MaterialApp(home: Welcome_Page(),));
}
class Welcome_Page extends StatefulWidget {

  @override
  State<Welcome_Page> createState() => _Welcome_PageState();
}

class _Welcome_PageState extends State<Welcome_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
      ),
      body: Center(
        child: Text("Welcome",style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold),),
      ),
    );
  }
}
