import 'package:flutter/material.dart';
import 'package:github_tmdb/features/movie/models/video_movie_model.dart';
import 'package:github_tmdb/repository/movie/movie_repository.dart';

class VideoMovieProvider with ChangeNotifier{
  final MovieRepository _movieRepository = MovieRepository();
  bool _isLoading = false;
  VideoMovieModel? _videoMovies;

  bool get isLoading => _isLoading;
  VideoMovieModel? get videoMovies => _videoMovies;

  void getDetailMovie(BuildContext context, {required int movieId}) async {
    _isLoading = true;
    notifyListeners();
    final movies = await _movieRepository.getVideoMovie(movieId: movieId);
    movies.fold(
      (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
        print('detail movies api failed');
      },
      (detail) {
        _videoMovies = detail;
        notifyListeners();
        print('detail movies api success');
      },
    );
    _isLoading = false;
    notifyListeners();
  }
}