import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kumbh_sight/constants/url.dart';
import 'package:kumbh_sight/utils/helpers/appHelpers.dart';
import 'package:kumbh_sight/utils/helpers/wrappers.dart';
import 'package:kumbh_sight/utils/styles/buttons.dart';
import 'package:kumbh_sight/utils/styles/text.dart';

class notificationPage extends StatefulWidget {
  const notificationPage({super.key});

  @override
  State<notificationPage> createState() => _notificationPageState();
}

class _notificationPageState extends State<notificationPage> {

  final TextEditingController _notificationController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _notificationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: AppHelpers.screenHeight(context) * 0.1),
              Image.asset(
                'assets/images/kumbh_sight.png',
                height: 180,
                width: 180,
              ),
              const SizedBox(height: 20),
              const Text('Send Notification', style: AppTextStyles.notificationHeader),
              const SizedBox(height: 20),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ENTER NOTIFICATION MESSAGE",
                    style: AppTextStyles.formLabelStyle,
                  ),
                ],
              ),
              AppWrappers.inputFieldWrapper(SizedBox(
                height: 120,
                child: TextFormField(
                  controller: _notificationController,
                  decoration: const InputDecoration(
                    hintText: "Enter the message",
                    border: InputBorder.none,
                  ),
                  style: AppTextStyles.formInputTextStyle,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please provide description'
                      : null,
                ),
              )),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  if (_notificationController.text != '') {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(height: 16),
                              Text('Notifying people...'),
                            ],
                          ),
                        );
                      },
                    );

                    String suggestions = '';
                      try {
                        const String userID = 'ishaan';
                        final dio = Dio();
                        final res = await dio.post(
                          '${url.link}/notification',
                          data: {
                            'message': _notificationController.text
                          },
                        );
                        print(res.data);
                        suggestions = 'Notification sent successfully';
                      } catch (err) {
                        suggestions = 'Some Error occurred';
                      } finally {
                        Navigator.pop(context);
                        _notificationController.clear();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Response'),
                              content: Text(suggestions),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                },
                style: AppButtonStyles.authButtons.copyWith(
                  minimumSize: MaterialStatePropertyAll(Size(AppHelpers.screenWidth(context)*0.9, 50)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                child: const Text(
                  "Notify",
                  style: AppTextStyles.buttontext,
                ),
              )
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
