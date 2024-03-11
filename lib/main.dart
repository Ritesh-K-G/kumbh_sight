import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Firebase_options.dart';
import 'constants/color.dart';
import 'features/authentication/authScreen.dart';
import 'features/client/clientNavbar.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NavbarIndexProvider())
      ],
      child: MaterialApp(
          title: 'Kumbh Sight',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.myBlue),
            useMaterial3: true,
          ),
          home: const AuthCheck(title: 'Kumbh Sight'),
          debugShowCheckedModeBanner: false
      ),
    );
  }
}

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key, required this.title});
  final String title;

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    return const AuthScreen();
    // return StreamBuilder<User?>(
    //   stream: FirebaseAuth.instance.authStateChanges(),
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       return FutureBuilder<DocumentSnapshot>(
    //         future: FirebaseFirestore.instance.collection('users').doc(snapshot.data!.uid).get(),
    //         builder: (context, AsyncSnapshot<DocumentSnapshot> userSnapshot) {
    //           if (userSnapshot.connectionState == ConnectionState.done) {
    //             // Assuming 'authority' is a field in your user document
    //             final authority = userSnapshot.data!['authority'];
    //             switch (authority) {
    //               default:
    //                 return ClientNavbar();
    //             }
    //           }
    //           return Center(child: CircularProgressIndicator()); // Show loading while fetching user data
    //         },
    //       );
    //     } else {
    //       return const AuthScreen();
    //     }
    //   },
    // );

  }
}