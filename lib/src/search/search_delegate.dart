import 'package:flutter/material.dart';
import 'package:flutter_movies/src/models/movie_model.dart';
import 'package:flutter_movies/src/providers/movies_provider.dart';

class DataSearch extends SearchDelegate {

  String selection = '';
  final moviesProvider = MoviesProvider();

  final movies = [
    'Spiderman',
    'Aquaman',
    'Batman',
    'Shazam!',
    'Ironman',
    'Capitan america',
  ];
  final recentMovies = [
    'Spiderman',
    'Capitan america'
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    // AppBar actions
    return [
      IconButton(
        icon: Icon(Icons.clear), 
        onPressed: (){
          query = '';
        }
      )
    ];
  }
  
  @override
  Widget buildLeading(BuildContext context) {
    // Appbar left icon
    return IconButton(
      icon: AnimatedIcon(
        progress: transitionAnimation,
        icon: AnimatedIcons.menu_arrow,
      ), 
      onPressed: (){
        close(context, null);
      }
    );
  }
  
  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.redAccent,
        child: Text(selection),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if(query.isEmpty)
      return Container();
    
    return FutureBuilder(
      future: moviesProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if(snapshot.hasData){
          final movies = snapshot.data;

          return ListView(
            children: movies.map((e){
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(e.getPosterImg()),
                  placeholder: AssetImage('assets/no-image.jpg'),
                  fit: BoxFit.contain,
                  width: 50.0,
                ),
                title: Text(e.title),
                subtitle: Text(e.originalTitle),
                onTap: (){
                  close(context, null);
                  e.uniqueId = '';
                  Navigator.pushNamed(context, 'detail', arguments: e);
                },
              );
            }).toList()
          );
        }else{
          return Center(child: CircularProgressIndicator(),);
        }
      },
    );

  }
  
  /*
  @override
  Widget buildSuggestions(BuildContext context) {
    // Suggestions when user write
    final suggestedList = query.isEmpty? recentMovies
      : movies.where((element) => element.toLowerCase().startsWith(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: suggestedList.length,
      itemBuilder: (context, i){
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(suggestedList[i]),
          onTap: (){ 
            selection = suggestedList[i];
            showResults(context);
          },
        );
      }
    );
  }*/

}