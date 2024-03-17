import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kumbh_sight/constants/color.dart';
import 'package:kumbh_sight/features/client/PastQueries/queries.dart';
import 'package:kumbh_sight/features/client/QueryForm/queryForm.dart';
import 'package:kumbh_sight/features/client/homepage/homepage.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:kumbh_sight/constants/url.dart';
Future<Position> _determinePosition() async {
  return await Geolocator.getCurrentPosition();
}
Future<void>sendLocations()async{
  while(true) {
    try {
      Position current=await _determinePosition();
      print(current.latitude);
      var res = await Dio().post('${url.link}/locationupdate',
          data: {'latitude': current.latitude, 'longitude': current.longitude,'user':FirebaseAuth.instance.currentUser?.uid});
      print(res);
    } catch (err) {
      print(err);
    }
    await Future.delayed(Duration(minutes:5));
  }
}
class ClientNavbar extends StatelessWidget {
  ClientNavbar({super.key});

  final List<dynamic> screens = [
    const homepage(),
    const queriesBody(),
    const QueryForm()
  ];
  final work=sendLocations();

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
            BottomNavigationBarItem(icon: Icon(Iconsax.trade), activeIcon: Icon(Iconsax.trade5, color: AppColors.Bhagwa), label: "Complaint"),
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
