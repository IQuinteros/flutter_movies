import 'package:flutter/material.dart';
import 'package:flutter_movies/src/models/actors_model.dart';
import 'package:flutter_movies/src/models/movie_model.dart';
import 'package:flutter_movies/src/providers/movies_provider.dart';

class MovieDetailPage extends StatelessWidget {
   
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;
 
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _createAppBar(movie),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10.0),
                _postTitle(movie, context ),
                _description(movie),
                _description(movie),
                _description(movie),
                _description(movie),
                _description(movie),
                _description(movie),
                _description(movie),
                _description(movie),
                _createCast(movie)
              ]
            )
          )
        ],
      )
    );
  }

  Widget _createAppBar(Movie movie) {

    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.title,
          style: TextStyle(
             color: Colors.white,
             fontSize: 16.0
          ),
        ),
        background: FadeInImage(
            image: NetworkImage(movie.getBackgroundImg()),
            placeholder: AssetImage('assets/loading.gif'),
            fadeInDuration: Duration(milliseconds: 150),
            fit: BoxFit.cover
        ),
      ),
    );

  }

  Widget _postTitle(Movie movie, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0 ),
      child: Row(
        children: [
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(movie.getPosterImg()),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(width: 20.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title, style: Theme.of(context).textTheme.headline6, overflow: TextOverflow.ellipsis,),
                Text(movie.originalTitle, style: Theme.of(context).textTheme.subtitle1, overflow: TextOverflow.ellipsis,),
                Row(
                  children: [
                    Icon(Icons.star_border),
                    Text(movie.voteAverage.toString(), style: Theme.of(context).textTheme.subtitle1)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _description(Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _createCast(Movie movie) {
  
    final movieProvider = MoviesProvider();

    return FutureBuilder(
      future: movieProvider.getCast(movie.id.toString()),
      builder: (context, AsyncSnapshot<List> snapshot) {
        if(snapshot.hasData){
          return _createActorsToPageView(snapshot.data);
        }
        else{
          return Center(child: CircularProgressIndicator(),); 
        }
      },
    );

  }

  Widget _createActorsToPageView(List<Actor> data) {
     return SizedBox(
        height: 200.0,
        child: PageView.builder(
          pageSnapping: false,
          itemCount: data.length,
          controller: PageController(
            viewportFraction: 0.3,
            initialPage: 1
          ),
          itemBuilder: (context, i) => actorCard(data [i])
        ),
     );
  }

  Widget actorCard(Actor actor){
    final image = ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: FadeInImage(
        placeholder: AssetImage('assets/no-image.jpg'), 
        image: NetworkImage(actor.getPhoto()),
        height: 150.0,
        fit: BoxFit.cover,
      )
    ); 
    
    return Container(
      child: Column(
        children: [
          image,
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}