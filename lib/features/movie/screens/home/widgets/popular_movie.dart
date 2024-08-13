import 'package:flutter/material.dart';
import 'package:github_tmdb/constant/api_constants.dart';
import 'package:github_tmdb/features/movie/models/movie_models.dart';
import 'package:github_tmdb/features/movie/provider/movies/popular_movie.dart';
import 'package:github_tmdb/features/movie/provider/movies/upcoming_movie.dart';
import 'package:github_tmdb/features/movie/screens/home/widgets/poster_movie.dart';
import 'package:github_tmdb/widgets/grid/movie_grid.dart';
import 'package:github_tmdb/widgets/shimmer/shimmer_item.dart';
import 'package:provider/provider.dart';

class PopularMovie extends StatefulWidget {
  const PopularMovie({
    super.key,
  });

  @override
  State<PopularMovie> createState() => _PopularMovieState();
}

class _PopularMovieState extends State<PopularMovie> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<PopularMovieProvider>().getPopularMovie(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PopularMovieProvider>(
      builder: (context, value, child) {
        if (value.isLoading) {
          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: value.popularMovies.length,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 2 / 3,
            ),
            itemBuilder: (context, index) => const TShimmer(height: 220),
          );
        }
        return SizedBox(
          width: double.infinity,
          child: TMovieGrid(
            movies: value.popularMovies,
            height: 220,
          ),
        );
      },
    );
  }
}

