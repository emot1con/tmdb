import 'package:flutter/material.dart';
import 'package:github_tmdb/constant/sizes.dart';
import 'package:github_tmdb/features/authentication/provider/signout/signout_provider.dart';
import 'package:github_tmdb/widgets/shimmer/shimmer_item.dart';
import 'package:provider/provider.dart';

class UserDetail extends StatefulWidget {
  const UserDetail({
    super.key,
  });

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<SignOutProvider>().getUserData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignOutProvider>(
      builder: (context, value, child) {
        if (value.isLoading) {
          return const TShimmer(height: 150);
        }
        if (value.userModel != null) {
          final user = value.userModel!;
          return SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: TSizes.largeTextSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwItem),
                Text(
                  user.userName,
                  style: const TextStyle(
                      fontSize: TSizes.mediumTextSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white54),
                ),
                Text(
                  user.email,
                  style: const TextStyle(
                    color: Colors.white54,
                  ),
                ),
              ],
            ),
          );
        }
        return const TShimmer(height: 150);
      },
    );
  }
}
