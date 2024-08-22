import 'package:flutter/material.dart';
import 'package:github_tmdb/constant/api_constants.dart';
import 'package:github_tmdb/constant/sizes.dart';
import 'package:github_tmdb/features/movie/models/detail_model_movie.dart';
import 'package:github_tmdb/widgets/text/detail_subtitle.dart';

class DetailProductionSection extends StatelessWidget {
  const DetailProductionSection({
    super.key,
    required this.movie,
  });

  final DetailMovieModel movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TDetailTitle(
            title: 'Production Countries',
            titleSize: 16,
          ),
          const SizedBox(height: 5),
          Row(
            children: List.generate(
              movie.productionCountries.length,
              (index) {
                final country =
                    movie.productionCountries[index];
                return Flexible(
                  child: Text(
                    '${country.name}${index < movie.productionCountries.length - 1 ? ', ' : ''}',
                    style: const TextStyle(fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwSection),
          const TDetailTitle(
            title: 'Production Companies',
            titleSize: 16,
          ),
          const SizedBox(height: 10),
          SizedBox(
            child: GridView.builder(
              physics:
                  const NeverScrollableScrollPhysics(),
              itemCount: movie.productionCompanies.length,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 20,
                crossAxisSpacing: 30,
              ),
              itemBuilder: (context, index) {
                final companies =
                    movie.productionCompanies[index];
                return SizedBox(
                  height: 550,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(12),
                    child: SizedBox(
                      height: 100,
                      child: companies.logoPath == null ||
                              companies.logoPath!.isEmpty
                          ? const Center(
                              child: Text('No Logo'))
                          : Image.network(
                              '${ApiConstants.imageUrlw500}${companies.logoPath}',
                              width: double.infinity,
                              fit: BoxFit.contain,
                              color: Colors.white,
                            ),
                    ),
                  ),
                );
    
                // return TShimmer(height: 250);
              },
            ),
          ),
        ],
      ),
    );
  }
}
