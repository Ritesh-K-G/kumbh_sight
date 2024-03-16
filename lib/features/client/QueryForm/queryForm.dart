import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:kumbh_sight/constants/color.dart';
import 'package:kumbh_sight/constants/url.dart';
import 'package:kumbh_sight/utils/helpers/appHelpers.dart';
import 'package:kumbh_sight/utils/helpers/wrappers.dart';
import 'package:kumbh_sight/utils/styles/buttons.dart';
import 'package:kumbh_sight/utils/styles/text.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
class QueryForm extends StatefulWidget {
  const QueryForm({super.key});

  @override
  State<QueryForm> createState() => _QueryFormState();
}
class _QueryFormState extends State<QueryForm> {
  double _sliderValue = 1.0;
  final _formkey = GlobalKey<FormState>();
  String userID = 'ishaan';
  String selectedValue = 'LostAndFoundService';
  bool switchValue = false;
  late GoogleMapController _mapController;
  final TextEditingController _descController = TextEditingController();
  late bool _serviceEnabled;
  LatLng _currentCenter = LatLng(15.4347, 81.7650);
  Future<Position> _determinePosition() async {

    return await Geolocator.getCurrentPosition();
  }
  @override
  void initState() {
    super.initState();
    _determinePosition().then((Position current){
      print(current);
      print("A\nSDJhjfbdzjBKGJVHFDSKBFHVJDSMFBJSJVFNBMSHVJCGVJKYFUDHXGNCHJFDHGXCHJFYDTHXGNCHJTDGXNCHJTDYHGXC");
      setState(() {
        _currentCenter = LatLng(current.latitude, current.longitude);
      });
      _mapController.animateCamera(
        CameraUpdate.newLatLng(_currentCenter),
      );
    });
  }


  void _moveMap(LatLng lngOffset) {
    setState(() {
      _currentCenter = lngOffset;
    });
    _mapController.animateCamera(
      CameraUpdate.newLatLng(_currentCenter),
    );
  }

  @override
  Widget build(BuildContext context){
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
                                  value: 'LostAndFoundService',
                                  child: Text('Lost and Found service',
                                      style: AppTextStyles.dropdownText),
                                ),
                                const DropdownMenuItem(
                                  value: 'Healthcare',
                                  child: Text('Healthcare',
                                      style: AppTextStyles.dropdownText),
                                ),
                                const DropdownMenuItem(
                                  value: 'LawEnforcement',
                                  child: Text('Law Enforcement',
                                      style: AppTextStyles.dropdownText),
                                ),
                                const DropdownMenuItem(
                                  value: 'Hygiene',
                                  child: Text('Hygiene',
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

                                  child: GoogleMap(
                                    onMapCreated: (controller) {
                                      setState(() {
                                        _mapController = controller;
                                      });
                                    },
                                    onTap: _moveMap,
                                    initialCameraPosition: CameraPosition(
                                      target: _currentCenter,
                                      zoom: 12,
                                    ),
                                    markers: {
                                      Marker(
                                        markerId: MarkerId('marker_id'),
                                        position: _currentCenter,
                                        infoWindow: InfoWindow(title: 'Marker Title', snippet: 'Marker Snippet'),
                                      ),
                                    },
                                    circles: {
                                      Circle(
                                        circleId: CircleId('circle_id'),
                                        center: _currentCenter,
                                        radius: 1000, // Radius in meters
                                        fillColor: Colors.blue.withOpacity(0.3),
                                        strokeWidth: 2,
                                        strokeColor: Colors.blue,
                                      ),
                                    },
                                  ),

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

                                      String suggestions = '';
                                      if (switchValue) {
                                        try {
                                          String _result = await sendSMS(
                                            message: 'KumbhSight Add $userID '
                                                '${_currentCenter.latitude} ${_currentCenter.longitude} '
                                                '$_sliderValue $selectedValue ${_descController.text}',
                                            recipients: ['9306786838'],
                                            sendDirect: true,
                                          );
                                          suggestions = 'SMS sent successfully';
                                          print(_result);
                                        } catch (err) {
                                          suggestions = 'Some error occurred';
                                        } finally {
                                          Navigator.pop(context);
                                          _descController.clear();
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
                                      } else {
                                        try {
                                          final dio = Dio();
                                          final res = await dio.post(
                                            '${url.link}/addComplaint',
                                            data: {
                                              'user': userID,
                                              'description': _descController.text,
                                              'latitude': _currentCenter.latitude,
                                              'longitude': _currentCenter.longitude,
                                              'urgency': _sliderValue,
                                              'category': selectedValue,
                                            },
                                          );
                                          print(res.data);
                                          suggestions = res.data['complaintID'];
                                        } catch (err) {
                                          suggestions = 'Some Error occurred';
                                        } finally {
                                          Navigator.pop(context);
                                          _descController.clear();
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
                                    }
                                  },
                                  style: AppButtonStyles.authButtons.copyWith(
                                    backgroundColor: MaterialStateProperty.all(AppColors.Bhagwa),
                                    minimumSize: MaterialStateProperty.all(
                                      Size(
                                        AppHelpers.screenWidth(context) * 0.8,
                                        50,
                                      ),
                                    ),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
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