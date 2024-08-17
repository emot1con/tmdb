
import 'package:flutter/material.dart';
import 'package:github_tmdb/constant/sizes.dart';
import 'package:github_tmdb/widgets/shimmer/shimmer_item.dart';

class TShimmerWaitngScreen extends StatelessWidget {
  const TShimmerWaitngScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          const TShimmer(
            height: 300,
          ),
          const SizedBox(height: TSizes.spaceBtwItem),
          TShimmer(height: 100),
          const SizedBox(height: TSizes.spaceBtwItem),
          Row(
            children: [
              Expanded(child: TShimmer(height: 100)),
              const SizedBox(width: TSizes.spaceBtwItem),
              Expanded(child: TShimmer(height: 100)),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItem),
          Row(
            children: [
              Expanded(child: TShimmer(height: 100)),
              const SizedBox(width: TSizes.spaceBtwItem),
              Expanded(child: TShimmer(height: 100)),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItem),
          Row(
            children: [
              Expanded(child: TShimmer(height: 100)),
              const SizedBox(width: TSizes.spaceBtwItem),
              Expanded(child: TShimmer(height: 100)),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItem),
          Row(
            children: [
              Expanded(child: TShimmer(height: 100)),
              const SizedBox(width: TSizes.spaceBtwItem),
              Expanded(child: TShimmer(height: 100)),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItem),
          Row(
            children: [
              Expanded(child: TShimmer(height: 100)),
              const SizedBox(width: TSizes.spaceBtwItem),
              Expanded(child: TShimmer(height: 100)),
            ],
          ),
        ],
      ),
    );
  }
}
