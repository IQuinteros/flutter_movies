 import 'package:flutter/material.dart';

import '../models/movie_model.dart';

class MovieHorizontal extends StatelessWidget {

  final List<Movie> movies;
  final Function nextPage;

  MovieHorizontal({Key key, @required this.movies, @required this.nextPage}) : super(key: key);

  final _pageController = PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200){
        nextPage();
      }
    });
    
    return Container(
      height: _screenSize.height * 0.2,
      child: PageView.builder(
        itemBuilder: (context, index) => _loadCard(context, movies[index]),
        itemCount: movies.length,
        pageSnapping: false,
        controller: _pageController,
      ),
    );
  }

  Widget _loadCard(BuildContext context, Movie movie){
    movie.uniqueId = '${movie.id}-minicard';

    final movieCard = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(movie.getPosterImg()),
                placeholder: AssetImage('assets/no-image.jpg'),
                fit: BoxFit.cover,
                height: 160.0,
              ),
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

    return GestureDetector(
      child: movieCard,
      onTap: ()  {
        Navigator.pushNamed(context, 'detail', arguments: movie ); 
      },
    );
  }
 
}