import 'package:advace_concepts/SqFlite/SQFlite_Dtabase_of_Login.dart';
import 'package:flutter/material.dart';

class Admin_Page extends StatefulWidget {

  @override
  State<Admin_Page> createState() => _Admin_PageState();
}

class _Admin_PageState extends State<Admin_Page> {

   List<Map<String,dynamic>> values=[];
   var data;


   @override
  void initState() {
     admin();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Admin Page"),),
      body: ListView.builder(
        itemCount: values.length,
          itemBuilder: (context,index){
        return ListTile(
          title: Text(values[index]['email']),
          subtitle: Text(values[index]['password']),
        );
      }),
    );
  }

  void admin() async {
     final id = await SQL_Login.getAdmin_values();
     setState(() {
       values=data;
     });
  }
}
