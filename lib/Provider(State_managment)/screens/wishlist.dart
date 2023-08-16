import 'package:advace_concepts/Provider/provider/movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/movie_provider.dart';

class wishlist extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var mywishlist = context.watch<MovieProvider>().moviewish;

    return Scaffold(
      appBar: AppBar(title: Text("Wishlist"),),
      body: ListView.builder(
        itemCount: mywishlist.length,
          itemBuilder: (context,index){
          final movie = mywishlist[index];
          return Card(
            child: ListTile(
              title: Text(movie.title),
              subtitle: Text(movie.time ?? 'no time'),
              trailing: TextButton(onPressed: (){
                context.read<MovieProvider>().removeFromList(movie);
              }, child: Text("Remove")),
            ),
          );
          }),
    );
  }
}
