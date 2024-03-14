import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kumbh_sight/constants/color.dart';
import 'package:kumbh_sight/features/admin/homepage/adminHomepage.dart';
import 'package:kumbh_sight/features/admin/notify/notify.dart';
import 'package:kumbh_sight/features/admin/stats/search.dart';
import 'package:provider/provider.dart';

class adminNavbar extends StatelessWidget {
  adminNavbar({super.key});

  final List<dynamic> screens = [
    const adminHomepage(),
    const filterSearch(),
    const notificationPage()
  ];

  @override
  Widget build(BuildContext context) {
    int currentScreenIndex = Provider.of<adminNavbarIndexProvider>(context).navbarScreenIndex;
    return Scaffold(
      bottomNavigationBar:
      Consumer<adminNavbarIndexProvider>(builder: (context, provider, child) {
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
            BottomNavigationBarItem(icon: Icon(Iconsax.hashtag), activeIcon: Icon(Iconsax.hashtag5, color: AppColors.Bhagwa), label: "Stats"),
            BottomNavigationBarItem(icon: Icon(Iconsax.notification), activeIcon: Icon(Iconsax.notification5, color: AppColors.Bhagwa), label: "Notify"),
          ],
        );
      }),
      body: SafeArea(child: screens[currentScreenIndex]),
    );
  }
}

class adminNavbarIndexProvider extends ChangeNotifier {
  int _navbarScreenIndex = 0;

  int get navbarScreenIndex => _navbarScreenIndex;

  void setNavbarScreenIndex(int value) {
    _navbarScreenIndex = value;
    notifyListeners();
  }
}
