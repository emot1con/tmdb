import 'package:flutter/material.dart';

import 'package:github_tmdb/constant/api_constants.dart';
import 'package:github_tmdb/constant/colors.dart';
import 'package:github_tmdb/constant/sizes.dart';
import 'package:github_tmdb/features/movie/models/movie_models.dart';
import 'package:github_tmdb/widgets/container/rounded_container.dart';
import 'package:github_tmdb/widgets/wrap/genres.dart';

class TPosterMovie extends StatelessWidget {
  const TPosterMovie({
    super.key,
    required this.movie,
    this.textColor = Colors.white,
    this.isPopularMovie = false,
  });
  final MovieModel movie;
  final Color textColor;
  final bool isPopularMovie;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          isPopularMovie ? const EdgeInsets.all(12) : const EdgeInsets.all(0),
      decoration: isPopularMovie
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [TColors.colorPrimary, Colors.white],
              ),
            )
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Poster Section
          SizedBox(
            height: 190,
            width: 130,
            child: Image.network(
              '${ApiConstants.imageUrlw500}${movie.posterPath}',
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: TSizes.mediumTextSize,
                  ),
                  maxLines: 2, // Maksimal 2 baris
                  overflow: TextOverflow.ellipsis,
                ),
                if (isPopularMovie)
                  Text(
                    movie.releaseDate.toString().substring(0, 10),
                    style: const TextStyle(
                        fontSize: TSizes.smallTextSize,
                        fontWeight: FontWeight.bold),
                  ),
                const SizedBox(height: TSizes.spaceBtwItem),
                TRoundedContainer(
                  width: 85,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        isPopularMovie
                            ? '${movie.voteAverage.toString().substring(0, 3)}/10'
                            : movie.voteAverage.toString().substring(0, 3),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: TSizes.smallTextSize,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwItem - 2),
                TGenres(
                  genres: movie.getGenres(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
