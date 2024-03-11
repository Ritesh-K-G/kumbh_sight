import 'package:flutter/material.dart';
import 'package:kumbh_sight/constants/color.dart';
import 'package:kumbh_sight/utils/helpers/appHelpers.dart';
import 'package:kumbh_sight/utils/helpers/wrappers.dart';
import 'package:kumbh_sight/utils/styles/buttons.dart';
import 'package:kumbh_sight/utils/styles/text.dart';

class QueryForm extends StatefulWidget {
  const QueryForm({super.key});

  @override
  State<QueryForm> createState() => _QueryFormState();
}
class _QueryFormState extends State<QueryForm> {
  double _sliderValue = 1.0;
  final _formkey = GlobalKey<FormState>();
  String userID = "";
  String selectedValue = 'Category1';
  bool switchValue = false;
  final TextEditingController _descController = TextEditingController();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Kumbh Sight', style: AppTextStyles.signUpTopHeader),
                  const Text('Help us to maintain a good environment :)',
                      style: AppTextStyles.fadedTextmd),
                  const SizedBox(height: 20),
                  Form(
                      key: _formkey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppWrappers.inputFieldWrapper(SizedBox(
                              height: 120,
                              child: TextFormField(
                                controller: _descController,
                                decoration: const InputDecoration(
                                  hintText: "Description",
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
                            const SizedBox(height: 20),
                            AppWrappers.dropdownWrapper(
                              items: [
                                const DropdownMenuItem(
                                  value: 'Category1',
                                  child: Text('Category1',
                                      style: AppTextStyles.dropdownText),
                                ),
                                const DropdownMenuItem(
                                  value: 'Category2',
                                  child: Text('Category2',
                                      style: AppTextStyles.dropdownText),
                                ),
                                const DropdownMenuItem(
                                  value: 'Category3',
                                  child: Text('Category3',
                                      style: AppTextStyles.dropdownText),
                                ),
                                const DropdownMenuItem(
                                  value: 'Category4',
                                  child: Text('Category4',
                                      style: AppTextStyles.dropdownText),
                                ),
                              ],
                              value: selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value;
                                });
                              },
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Urgency level: $_sliderValue',
                              style: AppTextStyles.formLabelStyle,
                            ),
                            const SizedBox(height: 20.0),
                            Slider(
                              value: _sliderValue,
                              min: 1.0,
                              max: 10.0,
                              divisions: 9,
                              onChanged: (value) {
                                setState(() {
                                  _sliderValue = value;
                                });
                              },
                            ),
                            const SizedBox(height: 20),
                            Container(
                                width: AppHelpers.screenWidth(context) * 0.9,
                                height: AppHelpers.screenHeight(context) * 0.5,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                ),
                                // child: const showMap()
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Switch(
                                  value: switchValue,
                                  onChanged: (value) {
                                    setState(() {
                                      switchValue = value;
                                    });
                                  },
                                ),
                                Text(
                                  switchValue ? 'Submit Offline' : 'Submit Online',
                                  style: const TextStyle(
                                      color: AppColors.myCommentGray
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    if (_formkey.currentState!.validate()) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const AlertDialog(
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                CircularProgressIndicator(),
                                                SizedBox(height: 16),
                                                Text('Uploading data...'),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  },
                                  style: AppButtonStyles.authButtons.copyWith(
                                      backgroundColor:
                                      MaterialStateProperty.all(AppColors.Bhagwa),
                                      minimumSize: MaterialStateProperty.all(
                                          Size(AppHelpers.screenWidth(context) *
                                              0.8,
                                              50)),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(10.0),
                                          ))),
                                  child: const Text(
                                    "Submit",
                                    style: AppTextStyles.buttontext,
                                  ),
                                )
                              ],
                            )
                          ]
                      )
                  )
                ]
            )
        )
    );
  }
}