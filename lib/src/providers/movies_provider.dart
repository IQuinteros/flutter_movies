
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_movies/src/models/movie_model.dart';

class MoviesProvider{
  String _apiKey    = '7faa93e88b84c93bd99be57222ae9f51';
  String _url       = 'api.themoviedb.org';
  String _language  = 'es-ES';

  Future<List<Movie>> getNowPlaying() async {

    final url = Uri.https(_url, '/3/movie/now_playing', {
      'api_key'   :  _apiKey,
      'language'  : _language
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final movies = Movies.fromJsonList(decodedData['results']);

    return movies.items;

  }
}