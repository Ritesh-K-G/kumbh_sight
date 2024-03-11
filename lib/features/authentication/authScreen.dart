import 'package:flutter/material.dart';
import 'package:kumbh_sight/constants/color.dart';
import 'package:kumbh_sight/features/authentication/body.dart';
import 'package:kumbh_sight/features/authentication/header.dart';
import 'package:kumbh_sight/features/authentication/provider/provider.dart';
import 'package:kumbh_sight/utils/helpers/appHelpers.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            SizedBox(height: AppHelpers.screenHeight(context), width: AppHelpers.screenWidth(context)),
            const AuthHeader(),
            Positioned(top: AppHelpers.screenHeight(context) * 0.2, child: ChangeNotifierProvider(create: (context) => SignInPageProvider(), child: const AuthBody())),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
