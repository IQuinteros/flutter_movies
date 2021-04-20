import 'package:flutter/material.dart';
import 'package:flutter_movies/src/providers/movies_provider.dart';
import 'package:flutter_movies/src/widgets/card_swiper_widget.dart';
import 'package:flutter_movies/src/widgets/movie_horizontal_widget.dart';

class HomePage extends StatelessWidget {

  final MoviesProvider moviesProvider = MoviesProvider();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Películas en cines'),
        backgroundColor: Colors.indigoAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.search), 
            onPressed: (){}
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _swiperTarjetas(),
            _footer(context)
          ],
        ),
      )
    );
  }

  Widget _swiperTarjetas(){
    return FutureBuilder(
      future: moviesProvider.getNowPlaying(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if(snapshot.hasData){
          return CardSwiper( movies: snapshot.data );
        }
        else{
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator()
              
            )
          );
        }
      },
    );

  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text('Populares', style: Theme.of(context).textTheme.subtitle1)
          ),
          SizedBox(height: 5.0),
          FutureBuilder(
            future: moviesProvider.getPopulars(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if(snapshot.hasData){
                return MovieHorizontal(
                  movies: snapshot.data
                );
              }
              else{
                return Container(
                  height: 400.0,
                  child: Center(
                    child: Center(child: CircularProgressIndicator())
                    
                  )
                );
              }
            },
          ),
        ],
      )
    );
  }
}