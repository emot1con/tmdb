import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';

import 'package:github_tmdb/constant/api_constants.dart';
import 'package:github_tmdb/features/movie/models/detail_model_movie.dart';
import 'package:github_tmdb/features/movie/models/movie_models.dart';
import 'package:github_tmdb/features/movie/models/video_movie_model.dart';

class MovieRepository with ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      queryParameters: {'api_key': ApiConstants.apiKey},
    ),
  );

  Future<Either<String, ListMovieModel>> getDiscoverMovie(
      {int page = 1}) async {
    try {
      final response = await dio.get(
        '/discover/movie?api_key=${ApiConstants.apiKey}&page=$page',
      );
      if (response.statusCode == 200 && response.data != null) {
        final data = ListMovieModel.fromJson(response.data);
        return Right(data);
      } else {
        return const Left('Something went wrong.');
      }
    } on DioException catch (e) {
      return Left(e.message!);
    }
  }

  Future<Either<String, ListMovieModel>> getPopularMovie({int page = 1}) async {
    try {
      final response = await dio.get(
        '/movie/top_rated?api_key=${ApiConstants.apiKey}&page=$page',
      );
      if (response.statusCode == 200 && response.data != null) {
        final data = ListMovieModel.fromJson(response.data);

        return Right(data);
      } else {
        return const Left('Something went wrong.');
      }
    } on DioException catch (e) {
      return Left(e.message!);
    }
  }

  Future<Either<String, ListMovieModel>> getNowPlayingMovie(
      {int page = 1}) async {
    try {
      final response = await dio.get(
        '/movie/now_playing?api_key=${ApiConstants.apiKey}&page=$page',
      );
      if (response.statusCode == 200 && response.data != null) {
        final data = ListMovieModel.fromJson(response.data);

        return Right(data);
      } else {
        return const Left('Something went wrong.');
      }
    } on DioException catch (e) {
      return Left(e.message!);
    }
  }

  Future<Either<String, ListMovieModel>> getUpcomingMovie(
      {int page = 1}) async {
    try {
      final response = await dio.get(
        '/movie/upcoming?api_key=${ApiConstants.apiKey}&page=$page',
      );
      if (response.statusCode == 200 && response.data != null) {
        final data = ListMovieModel.fromJson(response.data);

        return Right(data);
      } else {
        return const Left('Something went wrong.');
      }
    } on DioException catch (e) {
      return Left(e.message!);
    }
  }

  Future<Either<String, ListMovieModel>> getSearchMovie(
      {required String query}) async {
    try {
      final response = await dio.get(
        '/search/movie?api_key=${ApiConstants.apiKey}&query=$query',
      );
      if (response.statusCode == 200 && response.data != null) {
        final data = ListMovieModel.fromJson(response.data);

        return Right(data);
      } else {
        return const Left('Something went wrong.');
      }
    } on DioException catch (e) {
      return Left(e.message!);
    }
  }

  Future<Either<String, DetailMovieModel>> getDetailMovie(
      {required int movieId}) async {
    try {
      final response = await dio.get(
        '/movie/$movieId?api_key=${ApiConstants.apiKey}&page=1',
      );
      if (response.statusCode == 200 && response.data != null) {
        final data = DetailMovieModel.fromJson(response.data);

        return Right(data);
      } else {
        return const Left('Something went wrong.');
      }
    } on DioException catch (e) {
      return Left(e.message!);
    }
  }

  Future<Either<String, VideoMovieModel>> getVideoMovie({
    required int movieId,
  }) async {
    try {
      final response = await dio.get(
        '/movie/$movieId/videos?api_key=${ApiConstants.apiKey}',
      );
      if (response.statusCode == 200 && response.data != null) {
        final data = VideoMovieModel.fromJson(response.data);

        return Right(data);
      } else {
        return const Left('Something went wrong.');
      }
    } on DioException catch (e) {
      return Left(e.message!);
    }
  }

  Future<void> setFavoriteMovies({
    required int movieId,
    required String poster,
  }) async {
    try {
      final favoriteMovies =
          await _db.collection('Favorite Movie').doc(movieId.toString()).get();
      if (!favoriteMovies.exists) {
        await _db.collection('Favorite Movie').doc(movieId.toString()).set({
          'movieId': movieId,
          'poster': poster,
        });
        return;
      }
      deleteFavoriteMovie(movieId);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> deleteFavoriteMovie(int movieId) async {
    try {
      await _db.collection('Favorite Movie').doc(movieId.toString()).delete();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<FavoriteMovieModel>> getAllFavoriteMovies() async {
    try {
      final snapshot = await _db.collection('Favorite Movie').get();
      return snapshot.docs
          .map((doc) => FavoriteMovieModel.fromJson(doc))
          .toList();
    } catch (e) {
      throw e.toString();
    }
  }


}
