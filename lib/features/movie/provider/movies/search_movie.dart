import 'package:flutter/material.dart';
import 'package:github_tmdb/features/movie/models/movie_models.dart';
import 'package:github_tmdb/repository/movie/movie_repository.dart';

class SearchMovieProvider with ChangeNotifier {
  final MovieRepository _movieRepository = MovieRepository();

  bool _isLoading = false;
  final List<MovieModel> _popularMovies = [];

  final TextEditingController controller = TextEditingController();
  bool get isLoading => _isLoading;
  List<MovieModel> get popularMovies => _popularMovies;

  void getSearchMovie(BuildContext context, String query) async {
    _isLoading = true;
    notifyListeners();
    final movies = await _movieRepository.getSearchMovie(query: query);
    movies.fold(
      (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
        print('search movies api failed');
      },
      (movieList) {
        _popularMovies.clear();
        _popularMovies.addAll(movieList.results);
        notifyListeners();
        print('search movies api success');
      },
    );
    _isLoading = false;
    notifyListeners();
  }
}

