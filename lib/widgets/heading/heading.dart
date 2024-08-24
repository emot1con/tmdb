import 'package:flutter/material.dart';

import 'package:github_tmdb/constant/sizes.dart';
import 'package:github_tmdb/features/movie/screens/paged_movie/paged_movie.dart';

class THeadingTitle extends StatelessWidget {
  const THeadingTitle({
    super.key,
    required this.title,
    this.textButton = true,
    required this.typeMovie,
  });
  final String title;
  final bool textButton;
  final TypeMovie typeMovie;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: TSizes.mediumTextSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (textButton)
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PagedMovieScreen(typeMovie: typeMovie,),
                ),
              );
            },
            child: const Text(
              'See all',
              style: TextStyle(color: Colors.white),
            ),
          ),
      ],
    );
  }
}
