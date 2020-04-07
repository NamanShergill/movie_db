class MovieModel {
  int _page;
  int _total_results;
  int _total_pages;
  List<_Result> _results = [];

  MovieModel.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['results'].length);
    _page = parsedJson['page'];
    _total_results = parsedJson['total_results'];
    _total_pages = parsedJson['total_pages'];
    List<_Result> temp = [];
    for (int i = 0; i < parsedJson['results'].length; i++) {
      _Result result = _Result(parsedJson['results'][i]);
      temp.add(result);
    }
    _results = temp;
  }
  List<_Result> get results => _results;
  int get total_pages => _total_pages;
  int get total_results => _total_results;
  int get page => _page;
}

class _Result {
  int _id;
  String _title;
  String _poster_path;
  List<int> _genre_ids = [];
  String _release_date;

  _Result(result) {
    _id = result['id'];
    _title = result['title'];
    _poster_path = result['poster_path'];
    for (int i = 0; i < result['genre_ids'].length; i++) {
      _genre_ids.add(result['genre_ids'][i]);
    }
    _release_date = result['release_date'];
  }

  String get release_date => _release_date;

  List<int> get genre_ids => _genre_ids;

  String get poster_path => _poster_path;

  String get title => _title;

  int get id => _id;
}
