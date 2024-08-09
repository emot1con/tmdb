import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';

import 'package:github_tmdb/constant/api_constants.dart';
import 'package:github_tmdb/features/movie/models/movie_models.dart';

class MovieRepository with ChangeNotifier {
  final Dio dio = Dio(
    BaseOptions(
        baseUrl: 'https://api.themoviedb.org/3/', queryParameters: {'page': 1}),
  );

  Future<Either<String, dynamic>> getDiscoverMovie({int page = 1}) async {
    try {
      final response = await dio.get(
        '/discover/movie?api_key=${ApiConstants.apiKey}&page=$page',
      );
      if (response.statusCode == 200 && response.data != null) {
        return Right(response.data);
      } else {
        return const Left('Something went wrong.');
      }
    } on DioException catch (e) {
      return Left(e.message!);
    }
  }
}
