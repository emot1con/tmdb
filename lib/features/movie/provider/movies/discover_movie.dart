import 'package:flutter/material.dart';
import 'package:github_tmdb/features/movie/models/movie_models.dart';
import 'package:github_tmdb/repository/movie/movie_repository.dart';

class DiscoverMovieProvider with ChangeNotifier {
  final MovieRepository _movieRepository = MovieRepository();

  bool _isLoading = false;
  final List<MovieModel> _dicoverMovies = [];

  bool get isLoading => _isLoading;
  List<MovieModel> get discoverMovies => _dicoverMovies;

  void getDiscoverMovie(BuildContext context, {int page = 1}) async {
    _isLoading = true;
    notifyListeners();
    final movies = await _movieRepository.getDiscoverMovie();
    movies.fold(
      (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
        print('api failed');
      },
      (movieList) {
        final movies = ListMovieModel.fromJson(movieList);
        _dicoverMovies.clear();
        _dicoverMovies.addAll(movies.results);
        notifyListeners();
        print('api success');
      },
    );
    _isLoading = false;
    notifyListeners();
  }
}
