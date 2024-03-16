import 'package:flutter/material.dart';
import 'package:kumbh_sight/constants/color.dart';
import 'package:kumbh_sight/features/admin/stats/searchResults.dart';
import 'package:kumbh_sight/utils/helpers/appHelpers.dart';
import 'package:kumbh_sight/utils/helpers/wrappers.dart';
import 'package:kumbh_sight/utils/styles/buttons.dart';
import 'package:kumbh_sight/utils/styles/text.dart';

class filterSearch extends StatefulWidget {
  const filterSearch({super.key});

  @override
  State<filterSearch> createState() => _filterSearchState();
}

class _filterSearchState extends State<filterSearch> {
  final _formkey = GlobalKey<FormState>();
  String selectedValue = 'LostAndFoundService';
  String selectedLocationValue = 'Jhalwa';
  List<String> categories = ['LostAndFoundService', 'Healthcare', 'LawEnforcement', 'Hygiene'];
  List<String> locations = ['Jhalwa', 'Rajruppur'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Kumbh Sight', style: AppTextStyles.signUpTopHeader),
                  const Text('Look for the resolver statistics/unresolved queries',
                      style: AppTextStyles.fadedTextmd),
                  const SizedBox(height: 20),
                  Form(
                      key: _formkey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Select Location',
                              style: AppTextStyles.formLabelStyle,
                            ),
                            AppWrappers.dropdownWrapper(
                              items: List<DropdownMenuItem<String>>.generate(
                                locations.length,
                                    (index) => DropdownMenuItem(
                                  value: locations[index],
                                  child: Text(
                                    locations[index],
                                    style: AppTextStyles.dropdownText,
                                  ),
                                ),
                              ),
                              value: selectedLocationValue,
                              onChanged: (value) {
                                setState(() {
                                  selectedLocationValue = value;
                                });
                              },
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Select Category',
                              style: AppTextStyles.formLabelStyle,
                            ),
                            AppWrappers.dropdownWrapper(
                              items: List<DropdownMenuItem<String>>.generate(
                                categories.length,
                                    (index) => DropdownMenuItem(
                                  value: categories[index],
                                  child: Text(
                                    categories[index],
                                    style: AppTextStyles.dropdownText,
                                  ),
                                ),
                              ),
                              value: selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value;
                                });
                              },
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => searchResults()));
                                    // if (_formkey.currentState!.validate()) {
                                    //   showDialog(
                                    //     context: context,
                                    //     builder: (BuildContext context) {
                                    //       return const AlertDialog(
                                    //         content: Column(
                                    //           mainAxisSize: MainAxisSize.min,
                                    //           children: [
                                    //             CircularProgressIndicator(),
                                    //             SizedBox(height: 16),
                                    //             Text('Uploading data...'),
                                    //           ],
                                    //         ),
                                    //       );
                                    //     },
                                    //   );
                                    // }
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
                                    "Search",
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
