import 'package:movie_db/Backend/src/models/details_api.dart';
import 'package:movie_db/Backend/src/models/list_api.dart';
import 'package:rxdart/rxdart.dart';

import '../resources/repository.dart';

class MoviesBloc {
  final _repository = Repository();
  final _moviesFetcher = PublishSubject<MovieModel>();
  final _detailsFetcher = PublishSubject<DetailModel>();

  Observable<MovieModel> get allMovies => _moviesFetcher.stream;
  Observable<DetailModel> get detailInfo => _detailsFetcher.stream;

  fetchAllMovies() async {
    MovieModel itemModel = await _repository.fetchAllMovies();
    _moviesFetcher.sink.add(itemModel);
  }

  fetchDetails(int id) async {
    DetailModel detailModel = await _repository.fetchDetails(id);
    _detailsFetcher.sink.add(detailModel);
  }

  dispose() {
    _moviesFetcher.close();
    _detailsFetcher.close();
  }
}

final bloc = MoviesBloc();
