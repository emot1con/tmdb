import 'package:carousel_slider/carousel_slider.dart';
import 'package:github_tmdb/features/movie/provider/movies/popular_movie.dart';
import 'package:github_tmdb/features/movie/provider/movies/upcoming_movie.dart';
import 'package:github_tmdb/widgets/wrap/genres.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:github_tmdb/constant/api_constants.dart';
import 'package:github_tmdb/constant/sizes.dart';
import 'package:github_tmdb/features/movie/provider/movies/discover_movie.dart';
import 'package:github_tmdb/widgets/container/rounded_container.dart';
import 'package:github_tmdb/widgets/shimmer/shimmer_item.dart';

class UpcomingMovies extends StatefulWidget {
  const UpcomingMovies({
    super.key,
  });

  @override
  State<UpcomingMovies> createState() => _UpcomingMoviesState();
}

class _UpcomingMoviesState extends State<UpcomingMovies> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<UpcomingMovieProvider>().getUpcomingMovie(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UpcomingMovieProvider>(
      builder: (context, value, child) {
        if (value.isLoading) {
          return CarouselSlider(
            items: const [
              TShimmer(),
              TShimmer(),
              TShimmer(),
            ],
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.9,
              aspectRatio: 2.0,
              initialPage: 2,
            ),
          );
        }
        return CarouselSlider(
          items: value.popularMovies.map((movie) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  Image.network(
                    '${ApiConstants.imageUrlw500}${movie.backdropPath}',
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.black],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: TRoundedContainer(
                      width: 65,
                      color: Colors.black54.withOpacity(0.6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            movie.voteAverage.toString().substring(0, 3),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 275,
                          child: Text(
                            movie.title,
                            overflow: TextOverflow.visible,
                            softWrap: true,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: TSizes.largeTextSize - 5,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwItem - 10,
                        ),
                        TGenres(genres: movie.getGenres()),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.9,
            aspectRatio: 2.0,
            initialPage: 2,
          ),
        );
      },
    );
  }
}
