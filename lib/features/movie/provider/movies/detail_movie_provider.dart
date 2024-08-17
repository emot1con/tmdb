import 'package:flutter/material.dart';
import 'package:github_tmdb/features/movie/models/detail_model_movie.dart';
import 'package:github_tmdb/repository/movie/movie_repository.dart';

class DetailMovieProvier with ChangeNotifier {
  final MovieRepository _movieRepository = MovieRepository();
  bool _isLoading = false;
 DetailMovieModel? _detailMovies;

  bool get isLoading => _isLoading;
  DetailMovieModel? get detailMovies => _detailMovies!;

  void getDetailMovie(BuildContext context, {required int movieId}) async {
    _isLoading = true;
    notifyListeners();
    final movies = await _movieRepository.getDetailMovie(movieId: movieId);
    movies.fold(
      (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
        print('detail movies api failed');
      },
      (detail) {
        _detailMovies = detail;
        notifyListeners();
        print('detail movies api success');
      },
    );
    _isLoading = false;
    notifyListeners();
  }
}
