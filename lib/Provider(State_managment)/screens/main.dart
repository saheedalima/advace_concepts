import 'package:advace_concepts/Provider(State_managment)/screens/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/movie_provider.dart';
void main(){
  runApp(ChangeNotifierProvider(
      create: (BuildContext context)=>MovieProvider(),
  child: MaterialApp(home: MainPage(),),));
}

class MainPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    ///list for whishlist page
    var myflist = context.watch<MovieProvider>().moviewish;
    ///list for main page
    ///here we will only read the values, we will not rebuild the widget here
    var movies = context.watch<MovieProvider>().movies;  //only just take the data

    return Scaffold(
      appBar:  AppBar(title: Text("Movies"),),
      body: Padding(padding: EdgeInsets.all(10),
      child: Column(
        children: [
          ElevatedButton.icon(onPressed: (){

            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>wishlist()));

          }, icon: Icon(Icons.favorite), label: Text("My Favorite ${myflist.length}")),
          //take full size of remaining screen
          Expanded(child: ListView.builder(
            itemCount: movies.length,
              itemBuilder: (context,index){
              final currentmovie = movies[index];  //movies is a list <map> current movie is map
              return Card(
                child: ListTile(
                  title: Text(currentmovie.title),
                  subtitle: Text(currentmovie.time ?? 'No time'), //this is null cheack so ternary operator.(null cheack operator)
                  trailing: IconButton(icon:Icon(Icons.favorite),
                    color: myflist.contains(currentmovie)?Colors.red:Colors.white, //click cheyyunna data wishlistil undonn nokn
                                                                                 //contains- particular data list il undon check cheyyan
                    onPressed: () {
                      if(!myflist.contains(currentmovie)){  //!-not contains
                        ///add to list is add to wishlist
                        context.read<MovieProvider>().addToList(currentmovie);  //read- widget tree rebuil cheyyan
                      }else{
                        context.read<MovieProvider>().removeFromList(currentmovie);
                      }
                    },),
                ),
              );
              }))
        ],
      ),),
    );
  }
}
