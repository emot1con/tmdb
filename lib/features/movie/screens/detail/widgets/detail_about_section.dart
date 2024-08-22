import 'package:flutter/material.dart';
import 'package:github_tmdb/constant/api_constants.dart';
import 'package:github_tmdb/constant/sizes.dart';
import 'package:github_tmdb/features/movie/models/detail_model_movie.dart';
import 'package:github_tmdb/widgets/text/detail_about.dart';
import 'package:github_tmdb/widgets/text/detail_subtitle.dart';

class DetailAboutSection extends StatelessWidget {
  const DetailAboutSection({
    super.key,
    required this.movie,
  });

  final DetailMovieModel movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 220,
                width: 170,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          '${ApiConstants.imageUrlw500}${movie.posterPath}',
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      style: const TextStyle(
                          fontSize: TSizes.mediumTextSize,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      movie.tagline,
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 30,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          movie.voteAverage.toString().substring(0, 3),
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          '(${movie.voteCount})',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Text(
                      'Release Date: ${movie.releaseDate.toString().substring(0, 10)}',
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwSection),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width /
                    2, // Setengah lebar layar
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TDetailTitle(
                      title: 'Genres',
                    ),
                    // Menggabungkan genre menjadi satu teks dengan elipsis
                    Text(
                      movie.genres.map((genre) => genre.name).join(', '),
                      overflow: TextOverflow.visible,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                      ),
                      softWrap: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              TDetailAbout(
                title: 'Language',
                text: movie.originalLanguage,
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItem),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: TDetailAbout(
                    text: movie.releaseDate.year.toString(), title: 'Year'),
              ),
              const SizedBox(width: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TDetailTitle(
                    title: 'Country',
                  ),
                  Row(
                    children: List.generate(
                      movie.originCountry.length,
                      (index) {
                        final oCountry = movie.originCountry[index];
                        return Text(
                          oCountry +
                              (movie.originCountry.length != 1
                                  ? (index < movie.genres.length - 1
                                      ? ', '
                                      : '')
                                  : ''),
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 15,
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwSection),
          TDetailAbout(
            title: 'Budgets',
            text: movie.budget != 0 ? '\$ ${movie.budget}' : 'TBA',
            titleColor: Colors.white,
            titleSize: 20,
            textSize: 16,
          ),
          const SizedBox(height: TSizes.spaceBtwItem),
          TDetailAbout(
            title: 'Revenue',
            text: movie.revenue != 0 ? '\$ ${movie.revenue}' : 'TBA',
            titleColor: Colors.white,
            titleSize: 20,
            textSize: 16,
          )
        ],
      ),
    );
  }
}
