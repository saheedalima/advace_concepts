import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
void main()async{
  await Hive.initFlutter();
  await Hive.openBox('todo_app');
  runApp(MaterialApp(home: TO_DO_APP(),));
}
class TO_DO_APP extends StatefulWidget {

  @override
  State<TO_DO_APP> createState() => _TO_DO_APPState();
}

class _TO_DO_APPState extends State<TO_DO_APP> {

   List<Map<String,dynamic>> datas = [];
 final taskname_controller= TextEditingController();
  final taskcontent_controller= TextEditingController();

  final hive_box=Hive.box('todo_app');

@override
  void initState() {
  readtask();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(title: Text("TODO App"),),
      body: datas.isEmpty ? Text("No datas found") :
      ListView.builder(
        itemCount: datas.length,
          itemBuilder: (context,index){
          final mytask= datas[index];
        return Card(
          child: ListTile(
            title: Text(mytask['taskname']),
            subtitle: Text(mytask['taskcontent']),
            trailing: Wrap(
              children: [
                IconButton(onPressed: (){
                  showtask(context, mytask['id']);
                }, icon: Icon(Icons.edit)),
                IconButton(onPressed: (){
                  delete_task(mytask['id']);

                }, icon: Icon(Icons.delete)),
              ],
            ),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(onPressed: (){
        showtask(context,null);
      }, child: Icon(Icons.task),),
    );
  }

  void showtask(BuildContext context,int? itemkey) {
    showModalBottomSheet(context: context, builder: (context){
      return Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom+120,
        top: 10,
        left: 10,
        right: 10),
        child: Column(
          children: [
            TextField(
              controller: taskname_controller,
              decoration: InputDecoration(
                hintText: "Enter taskname",
              ),
            ),
            TextField(
              controller: taskcontent_controller,
              decoration: InputDecoration(
                hintText: "Enter taskcontent",
              ),
            ),
            ElevatedButton(onPressed: (){
              if(itemkey==null){
                create_task({'taskname':taskname_controller.text.trim(),'taskcontent':taskcontent_controller.text.trim()});
              }
              taskname_controller.text ="";
              taskcontent_controller.text="";
              Navigator.of(context).pop();

              if(itemkey!=null){
                update_task(itemkey,{'taskname': taskname_controller.text,'taskcontent':taskcontent_controller.text});
              }
            }, child: Text(itemkey == null?"create task":"update task"))
          ],
        ),
      );
    });

  }

  Future<void> create_task(Map<String, dynamic> newtask) async {
    await hive_box.add(newtask);
    readtask();
  }

  Future<void> update_task(int? itekey, Map<String, String> uptask) async{
    await hive_box.put(itekey,uptask);
    readtask();
  }

  void readtask() {
    final task_from_hive = hive_box.keys.map((key) {
      final value= hive_box.get(key);
      return {'id': key , 'taskname':value['taskname'],'taskcontent':value['taskcontent']};
    }).toList();
    setState(() {
      datas = task_from_hive.reversed.toList();
    });
  }

  Future<void> delete_task(int itemkey)async {
    await hive_box.delete(itemkey);
    readtask();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfully deleted")));

  }
}
