import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kumbh_sight/constants/color.dart';
import 'package:kumbh_sight/features/resolver/homepage/resolverHome.dart';
import 'package:kumbh_sight/features/resolver/pastQueries/queriesList.dart';
import 'package:provider/provider.dart';

class resolverNavbar extends StatelessWidget {
  resolverNavbar({super.key});

  final List<dynamic> screens = [
    const Cleanerhomepage(),
    const cleanerqueriesBody()
  ];

  @override
  Widget build(BuildContext context) {
    int currentScreenIndex = Provider.of<resolverNavbarIndexProvider>(context).navbarScreenIndex;
    return Scaffold(
      bottomNavigationBar:
      Consumer<resolverNavbarIndexProvider>(builder: (context, provider, child) {
        return BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.Bhagwa,
          unselectedItemColor: AppColors.myCommentGray,
          currentIndex: currentScreenIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            provider.setNavbarScreenIndex(value);
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Iconsax.home), activeIcon: Icon(Iconsax.home5, color: AppColors.Bhagwa), label: "HomePage"),
            BottomNavigationBarItem(icon: Icon(Iconsax.hashtag), activeIcon: Icon(Iconsax.hashtag5, color: AppColors.Bhagwa), label: "Queries"),
          ],
        );
      }),
      body: SafeArea(child: screens[currentScreenIndex]),
    );
  }
}

class resolverNavbarIndexProvider extends ChangeNotifier {
  int _navbarScreenIndex = 0;

  int get navbarScreenIndex => _navbarScreenIndex;

  void setNavbarScreenIndex(int value) {
    _navbarScreenIndex = value;
    notifyListeners();
  }
}
