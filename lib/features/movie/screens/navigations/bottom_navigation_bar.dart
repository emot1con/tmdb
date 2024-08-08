import 'package:flutter/material.dart';
import 'package:github_tmdb/constant/colors.dart';
import 'package:github_tmdb/features/movie/provider/navigations/navigations.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class TBottomNavigationBar extends StatelessWidget {
  const TBottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationsProvider>(
      builder: (context, value, child) {
        return Scaffold(
          body: value.listWidgets.elementAt(value.selectedIndex),
          bottomNavigationBar: Container(
            height: 100,
            padding: const EdgeInsets.fromLTRB(25, 25, 25, 5),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                backgroundColor: TColors.colorPrimary.withOpacity(0.8),
                items: const[
                  BottomNavigationBarItem(
                    icon: Icon(Iconsax.home, size: 30),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Iconsax.heart, size: 30),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Iconsax.document_download, size: 30),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Iconsax.user, size: 30),
                    label: '',
                  ),
                ],
                currentIndex: value.selectedIndex,
                
                selectedItemColor: Colors.amber,
                unselectedItemColor: Colors.white,
                onTap: (index) {
                  value.selectIndex(index);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
