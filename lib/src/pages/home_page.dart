import 'package:flutter/material.dart';
import 'package:flutter_movies/src/providers/movies_provider.dart';
import 'package:flutter_movies/src/widgets/card_swiper_widget.dart';

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
          children: [
            _swiperTarjetas()
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
          return CardSwiper(
            movies: snapshot.data
          );
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
}