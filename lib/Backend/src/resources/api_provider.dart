import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:movie_db/Backend/src/models/details_api.dart';
import 'package:movie_db/Backend/src/models/list_api.dart';

class MovieApiProvider {
  Client client = Client();
  final _apiKey = '33cbc1b93cb2409536e2cc55d9004119';

  Future<MovieModel> fetchMovieList() async {
    print("entered");
    final response = await client
        .get("http://api.themoviedb.org/3/movie/popular?api_key=$_apiKey");
    print(response.body.toString());
    if (response.statusCode == 200) {
      return MovieModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error');
    }
  }

  Future<DetailModel> fetchDetails(int movieId) async {
    final response = await client
        .get("http://api.themoviedb.org/3/movie/$movieId?api_key=$_apiKey");

    if (response.statusCode == 200) {
      return DetailModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error');
    }
  }
}
