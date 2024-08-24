import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:github_tmdb/features/movie/provider/favorite/favorite_movie_provider.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:github_tmdb/constant/api_constants.dart';
import 'package:github_tmdb/constant/colors.dart';
import 'package:github_tmdb/constant/sizes.dart';
import 'package:github_tmdb/features/movie/provider/movies/detail_movie_provider.dart';
import 'package:github_tmdb/features/movie/provider/movies/video_movie_provider.dart';
import 'package:github_tmdb/features/movie/screens/detail/widgets/detail_about_section.dart';
import 'package:github_tmdb/features/movie/screens/detail/widgets/detail_production_section.dart';
import 'package:github_tmdb/features/movie/screens/detail/widgets/video_player.dart';
import 'package:github_tmdb/widgets/button/button_movie.dart';
import 'package:github_tmdb/widgets/button/icon_button.dart';
import 'package:github_tmdb/widgets/shimmer/shimmer_waiting.dart';

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
      context.read<VideoMovieProvider>().getVideoMovie(
            context,
            movieId: widget.movieId,
          );
      context.read<FavoriteMovieProvider>().isFavorites(widget.movieId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
                              '${ApiConstants.imageUrlOriginal}${movie.backdropPath}',
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
                                        Flexible(
                                          child: Wrap(
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: true,
                                                );
                                              },
                                            ),
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
                            top: 45,
                            left: 15,
                            child: TIconBackButton(
                              color: Colors.white54,
                              size: 40,
                              padding: 2,
                              icon: Icons.keyboard_arrow_left,
                              backgroundColor: TColors.colorPrimary,
                            ),
                          ),
                          Positioned(
                            top: 45,
                            right: 15,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: TColors.colorPrimary,
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(10),
                              child: InkWell(
                                onTap: () {
                                  final favorite =
                                      Provider.of<FavoriteMovieProvider>(
                                    context,
                                    listen: false,
                                  );
                                  favorite.setFavoriteMovies(
                                    movie.id,
                                    movie.posterPath,
                                    movie.tagline,
                                    movie.voteCount,
                                    movie.voteAverage,
                                    movie.title,
                                  );
                                  ScaffoldMessenger.of(context)
                                      .clearSnackBars();
                                  if (favorite.isFavorite) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Movie removed from your favorites'),
                                      ),
                                    );
                                    return;
                                  }
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Movie added to your favorites'),
                                    ),
                                  );
                                },
                                child: Icon(
                                  Icons.star,
                                  color: Provider.of<FavoriteMovieProvider>(
                                              context)
                                          .isFavorite
                                      ? Colors.amber
                                      : Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    clipBehavior: Clip.none,
                  ),
                ];
              },
              body: SingleChildScrollView(
                child: Column(
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
                          Consumer<VideoMovieProvider>(
                            builder: (context, value, child) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TButton(
                                  title: 'Watch Trailer',
                                  icon: Icons.play_arrow_rounded,
                                  onTap: () async {
                                    if (!await launchUrl(
                                      Uri.parse(
                                          'https://www.youtube.com/watch?v=${value.videoMovies!.results[1].key}'),
                                    )) {
                                      throw Exception(
                                          'Could not launch ${value.videoMovies!.results[1]}');
                                    }
                                  },
                                ),
                                TButton(
                                  title: 'Download',
                                  icon: Icons.download,
                                  onTap: () {},
                                  color: const Color.fromARGB(136, 52, 50, 50),
                                ),
                              ],
                            ),
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
                    const TabBar(
                      dividerColor: Colors.transparent,
                      indicatorColor: TColors.colorPrimary,
                      indicatorWeight: 3.5,
                      tabs: [
                        Text(
                          'About',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Production',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height -
                          300, // Adjust based on the height of the header
                      child: TabBarView(
                        children: [
                          DetailAboutSection(movie: movie),
                          DetailProductionSection(movie: movie),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
