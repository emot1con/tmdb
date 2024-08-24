import 'package:flutter/material.dart';
import 'package:github_tmdb/constant/sizes.dart';
import 'package:github_tmdb/features/authentication/provider/signout/signout_provider.dart';
import 'package:github_tmdb/widgets/button/button_movie.dart';
import 'package:github_tmdb/widgets/shimmer/shimmer_item.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<SignOutProvider>().getUserData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<SignOutProvider>(
                builder: (context, value, child) {
                  if (value.isLoading) {
                    return const TShimmer(height: 150);
                  }
                  if (value.userModel != null) {
                    final user = value.userModel!;
                    return Container(
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
                            ),
                          ),
                          const SizedBox(height: TSizes.spaceBtwItem),
                          Text(user.email),
                        ],
                      ),
                    );
                  }
                  return const TShimmer(height: 150);
                },
              ),
              const SizedBox(height: TSizes.spaceBtwSection),
              Column(
                children: [
                  TButton(
                    width: double.infinity,
                    height: 55,
                    radius: 112,
                    title: 'LogOut',
                    icon: Icons.logout,
                    onTap: () {
                      SignOutProvider().signOutAccount(context);
                    },
                  ),
                  const SizedBox(height: TSizes.spaceBtwItem),
                  TButton(
                    width: double.infinity,
                    height: 55,
                    radius: 112,
                    title: 'Delete Account',
                    color: Colors.red,
                    icon: Icons.delete_forever,
                    onTap: () {
                      SignOutProvider().deleteAccount(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
