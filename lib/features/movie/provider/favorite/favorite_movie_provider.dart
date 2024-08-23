import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:github_tmdb/features/movie/models/movie_models.dart';
import 'package:github_tmdb/repository/movie/movie_repository.dart';

class FavoriteMovieProvider with ChangeNotifier {
  final MovieRepository _movieRepository = MovieRepository();
  List<FavoriteMovieModel>? _favoriteMovies;
  bool _isLoading = false;
  bool isFavorite = false;

  bool get isLoading => _isLoading;

  List<FavoriteMovieModel>? get favoriteMovies => _favoriteMovies;

  void setFavoriteMovies(int movieId, String poster) async {
    try {
      await _movieRepository.setFavoriteMovies(
          movieId: movieId, poster: poster);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> getAllFavoriteMovies() async {
    _isLoading = true;
    notifyListeners();
    try {
      final favoriteMovies = await _movieRepository.getAllFavoriteMovies();
      _favoriteMovies = favoriteMovies;
      _favoriteMovies?.forEach((movie) {
        print(movie.movieId);
      });
    } catch (e) {
      throw e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void isFavorites(int movieId) async {
    try {
      final favorite = await FirebaseFirestore.instance
          .collection('Favorite Movie')
          .doc(movieId.toString())
          .get();
      isFavorite = favorite.exists;
      notifyListeners();
      print('$isFavorite provider');
    } catch (e) {
      throw e.toString();
    }
  }
}
