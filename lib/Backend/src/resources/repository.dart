import 'dart:async';

import 'package:movie_db/Backend/src/models/details_api.dart';
import 'package:movie_db/Backend/src/models/list_api.dart';

import 'api_provider.dart';

class Repository {
  final moviesApiProvider = MovieApiProvider();

  Future<MovieModel> fetchAllMovies() => moviesApiProvider.fetchMovieList();

  Future<DetailModel> fetchDetails(int movieId) =>
      moviesApiProvider.fetchDetails(movieId);
}
