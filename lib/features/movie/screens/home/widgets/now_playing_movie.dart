import 'package:flutter/material.dart';
import 'package:github_tmdb/constant/api_constants.dart';
import 'package:github_tmdb/features/movie/provider/movies/now_playing_movie.dart';
import 'package:github_tmdb/features/movie/screens/home/home.dart';
import 'package:github_tmdb/widgets/shimmer/shimmer_item.dart';
import 'package:provider/provider.dart';

class NowPlayingMovie extends StatefulWidget {
  const NowPlayingMovie({
    super.key,
  });

  @override
  State<NowPlayingMovie> createState() => _NowPlayingMovieState();
}

class _NowPlayingMovieState extends State<NowPlayingMovie> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<NowPlayingMovieProvider>().getNowPlayingMovie(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NowPlayingMovieProvider>(
      builder: (context, value, child) {
        if (value.isLoading) {
          return ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return const TShimmer(height: 250);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(width: 10);
            },
            itemCount: value.popularMovies.length,
          );
        }
        return SizedBox(
          height: 250,
          width: double.infinity,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final movie = value.popularMovies[index];
              return SizedBox(
                height: 220,
                width: 170,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: movie.posterPath.isNotEmpty
                            ? Image.network(
                                '${ApiConstants.imageUrlw500}${movie.posterPath}',
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )
                            : const Center(
                                child: Icon(Icons.broken_image),
                              ),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(width: 10);
            },
            itemCount: value.popularMovies.length,
          ),
        );
      },
    );
  }
}
