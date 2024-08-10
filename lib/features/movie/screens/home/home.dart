import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:github_tmdb/constant/api_constants.dart';
import 'package:github_tmdb/constant/colors.dart';
import 'package:github_tmdb/constant/sizes.dart';
import 'package:github_tmdb/features/movie/provider/movies/popular_movie.dart';
import 'package:github_tmdb/features/movie/screens/home/widgets/discover_movie.dart';
import 'package:github_tmdb/widgets/container/rounded_container.dart';
import 'package:github_tmdb/widgets/heading/heading.dart';
import 'package:github_tmdb/widgets/shimmer/shimmer_item.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'package:github_tmdb/widgets/appbar/appbar.dart';
import 'package:github_tmdb/features/movie/provider/movies/discover_movie.dart';
import 'package:shimmer/shimmer.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DiscoverMovieProvider>(
        builder: (context, value, child) {
          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  floating: true,
                  pinned: true,
                  expandedHeight: 340,
                  flexibleSpace: PageView(
                    children: value.discoverMovies.map((discover) {
                      return Stack(
                        children: [
                          SizedBox(
                            height: 450,
                            child: Image.network(
                              '${ApiConstants.imageUrlOriginal}${discover.backdropPath}',
                              fit: BoxFit.cover,
                            ),
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
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ];
            },
            body: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  const THeadingTitle(title: 'Most Popular'),
                  const TDicoverMovies(),
                  const SizedBox(height: TSizes.spaceBtwItem),
                ],
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