import 'dart:io';

import 'package:flutter/material.dart';
import 'package:github_tmdb/constant/api_constants.dart';
import 'package:github_tmdb/constant/colors.dart';
import 'package:github_tmdb/constant/sizes.dart';
import 'package:github_tmdb/features/movie/provider/movies/detail_movie_provider.dart';
import 'package:github_tmdb/features/movie/provider/movies/video_movie_provider.dart';
import 'package:github_tmdb/features/movie/screens/detail/widgets/video_player.dart';
import 'package:github_tmdb/features/movie/screens/detail/widgets/youtube_player_widget.dart';
import 'package:github_tmdb/widgets/button/button_movie.dart';
import 'package:github_tmdb/widgets/button/button_with_text.dart';
import 'package:github_tmdb/widgets/button/icon_button.dart';
import 'package:github_tmdb/widgets/shimmer/shimmer_item.dart';
import 'package:github_tmdb/widgets/shimmer/shimmer_waiting.dart';
import 'package:github_tmdb/widgets/text/detail_subtitle.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
      context.read<DetailMovieProvier>().getDetailMovie(
            context,
            movieId: widget.movieId,
          );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Consumer<DetailMovieProvier>(
          builder: (context, value, child) {
            final movie = value.detailMovies;
            if (value.isLoading || value.detailMovies == null) {
              return const TShimmerWaitngScreen();
            }

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
                                    Color.fromARGB(255, 20, 17, 17),
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
                                      height: TSizes.defaultSpace - 22,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('${movie.releaseDate.year} ● '),
                                        Wrap(
                                          children: List.generate(
                                            movie.genres.length,
                                            (index) {
                                              return Text(
                                                movie.genres[index].name +
                                                    (index <
                                                            movie.genres
                                                                    .length -
                                                                1
                                                        ? ', '
                                                        : ''),
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
                          const Positioned(
                            top: 40,
                            left: 10,
                            child: TIconBackButton(
                              color: Colors.white54,
                              size: 45,
                              icon: Iconsax.arrow_circle_left,
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                        ],
                      ),
                    ),
                    clipBehavior: Clip.none,
                  ),
                ];
              },
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: VideoPlayer(
                      movieId: widget.movieId,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: TSizes.defaultSpace,
                    ),
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
                        const SizedBox(height: TSizes.spaceBtwItem),
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
                        ),
                        const SizedBox(height: TSizes.spaceBtwSection),
                      ],
                    ),
                  ),
                  // Replacing SingleChildScrollView with TabBarView
                  TabBar(
                    dividerColor: Colors.transparent,
                    indicatorColor: TColors.colorPrimary,
                    indicatorWeight: 3.5,
                    tabs: [
                      Text(
                        'Episode',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Similiar',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'About',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Center(child: Text('Episode')),
                        Center(child: Text('Similiar')),
                        Padding(
                          padding: const EdgeInsets.all(TSizes.defaultSpace),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const TDetailSubTitle(
                                          subTitle: 'Genres',
                                        ),
                                        Row(
                                          children: List.generate(
                                            movie.genres.length,
                                            (index) {
                                              final genre = movie.genres[index];
                                              return Text(
                                                genre.name +
                                                    (index <
                                                            movie.genres
                                                                    .length -
                                                                1
                                                        ? ', '
                                                        : ''),
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 15,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const TDetailSubTitle(
                                        subTitle: 'Language',
                                      ),
                                      Text(
                                        movie.originalLanguage,
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: TSizes.spaceBtwItem),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const TDetailSubTitle(
                                          subTitle: 'Year',
                                        ),
                                        Text(
                                          movie.releaseDate.year.toString(),
                                          style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const TDetailSubTitle(
                                        subTitle: 'Country',
                                      ),
                                      Row(
                                        children: List.generate(
                                          movie.originCountry.length,
                                          (index) {
                                            final oCountry =
                                                movie.originCountry[index];
                                            return Text(
                                              oCountry +
                                                  (movie.originCountry.length !=
                                                          1
                                                      ? (index <
                                                              movie.genres
                                                                      .length -
                                                                  1
                                                          ? ', '
                                                          : '')
                                                      : ''),
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: Colors.white70,
                                                fontSize: 15,
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
