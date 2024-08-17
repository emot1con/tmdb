import 'package:flutter/material.dart';
import 'package:github_tmdb/features/movie/models/movie_models.dart';
import 'package:github_tmdb/repository/movie/movie_repository.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class UpcomingMovieProvider with ChangeNotifier {
  final MovieRepository _movieRepository = MovieRepository();

  bool _isLoading = false;
  final List<MovieModel> _upcomingMovies = [];

  bool get isLoading => _isLoading;
  List<MovieModel> get upcomingMovies => _upcomingMovies;

  void getUpcomingMovie(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    final movies = await _movieRepository.getUpcomingMovie();
    movies.fold(
      (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
        print('upcoming movies api failed');
      },
      (movieList) {
        _upcomingMovies.clear();
        _upcomingMovies.addAll(movieList.results);
        notifyListeners();
        print('upcoming movies api success');
      },
    );
    _isLoading = false;
    notifyListeners();
  }

  void getPagedUpcomingMovie(
    BuildContext context, {
    required PagingController pagingController,
    required int page,
  }) async {
    final movies = await _movieRepository.getUpcomingMovie(page: page);
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
