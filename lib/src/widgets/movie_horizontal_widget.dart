import 'package:flutter/material.dart';

import '../models/movie_model.dart';

class MovieHorizontal extends StatelessWidget {

  final List<Movie> movies;

  const MovieHorizontal({Key key, @required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    
    return Container(
      height: _screenSize.height * 0.2,
      child: PageView(
        children: _cards(context),
        pageSnapping: false,
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.3,
        ),
      ),
    );
  }

  List<Widget> _cards(BuildContext context){

    return movies.map((movie){
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(movie.getPosterImg()),
                placeholder: AssetImage('assets/no-image.jpg'),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );
    }).toList();

  }
}