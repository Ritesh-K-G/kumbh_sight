import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kumbh_sight/constants/color.dart';
import 'package:kumbh_sight/features/admin/stats/resolverList/resolverList.dart';
import 'package:kumbh_sight/features/admin/stats/unresolvedQueries/unresolved.dart';
import 'package:kumbh_sight/utils/helpers/appHelpers.dart';
import 'package:kumbh_sight/utils/styles/text.dart';

class searchResults extends StatefulWidget {
  const searchResults({super.key});

  @override
  State<searchResults> createState() => _searchResultsState();
}

class _searchResultsState extends State<searchResults> with TickerProviderStateMixin {
  late TabController _tabController;
  late List<Widget> tabs = [unresolvedPage(), resolverList()];

  @override
  void initState() {
    _tabController = TabController(length: tabs.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
            alignment: const Alignment(-0.6, 0.0),
            height: AppHelpers.screenHeight(context) * 0.2,
            decoration: const BoxDecoration(
              gradient: AppColors.linearGradient,
              image: DecorationImage(
                image: AssetImage('assets/images/past-queries.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
            ),
            width: MediaQuery.of(context).size.width,
          ),
          const SizedBox(height: 20),
          Container(
            height: 60.0,
            width: AppHelpers.screenWidth(context) * 0.8,
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: AppColors.myTextBoxGray,
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(width: 2.0, color: AppColors.myTextBoxGray),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: AppColors.Bhagwa,
                borderRadius: BorderRadius.circular(30.0),
              ),
              onTap: (value) {
                setState(() {});
              },
              tabs: [
                Tab(
                  child: SizedBox(
                    width: AppHelpers.screenWidth(context) * 0.3,
                    child: Text(
                      "Queries",
                      style: (_tabController.index == 0)
                          ? AppTextStyles.authTabButtons
                          : AppTextStyles.authTabButtonsUnselected,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Tab(
                  child: SizedBox(
                    width: AppHelpers.screenWidth(context) * 0.3,
                    child: Text(
                      "Stats",
                      style: (_tabController.index == 1)
                          ? AppTextStyles.authTabButtons
                          : AppTextStyles.authTabButtonsUnselected,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: tabs,
            ),
          ),
        ],
      ),
    );
  }
}
