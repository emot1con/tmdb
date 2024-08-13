import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';

import 'package:github_tmdb/constant/api_constants.dart';
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
}
