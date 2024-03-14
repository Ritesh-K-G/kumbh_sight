import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kumbh_sight/utils/fileHandler/files.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:provider/provider.dart';
import 'Firebase_options.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'constants/color.dart';
import 'features/authentication/authScreen.dart';
import 'features/client/clientNavbar.dart';
import 'package:googleapis/pubsub/v1.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'dart:io';
import 'dart:convert';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  var smsPermissionStatus = await Permission.sms.request();
  var notificationPermissionStatus = await Permission.notification.request();
  var locationPermissionStatus = await Permission.location.request();
  subscribeToMessages();
  sendLocations();
  runApp(const MyApp());
}
Future<void>sendLocations()async{
  while(true) {
    try {
      await Dio().post('http://localhost:8080/locationupdate',
          data: {'latitude': 23.34, 'longitude': 12.34,'user':'Ritesh'});
    } catch (err) {
      print(err);
    }
    await Future.delayed(Duration(minutes:5));
  }
}
Future<void> subscribeToMessages() async {
  const _projectId = 'prime-mechanic-413516';
  const _subscriptionId = 'createNotifications-sub';
  String _result = await sendSMS(message: 'Hey', recipients: ['8328897391'],sendDirect:true)
      .catchError((onError) {
    print(onError);
  });
  print(_result);
  final credentialsJson = json.decode(await rootBundle.loadString('assets/cred.json'));
  final credentials = ServiceAccountCredentials.fromJson(credentialsJson);

  final client = await clientViaServiceAccount(credentials, [PubsubApi.pubsubScope]);

  final pubsub = PubsubApi(client);
  final subscriptionName = 'projects/$_projectId/subscriptions/$_subscriptionId';
  await AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic notifications',
        defaultColor: Color(0xFF9D50DD),
        ledColor: Colors.white,
      )
    ],
  );
  final fileName = 'notifications.txt';
  var temp=json.decode(await readFile(fileName));
  List<dynamic> pastMessages = [];
  if(temp!=null)pastMessages=temp;
  while (true) {
    final pullRequest = PullRequest(
      returnImmediately: false,
      maxMessages: 10,
    );

    final pullResponse = await pubsub.projects.subscriptions.pull(pullRequest, subscriptionName);

    if (pullResponse.receivedMessages != null) {
      for (final receivedMessage in pullResponse.receivedMessages!) {
        final messageData = receivedMessage.message!.data;
        if (messageData != null) {
          final message = utf8.decode(base64.decode(messageData));
          if (pastMessages==Null||!pastMessages.contains(message)) {
            print('Received message: $message');
            showNotification(message);
            pastMessages.add(message);
          }
        }
      }

      await writeFile(fileName, json.encode(pastMessages));
    }

    await Future.delayed(Duration(minutes: 1)); // Delay before pulling messages again
  }
}

Future<void> showNotification(String payload) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 10,
      channelKey: 'basic_channel',
      title: 'New Notification',
      body: 'This is an example notification',
    ),
  );
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