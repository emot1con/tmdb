import 'package:flutter/material.dart';
import 'package:github_tmdb/features/movie/provider/movies/search_movie.dart';
import 'package:github_tmdb/features/movie/screens/home/paged_movie.dart';
import 'package:github_tmdb/features/movie/screens/home/search_movie.dart';
import 'package:github_tmdb/utils/validators/validation.dart';
import 'package:github_tmdb/widgets/button/icon_button.dart';
import 'package:github_tmdb/widgets/container/search_container.dart';
import 'package:github_tmdb/widgets/textform/textform_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
                              return Stack(
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
                              );
                            },
                          ).toList(),
                        ),
                        // Positioned(
                        //   top: 40,
                        //   right: 20,
                        //   child: TIconButton(
                        //     onTap: () {},
                        //     icon: Icons.search,
                        //   ),
                        // ),
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
                    TSearchContainer(label: 'Search',onTap: () {
                      showSearch(context: context, delegate: SearchScreen());
                    },),
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




// Consumer<PopularMovieProvider>(
//                 builder: (context, value, child) {
//                   if (value.isLoading) {
//                     return TShimmer();
//                   }
//                   return SizedBox(
//                     height: 250,
//                     width: double.infinity,
//                     child: ListView.separated(
//                       shrinkWrap: true,
//                       scrollDirection: Axis.horizontal,
//                       itemBuilder: (context, index) {
//                         final movie = value.popularMovies[index];
//                         return SizedBox(
//                           height: 220,
//                           width: 170,
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(12),
//                             child: Stack(
//                               children: [
//                                 Image.network(
//                                   '${ApiConstants.imageUrlw500}${movie.posterPath}',
//                                   width: double.infinity,
//                                   fit: BoxFit.cover,
//                                 ),
                                
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                       separatorBuilder: (context, index) {
//                         return const SizedBox(width: 10);
//                       },
//                       itemCount: value.popularMovies.length,
//                     ),
//                   );
//                 },
//               )