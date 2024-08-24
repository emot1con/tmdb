import 'package:flutter/material.dart';

import 'package:github_tmdb/constant/colors.dart';
import 'package:github_tmdb/features/movie/screens/paged_movie/widgets/paged_movie._widget.dart';
import 'package:github_tmdb/widgets/button/icon_button.dart';
import 'package:github_tmdb/constant/sizes.dart';

enum TypeMovie { upcoming, nowPlaying, popular }

class PagedMovieScreen extends StatefulWidget {
  const PagedMovieScreen({
    super.key,
    required this.typeMovie,
  });
  final TypeMovie typeMovie;

  @override
  State<PagedMovieScreen> createState() => _PagedMovieScreenState();
}

class _PagedMovieScreenState extends State<PagedMovieScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(
              TSizes.defaultSpace,
            ),
            child: PagedMovie(typeMovie: widget.typeMovie),
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
        ],
      ),
    );
  }
}
