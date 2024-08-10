import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';

import 'package:github_tmdb/constant/api_constants.dart';

class MovieRepository with ChangeNotifier {
  final Dio dio = Dio(
    BaseOptions(
        baseUrl: ApiConstants.baseUrl, queryParameters: {'page': 1}),
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
  Future<Either<String, dynamic>> getPopularMovie({int page = 1}) async {
    try {
      final response = await dio.get(
        '/movie/top_rated?api_key=${ApiConstants.apiKey}&page=$page',
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
