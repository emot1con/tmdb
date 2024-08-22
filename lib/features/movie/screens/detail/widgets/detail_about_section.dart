import 'package:flutter/material.dart';
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TDetailTitle(
                      title: 'Genres',
                    ),
                    Row(
                      children: List.generate(
                        movie.genres.length,
                        (index) {
                          final genre = movie.genres[index];
                          return Text(
                            genre.name +
                                (index < movie.genres.length - 1 ? ', ' : ''),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 15,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              TDetailAbout(
                title: 'Language',
                text: movie.originalLanguage,
              )
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
