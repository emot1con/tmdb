import 'dart:io';

import 'package:flutter/material.dart';
import 'package:github_tmdb/constant/api_constants.dart';
import 'package:github_tmdb/constant/colors.dart';
import 'package:github_tmdb/constant/sizes.dart';
import 'package:github_tmdb/features/movie/provider/movies/detail_movie_provider.dart';
import 'package:github_tmdb/widgets/button/button_movie.dart';
import 'package:github_tmdb/widgets/button/button_with_text.dart';
import 'package:github_tmdb/widgets/button/icon_button.dart';
import 'package:github_tmdb/widgets/shimmer/shimmer_item.dart';
import 'package:github_tmdb/widgets/shimmer/shimmer_waiting.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class DetailMovie extends StatefulWidget {
  const DetailMovie({super.key, required this.movieId});
  final int movieId;

  @override
  State<DetailMovie> createState() => _DetailMovieState();
}

class _DetailMovieState extends State<DetailMovie> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context
          .read<DetailMovieProvier>()
          .getDetailMovie(context, movieId: widget.movieId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DetailMovieProvier>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const TShimmerWaitngScreen();
          }
          final movie = value.detailMovies;

          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  floating: true,
                  expandedHeight: 300,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.network(
                            '${ApiConstants.imageUrlOriginal}${movie!.backdropPath}',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned.fill(
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Color.fromARGB(255, 20, 17,
                                      17), // Warna lebih gelap dari 0xFF303030
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    movie.title,
                                    style: const TextStyle(
                                      fontSize: TSizes.largeTextSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                      height: TSizes.defaultSpace - 22),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          '${movie.releaseDate.toString().substring(0, 4)} ● '),
                                      Wrap(
                                        children: List.generate(
                                          movie.genres.length,
                                          (index) {
                                            return Text(
                                              movie.genres[index].name +
                                                  (index <
                                                          movie.genres.length -
                                                              1
                                                      ? ', '
                                                      : ''),
                                              style: const TextStyle(),
                                            );
                                          },
                                        ),
                                      ),
                                      Text(' ● ${movie.runtime}m'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  clipBehavior: Clip.none, // Pastikan gambar tidak mengecil
                ),
              ];
            },
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TButtonMovie(
                          title: 'Watch Trailer',
                          icon: Icons.play_arrow_rounded,
                          onTap: () {},
                        ),
                        TButtonMovie(
                          title: 'Download',
                          icon: Icons.download,
                          onTap: () {},
                          color: const Color.fromARGB(136, 52, 50, 50),
                        ),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwSection),
                    ReadMoreText(
                      movie!.overview,
                      trimLength: 150,
                      trimCollapsedText: ' read more',
                      moreStyle: const TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 124, 51, 234)),
                      trimExpandedText: ' show less',
                      lessStyle: const TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 124, 51, 234)),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
