import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

void main()async{
  ///closed statil irikkunna databasine open cheyyan
  await Hive.initFlutter();
  await Hive.openBox('todo_box');
  runApp(MaterialApp(home: CURD_Hive(),));
}

class CURD_Hive extends StatefulWidget {

  @override
  State<CURD_Hive> createState() => _CURD_HiveState();
}

class _CURD_HiveState extends State<CURD_Hive> {
  
  List<Map<String,dynamic>>task = [];

  final title = TextEditingController();
  final taskname = TextEditingController();

  ///hive object
  final my_box=Hive.box('todo_box');

  ///oro pravashyavum hivil add cheyyunna data ui il kaanikkn
  @override
  void initState() {
    readtask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("CURD Hive"),),
      body: task.isEmpty ? 
      Text("NO data"): 
      ListView.builder(
        itemCount: task.length,
          itemBuilder: (context,index){
          ///mytask will be map.
            ///taskile oro indexilem values my taskilek varum
          final mytask=task[index];

        return Card(
          child: ListTile(
            //title: Text(task[index][key]),  inganem cheyyam
            title: Text(mytask['taskname']),
            subtitle: Text(mytask['taskcontent']),
            trailing: Wrap(
              children: [
                IconButton(onPressed: (){
                  showTask(context, mytask['id']);
                }, icon: Icon(Icons.edit)),
                IconButton(onPressed: (){
                  deletetask(mytask['id']);
                }, icon: Icon(Icons.delete)),
              ],
            ),
          ),
        );
      }),
      ///buildinte purathu create cheyyunna method aayathond context pass cheythu
      ///buildinte purathu cerate cheytha aa methondinte namukk evide venelum vilikkam
      floatingActionButton: FloatingActionButton(onPressed: ()=>showTask(context,null),
        child: Icon(Icons.task),
      ),
    );
  }
//itemkey - similar to id in sqflite,
  //id kk pakaram id enn represent cheyyan illathathukond
 void showTask(BuildContext context, int? itemkey) {
    ///ipo 2 aamathe itemaanu click cheyyunnath ennunedenkil hivile 2nd id yum ivide varunna 2nd id yum
   ///same aanenki 2nd id yile data eduth existing data ennulla variable lekk store cheyyunnu
    if(itemkey!=null){
      //databasile id ividuthe id(itemkey) yum same aaanonn nokkum
      //task - ella valuesum store aavunna list<map> aayitayirikum,
      //databasile id yum itemkeyum equal aanonn nokknm
      //taskile id um databasile id um same aaki
      ///already data undonn cheack cheyyan
      ///'id' - databasile key. itemkey - hive le id
      ///edit cheyyumbo corresponding id(itemkey) yil ulla data eduth existing data ennulla variable lekk store cheythu
      final existingtask= task.firstWhere((element) => element['id']==itemkey);
      //databasil create cheyyunna key aanu 'taskname' , 'taskcontent'
      //textfieldile value taskile values store cheythekkunna variable lekk databasile key kal pass cheythu
      title.text    = existingtask['taskname'];
      taskname.text = existingtask['taskcontent'];
    }
    showModalBottomSheet(context: context, builder: (context){
      return Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom+120,
        top: 15,
        left: 15,
        right: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: title,
              decoration: InputDecoration(
                hintText: " task name",
              ),
            ),
            TextField(
              controller: taskname,
              decoration: InputDecoration(
                hintText: " task content",
              ),
            ),
            ElevatedButton(onPressed: (){
              if(itemkey==null){
                //key value pair aayathond map aayi create cheythu.
                createtask( {'taskname' : title.text.trim(), 'taskcontent': taskname.text.trim()});
              }
              if(itemkey != null){

                updatetask(itemkey, {'taskname' : title.text, 'taskcontent' : taskname.text});
              }
              title.text ="";
              taskname.text="";
              Navigator.of(context).pop();

            }, child: Text(itemkey == null ? "create contact" : "update contact"))
          ],
        ),
      );
    });
  }

  Future<void> createtask(Map<String, dynamic> newtask) async {
//databasilekk values add cheyyan
    await my_box.add(newtask);
    ///puthiya enth data add cheythalumi lekkm varaan
    readtask();

  }
///uptask databasile mapile values store aavum
  Future<void> updatetask(int itemkey, Map<String, String> uptask) async{
    await my_box.put(itemkey, uptask);
    readtask();
  }
///oro pravashyavum hivil add cheyyunna data ui il kaanikkn
  void readtask() {
    ///assending orderil ids aakn
    ///assendig orderil ella ids um keyil store aavum
    final task_from_hive= my_box.keys.map((key) { //fetch all the key in assending order
      final value= my_box.get(key);
        return {'id': key , 'taskname' : value['taskname'], 'taskcontent' : value['taskcontent']};

        ///kittunna data map aanu listilekk convert cheythaale ui lekk konduvaraan pattullu
    }).toList();

    setState(() {
      ///aadyam create cheythth aadyam varaan reversed
      ///listayitavan to list-ui setvn
      ///datas muzhuvan task_from_hive il und ath taskilekk assign cheythukoduthu
      task = task_from_hive.reversed.toList();
    });
  }

  Future<void> deletetask(int itemkey) async{
    await my_box.delete(itemkey);
    readtask();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfully deleted")));

  }
}
