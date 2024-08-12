import 'package:flutter/material.dart';
import 'package:github_tmdb/features/movie/models/movie_models.dart';
import 'package:github_tmdb/repository/movie/movie_repository.dart';

class NowPlayingMovieProvider with ChangeNotifier {
  final MovieRepository _movieRepository = MovieRepository();

  bool _isLoading = false;
  final List<MovieModel> _popularMovies = [];

  bool get isLoading => _isLoading;
  List<MovieModel> get popularMovies => _popularMovies;

  void getNowPlayingMovie(BuildContext context, {int page = 1}) async {
    _isLoading = true;
    notifyListeners();
    final movies = await _movieRepository.getNowPlayingMovie();
    movies.fold(
      (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
        print('now playing movies api failed');
      },
      (movieList) {
        final movies = ListMovieModel.fromJson(movieList);
        _popularMovies.clear();
        _popularMovies.addAll(movies.results);
        notifyListeners();
        print('now playing movies api success');
      },
    );
    _isLoading = false;
    notifyListeners();
  }
}
