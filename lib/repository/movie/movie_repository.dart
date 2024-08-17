import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';

import 'package:github_tmdb/constant/api_constants.dart';
import 'package:github_tmdb/features/movie/models/detail_model_movie.dart';
import 'package:github_tmdb/features/movie/models/movie_models.dart';

class MovieRepository with ChangeNotifier {
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
}
