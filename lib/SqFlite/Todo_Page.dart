import 'dart:ffi';

import 'package:flutter/material.dart';

import 'SQLFlite_database.dart';
void main(){
  runApp(MaterialApp(home: Home_Page(),));
}
class Home_Page extends StatefulWidget {
  const Home_Page({Key? key}) : super(key: key);

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {

  ///ee variable true aanenki circularprgress indicator kaanikknam,athayath data onnum illa. false aanenkii Listview.builderum
  ///datavarumbo listview.builderum
  bool isLoading=true;
  ///to fetch data from database(sqflite)
  ///ithinte akathekkanu dtatabasile values fetch cheyth edukunnath
  List<Map<String,dynamic>> contact=[];

  @override
  void initState() {
    refreshUi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(title: Text("SQLFlite Database"),),

        ///data illathapozhulla onnum illathappzhullathum data varumbo ullathum ternary operatoril koduthirikkunnu
        ///veneki firstile variablil blank screen aakki idam,no data nnull text kodukam

        body: isLoading ? Center(child: CircularProgressIndicator()) : ListView.builder(
          itemCount: contact.length,
            itemBuilder: (context,index){
              Card(
                child: ListTile(
                  title: Text(contact[index]['cname']),
                  subtitle: Text(contact[index]['cnumber']),
                  trailing: Wrap(
                    children: [
                      IconButton(onPressed: (){
                        showsheet(contact[index]['id']);
                      }, icon: Icon(Icons.edit)),
                      IconButton(onPressed: (){
                        deletecontact(contact[index]['id']);
                      }, icon: Icon(Icons.delete)),
                    ],
                  ),
                ),
              );
        }),
        ///valuesonnum varunnilla oru empty sheetanu varendathtenkil null,value pass cheyynm,
        ///values ullathanenki avide id pass cheyyanam
        ///ivide null value aanenki id onnum illenki empty aayirikum.create cheyyn
        floatingActionButton: FloatingActionButton(onPressed: ()=>showsheet(null),
        child: Icon(Icons.add),),
      );
  }
  final name_controller=TextEditingController();
  final num_controller=TextEditingController();

///kure contacts undakumbo onnil click cheyyumbo athinte corresponding data varanm..
  ///angane oru particular contact varan id vekknm. aa id vachaanu oru particular contact edukkunnath

  void showsheet(int? id) async{  ///databasilekk add cheyynm avidunn edukkknm athinokke asynchronous
    if(id!=null){
      final existingdata=contact.firstWhere((element) => element['id']==id);
      name_controller.text=existingdata['cname'];
      num_controller.text=existingdata['cnumber'];
    }
    showModalBottomSheet(
      elevation: 5,  /// keybord vannitt mukalilekk pongi poovn
        isScrollControlled: true,  ///mediaquerry anusarich screen scrll avaan
        context: context, builder: (context)=>Container(
      ///containerinu padding kodukkanam.illenki screeninte full bottom sheet edukkum
      padding: EdgeInsets.only(
        top: 15,
        left: 15,
        right: 15,
          ///key board pongi varumbo bottomsheetil overflow varathirikkan.veruthe pading kodutha varill media querrry upayogikanam
          ///here mediaquerry is to avoid overflow
          ///contentinu anusarich settvan.120 kodutha norally ella screeninum settavum

        bottom: MediaQuery.of(context).viewInsets.bottom+120
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,     ///screeninte full sizum edukkathe contentinu anusarich size edukkan
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            controller: name_controller,
            decoration: InputDecoration(
              hintText: "contact name",
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: num_controller,
            decoration: InputDecoration(
              hintText: "contact number ",
            ),
          ),
          SizedBox(height: 10,),

          ///pass cheytha id il valuesonnum illenki create cheyyan
          ElevatedButton(onPressed: () async{
            if(id==null){
              await createcontact();
            }
            ///button click cheyyumbo textfield clear cheyyan.empty aaki koduthu
            name_controller.text="";
            num_controller.text="";
            ///to close the current window
            Navigator.of(context).pop();

            ///id il valuesindenkii edit cheyyan
            if(id!=null) {
              ///id pass cheyynm.
              ///databasile eath table il evidathe value aanennn ariyunnath id vachaanu
              await updatecontact(id);
            }
            ///ternery operator is used
          }, child: (id==null)?Text("Create contact"): Text("Update contact"))
        ],
      ),
    ));
  }
  ///to add new contact to sqflite
  ///asynchronous aayathu kond futurevoid
  ///asynchronous functionte ullil kodutha method aayathukond future<void>
  ///future<void> aayi koduthal databse connectivity success aan enn ariyan apttum
  ///databsil evideyann nokk ath cross check cheyum
 Future<void> createcontact() async{
    await SQLHelper.create_contact(name_controller.text,num_controller.text);
    refreshUi();
  }
///refresh ui when new contact added/ delete/ update etc
  ///ui il nadakkunna operation aanu athinte already setstate und athukond future<void> aakkanda
  void refreshUi() async{
    ///databasinn value eduth store cheythu
    final data = await SQLHelper.getdatas();
     setState(() {   ///value change cheyyum athkond
       contact = data;
       isLoading = true;

     });
  }

 Future<void> updatecontact(int id) async {
    await SQLHelper.updateContact(id,name_controller.text,num_controller.text);
    refreshUi();

 }

  void deletecontact(int id) async {
    await SQLHelper.deletecontact(id);
    refreshUi();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfully Deleted")));

  }
}
