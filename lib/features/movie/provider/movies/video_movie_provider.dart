import 'package:flutter/material.dart';
import 'package:github_tmdb/features/movie/models/video_movie_model.dart';
import 'package:github_tmdb/repository/movie/movie_repository.dart';

class VideoMovieProvider with ChangeNotifier {
  final MovieRepository _movieRepository = MovieRepository();

  VideoMovieModel? _videoMovies;

  VideoMovieModel? get videoMovies => _videoMovies;

  void getVideoMovie(BuildContext context, {required int movieId}) async {
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
  }
}
