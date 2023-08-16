import 'dart:math';

import 'package:flutter/material.dart';

import '../model/Movie.dart';
//we pass the modelclass(movie) in the List.so the data access are through the model class
final List<Movie> movielist = List.generate(100,
        //radom  - geting rardom value from 60- 160
        (index) => Movie(title: 'Movie $index', time: '${Random().nextInt(100)+60} minutes'));//index-adding movies one by one

//
class MovieProvider with ChangeNotifier{ //provider vazhi add cheyyumbazhum remove cheyyumbazhum ee notifieraanu changes fetch cheyyunnah
  //to set private
  final List<Movie> _movie = movielist;  //data that we created List.generate movie - pass chryhtha model class
                                       //data for main page
  List<Movie> get movies=> _movie;     //geter function
//this is whishlist page storing
  final List<Movie> _moviewishlist= [];
  List<Movie> get moviewish =>_moviewishlist; //
///to add selected movie to wishlist
void addToList(Movie movieFromMainPage){  ///data ullath model classilayathukond model class pass cheythu koduthu
  _moviewishlist.add(movieFromMainPage);
  notifyListeners();
}
///to remove selected movie from wishlist
void removeFromList(Movie removedMovie){
  _moviewishlist.remove(removedMovie);
  notifyListeners();
}

}