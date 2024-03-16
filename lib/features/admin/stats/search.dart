import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kumbh_sight/constants/color.dart';
import 'package:kumbh_sight/constants/url.dart';
import 'package:kumbh_sight/features/admin/stats/searchResults.dart';
import 'package:kumbh_sight/models/queryDetails.dart';
import 'package:kumbh_sight/models/userModel.dart';
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
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const AlertDialog(
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                CircularProgressIndicator(),
                                                SizedBox(height: 16),
                                                Text('Opening Stats...'),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                      final Dio dio = Dio();
                                      try {
                                        var res = await dio.post('${url.link}/viewComplaintsAdmin',
                                          data: {
                                            'location': selectedLocationValue,
                                            'category': selectedValue
                                          }
                                        );
                                        print(res);
                                      //   complaints = [] , user = {}
                                        late List<CardDetail> cardDetails = [];
                                        List<CardDetail> convertToQueryModels(List<dynamic> list) {
                                          return list.map((item) => CardDetail.fromMap(item)).toList();
                                        }
                                        cardDetails = convertToQueryModels(res.data['complaints']);
                                        print(cardDetails);
                                        userDetail userData = userDetail.fromMap(res.data['user'][0] ?? {
                                          'name': 'name',
                                          'userID': 'ishaan',
                                          'assignedLocation': 'Jhalwa',
                                          'category': 'Hygiene'
                                        });
                                        Navigator.pop(context);
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => searchResults(
                                          userData: userData, cardData: cardDetails)));
                                      }
                                      catch(err) {
                                        print(err);
                                        Navigator.pop(context);
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text('Response'),
                                              content: const SingleChildScrollView(
                                                child: Text('Some Error Occured'),
                                              ),
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
