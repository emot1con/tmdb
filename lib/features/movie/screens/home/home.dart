import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:github_tmdb/constant/api_constants.dart';
import 'package:github_tmdb/constant/colors.dart';
import 'package:github_tmdb/constant/sizes.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          scrolledUnderElevation: 0.0,
          title: const TAppBar(),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                size: 30,
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                const THeadingTitle(title: 'Discover Movies'),
                const SizedBox(height: TSizes.spaceBtwItem),
                TDicoverMovies(),
              ],
            ),
          ),
        ));
  }
}
