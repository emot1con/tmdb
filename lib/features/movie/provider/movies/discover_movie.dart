import 'dart:async';

import 'package:flutter/material.dart';
import 'package:github_tmdb/features/movie/models/movie_models.dart';
import 'package:github_tmdb/repository/movie/movie_repository.dart';

class DiscoverMovieProvider with ChangeNotifier {
  final MovieRepository _movieRepository = MovieRepository();

  bool _isLoading = false;
  final List<MovieModel> _dicoverMovies = [];
  int _currentPage = 0;
  Timer? _timer;

  int currentPageIndex = 0;
  PageController pageController = PageController();
  bool get isLoading => _isLoading;
  List<MovieModel> get discoverMovies => _dicoverMovies;

  void updatePageIndicator(int index) {
    currentPageIndex = index;
    notifyListeners();
  }

  void automaticallyScrollPageView() {
   _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
    if (_currentPage < discoverMovies.length) {
      _currentPage++;
    } else {
      _currentPage = 0;
    }

    pageController.animateToPage(
      _currentPage,
      duration:const  Duration(milliseconds: 350),
      curve: Curves.easeIn,
    );
  });
  }

 

  void getDiscoverMovie(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    final movies = await _movieRepository.getDiscoverMovie();
    movies.fold(
      (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
        print('discover movies api failed');
      },
      (movieList) {

        _dicoverMovies.clear();
        _dicoverMovies.addAll(movieList.results);
        currentPageIndex = _dicoverMovies.length;
        notifyListeners();
        print('discover movies api success');
      },
    );
    _isLoading = false;
    notifyListeners();
  }
  
}


