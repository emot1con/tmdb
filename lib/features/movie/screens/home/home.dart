import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:github_tmdb/features/movie/screens/detail/detail.dart';
import 'package:github_tmdb/features/movie/screens/paged_movie/paged_movie.dart';
import 'package:github_tmdb/features/movie/screens/home/search_movie.dart';
import 'package:github_tmdb/widgets/container/search_container.dart';
import 'package:github_tmdb/constant/api_constants.dart';
import 'package:github_tmdb/constant/colors.dart';
import 'package:github_tmdb/constant/sizes.dart';
import 'package:github_tmdb/features/movie/screens/home/widgets/upcoming_movie.dart';
import 'package:github_tmdb/features/movie/screens/home/widgets/now_playing_movie.dart';
import 'package:github_tmdb/features/movie/screens/home/widgets/popular_movie.dart';
import 'package:github_tmdb/features/movie/screens/home/widgets/poster_movie.dart';
import 'package:github_tmdb/widgets/heading/heading.dart';
import 'package:github_tmdb/widgets/shimmer/shimmer_item.dart';
import 'package:github_tmdb/features/movie/provider/movies/discover_movie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<DiscoverMovieProvider>().getDiscoverMovie(context);
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<DiscoverMovieProvider>().automaticallyScrollPageView();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DiscoverMovieProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const TShimmer(
              height: 340,
              radius: 0,
            );
          }
          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  floating: true,
                  expandedHeight: 345,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        PageView(
                          controller: value.pageController,
                          onPageChanged: value.updatePageIndicator,
                          children: value.discoverMovies.map(
                            (discover) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetailMovie(movieId: discover.id),
                                    ),
                                  );
                                },
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: Image.network(
                                        '${ApiConstants.imageUrlOriginal}${discover.backdropPath}',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.transparent,
                                              Colors.black,
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 35,
                                      left: 15,
                                      right: 20,
                                      child: TPosterMovie(
                                        movie: discover,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ).toList(),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: SmoothPageIndicator(
                              controller: value.pageController,
                              count: 5,
                              effect: const ExpandingDotsEffect(
                                activeDotColor: TColors.colorPrimary,
                                dotWidth: 7,
                                expansionFactor: 5,
                                dotHeight: 6,
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
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.defaultSpace,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: TSizes.spaceBtwItem),
                    TSearchContainer(
                      label: 'Search',
                      onTap: () {
                        showSearch(context: context, delegate: SearchScreen());
                      },
                    ),
                    const SizedBox(height: TSizes.spaceBtwItem),
                    const THeadingTitle(
                        title: 'Upcoming', typeMovie: TypeMovie.upcoming),
                    const UpcomingMovies(),
                    const SizedBox(height: TSizes.spaceBtwItem),
                    const THeadingTitle(
                        title: 'Now Playing', typeMovie: TypeMovie.nowPlaying),
                    const NowPlayingMovie(),
                    const SizedBox(height: TSizes.spaceBtwItem),
                    const THeadingTitle(
                        title: 'Most Popular', typeMovie: TypeMovie.popular),
                    const PopularMovie(),
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
