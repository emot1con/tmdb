import 'package:flutter/material.dart';
import 'package:github_tmdb/widgets/container/rounded_container.dart';

class TGenres extends StatelessWidget {
  const TGenres({
    super.key,
    required this.genres,
    this.spacing = 4.0,
    this.runSpacing = 4.0,
  });
  final List<String> genres;
  final double spacing;
  final double runSpacing;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: spacing,
      runSpacing: runSpacing,
      children: genres.map(
        (genre) {
          return TRoundedContainer(
            padding: 7,
            child: Text(
              genre,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 13,
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}
