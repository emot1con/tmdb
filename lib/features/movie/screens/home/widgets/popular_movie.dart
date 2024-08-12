import 'package:flutter/material.dart';
import 'package:github_tmdb/features/movie/provider/movies/popular_movie.dart';
import 'package:github_tmdb/features/movie/provider/movies/upcoming_movie.dart';
import 'package:github_tmdb/features/movie/screens/home/widgets/poster_movie.dart';
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
        if(value.isLoading){
          return const  TShimmer();
        }
        return SizedBox(
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final movie = value.popularMovies[index];
              return TPosterMovie(
                movie: movie,
                textColor: Colors.black,
                isPopularMovie: true,
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 10);
            },
            itemCount: value.popularMovies.length,
          ),
        );
      },
    );
  }
}

