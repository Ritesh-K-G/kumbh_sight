import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kumbh_sight/constants/color.dart';
import 'package:kumbh_sight/features/client/carousel/slider.dart';
import 'package:kumbh_sight/utils/helpers/appHelpers.dart';
import 'package:kumbh_sight/utils/styles/buttons.dart';
import 'package:kumbh_sight/utils/styles/text.dart';

import '../../authentication/authScreen.dart';

class adminHomepage extends StatefulWidget {
  const adminHomepage({super.key});

  @override
  State<adminHomepage> createState() => _adminHomepageState();
}

class _adminHomepageState extends State<adminHomepage> {

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
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Welcome to Kumbh Sight, your ultimate companion for a safe and informed experience at the Kumbh Mela!',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'With Kumbh Sight, you have the power to report and address any incident swiftly, ensuring a seamless'
                                      ' and secure pilgrimage for all. Whether it\'s a medical emergency, a riot situation, lack of facilities,'
                                      ' or hygiene concerns, our intuitive app allows you to pinpoint the location and provide crucial details to'
                                      ' expedite resolution.'
                                      'Empowering both pilgrims and authorities, Kumbh Sight fosters a community-driven approach to safety and well-being. '
                                      'Together, we can enhance the Kumbh Mela experience for everyone, ensuring peace of mind and harmony '
                                      'throughout this sacred journey.',
                                )
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
