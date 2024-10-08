import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:github_tmdb/constant/api_constants.dart';
import 'package:github_tmdb/features/movie/provider/movies/now_playing_movie.dart';
import 'package:github_tmdb/features/movie/screens/detail/detail.dart';
import 'package:github_tmdb/widgets/shimmer/shimmer_item.dart';

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
          return const TShimmer(height: 250);
        }
        return SizedBox(
          height: 250,
          width: double.infinity,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final movie = value.nowPlayingMovies[index];
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DetailMovie(movieId: movie.id),
                    ),
                  );
                },
                child: SizedBox(
                  height: 220,
                  width: 170,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: movie.posterPath != null
                              ? Image.network(
                                  '${ApiConstants.imageUrlw500}${movie.posterPath}',
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                )
                              : const Center(
                                  child: Icon(Icons.broken_image, size: 40),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(width: 10);
            },
            itemCount: value.nowPlayingMovies.length,
          ),
        );
      },
    );
  }
}
