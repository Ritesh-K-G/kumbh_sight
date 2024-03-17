import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kumbh_sight/constants/color.dart';
import 'package:kumbh_sight/constants/url.dart';
import 'package:kumbh_sight/features/client/carousel/slider.dart';
import 'package:kumbh_sight/models/points.dart';
import 'package:kumbh_sight/utils/helpers/appHelpers.dart';
import 'package:kumbh_sight/utils/styles/buttons.dart';
import 'package:kumbh_sight/utils/styles/text.dart';
import 'package:kumbh_sight/utils/widgets/barChart.dart';
import 'package:kumbh_sight/utils/widgets/lineChart.dart';

import '../../authentication/authScreen.dart';

class adminHomepage extends StatefulWidget {
  const adminHomepage({super.key});

  @override
  State<adminHomepage> createState() => _adminHomepageState();
}

class _adminHomepageState extends State<adminHomepage> {

  bool serverCalled = false;
  late List<point> lineData, barData;

  @override
  void initState() {
    super.initState();
    (()async =>{
      await fetchCardDetails()
    })();
  }

  Future<void> fetchCardDetails() async {
    final dio = Dio();
    final cards = await dio.post('${url.link}/getTotalStats');
    print(cards.data);
    // barData = cards.data['barData'].map((e)=>point(x:e['key'].toDouble(),y:e['value'].toDouble())).toList().cast<point>();
    // lineData = cards.data['lineData'].map((e)=>point(x:e['key'].toDouble(),y:e['value'].toDouble())).toList().cast<point>();
    // setState(() {
    //   serverCalled = true;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
                            alignment: const Alignment(-0.6, 0.0),
                            child: const SliderScreen(),
                          ),
                          const SizedBox(height: 20),
                          serverCalled == false
                            ? const Center(child: CircularProgressIndicator())
                              : Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Line Chart to show frequency of queries with past hours',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400
                                        ),
                                      ),
                                      Container(
                                        width: AppHelpers.screenWidth(context) * 0.9,
                                        height: AppHelpers.screenHeight(context) * 0.5,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 2.0,
                                          ),
                                        ),
                                        child: lineChartWidget(points: lineData),
                                      ),
                                      const SizedBox(height: 8),
                                      const Divider(
                                        indent: 10,
                                        endIndent: 10,
                                        thickness: 2,
                                      ),
                                      const SizedBox(height: 8),
                                      const Text(
                                          'Histogram to show average response time of resolver to queries'
                                      ),
                                      Container(
                                        width: AppHelpers.screenWidth(context) * 0.9,
                                        height: AppHelpers.screenHeight(context) * 0.5,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 2.0,
                                          ),
                                        ),
                                        child: BarChartWidget(points: barData),
                                      ),
                                      const SizedBox(height: 8),
                                      const Divider(
                                        indent: 10,
                                        endIndent: 10,
                                        thickness: 2,
                                      ),
                                      const SizedBox(height: 8)
                                    ],
                                  ),
                          )
                        ],
                      ),
                    )),
                Column(
                  children: [
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        final FirebaseAuth _auth = FirebaseAuth.instance;
                        await _auth.signOut();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AuthScreen()));
                      },
                      style: AppButtonStyles.authButtons.copyWith(
                        minimumSize: MaterialStatePropertyAll(Size(
                            AppHelpers.screenWidth(context) * 0.8, 50)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      child: const Text(
                        "Logout",
                        style: AppTextStyles.buttontext,
                      ),
                    )
                  ],
                )
              ],
            ),
          )
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
