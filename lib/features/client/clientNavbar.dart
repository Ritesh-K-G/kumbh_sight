import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kumbh_sight/constants/color.dart';
import 'package:kumbh_sight/features/client/QueryForm/queryForm.dart';
import 'package:provider/provider.dart';

class ClientNavbar extends StatelessWidget {
  ClientNavbar({super.key});

  final List<dynamic> screens = [
    const Placeholder(),
    const Placeholder(),
    const QueryForm(),
  ];

  @override
  Widget build(BuildContext context) {
    int currentScreenIndex = Provider.of<NavbarIndexProvider>(context).navbarScreenIndex;
    return Scaffold(
      bottomNavigationBar:
      Consumer<NavbarIndexProvider>(builder: (context, provider, child) {
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
            BottomNavigationBarItem(icon: Icon(Iconsax.hashtag), activeIcon: Icon(Iconsax.hashtag5, color: AppColors.Bhagwa), label: "My Queries"),
            BottomNavigationBarItem(icon: Icon(Iconsax.trade), activeIcon: Icon(Iconsax.trade5, color: AppColors.Bhagwa), label: "Complaint")
          ],
        );
      }),
      body: SafeArea(child: screens[currentScreenIndex]),
    );
  }
}

class NavbarIndexProvider extends ChangeNotifier {
  int _navbarScreenIndex = 0;

  int get navbarScreenIndex => _navbarScreenIndex;

  void setNavbarScreenIndex(int value) {
    _navbarScreenIndex = value;
    notifyListeners();
  }
}
