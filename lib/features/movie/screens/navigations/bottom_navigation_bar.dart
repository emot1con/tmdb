import 'package:flutter/material.dart';
import 'package:github_tmdb/constant/colors.dart';
import 'package:github_tmdb/features/movie/provider/navigations/navigations.dart';
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
          bottomNavigationBar: SafeArea(
            child: SizedBox(
              height: 65,
              child: ClipRRect(
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  backgroundColor: TColors.colorPrimary.withOpacity(0.8),
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home, size: 30),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.star, size: 30),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person, size: 30),
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
          ),
        );
      },
    );
  }
}
