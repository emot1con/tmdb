import 'package:flutter/material.dart';
import 'package:github_tmdb/constant/api_constants.dart';
import 'package:github_tmdb/constant/colors.dart';
import 'package:github_tmdb/constant/sizes.dart';
import 'package:github_tmdb/features/movie/models/movie_models.dart';

class FavoriteItemWidget extends StatelessWidget {
  const FavoriteItemWidget({
    super.key,
    required this.movie,
  });

  final FavoriteMovieModel movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: TColors.colorPrimary, borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          SizedBox(
            height: 180,
            width: 130,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.network(
                '${ApiConstants.imageUrlw500}${movie.poster}',
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: const TextStyle(
                    fontSize: TSizes.largeTextSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  movie.tagline,
                  softWrap: true,
                  style: const TextStyle(
                    fontSize: TSizes.smallTextSize,
                    color: Colors.white54,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber),
                    const SizedBox(width: 2),
                    Text(
                      movie.voteAverage.toString().substring(0, 3),
                      style: const TextStyle(
                        fontSize: TSizes.mediumTextSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '(${movie.voteCount})',
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: TSizes.smallTextSize,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
