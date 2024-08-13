import 'package:flutter/material.dart';
import 'package:github_tmdb/features/movie/models/movie_models.dart';
import 'package:github_tmdb/repository/movie/movie_repository.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

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
        _popularMovies.clear();
        _popularMovies.addAll(movieList.results);
        notifyListeners();
        print('now playing movies api success');
      },
    );
    _isLoading = false;
    notifyListeners();
  }

   void getPagedNowPlayingMovie(
    BuildContext context, {
    required PagingController pagingController,
    required int page,
  }) async {
    final movies = await _movieRepository.getNowPlayingMovie(page: page);
    movies.fold((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error),
      ));
      pagingController.error = error;
      return;
    }, (movieList) {
      if (movieList.results.length < 20) {
        pagingController.appendLastPage(movieList.results);
      } else {
        pagingController.appendPage(movieList.results, page + 1);
      }
      return;
    });
  }
}
