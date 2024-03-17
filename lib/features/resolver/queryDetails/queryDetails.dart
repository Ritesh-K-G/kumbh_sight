import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kumbh_sight/constants/color.dart';
import 'package:kumbh_sight/constants/url.dart';
import 'package:kumbh_sight/models/queryDetails.dart';
import 'package:kumbh_sight/utils/helpers/appHelpers.dart';
import 'package:kumbh_sight/utils/styles/buttons.dart';
import 'package:kumbh_sight/utils/styles/text.dart';
import 'package:dio/dio.dart';

class queryDetails extends StatefulWidget {
  final CardDetail cardDetail;
  const queryDetails({super.key, required this.cardDetail});

  @override
  State<queryDetails> createState() => _queryDetailsState();
}

class _queryDetailsState extends State<queryDetails> {

  late GoogleMapController _mapController;
  LatLng _currentCenter = LatLng(1.2,3.2);

  @override
  void initState(){
    super.initState();
    _currentCenter=LatLng(widget.cardDetail.latitude, widget.cardDetail.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Query Details',
              style: TextStyle(
                fontWeight: FontWeight.w500
              ),
            )
          ),
          backgroundColor: AppColors.myBackgroundGreen,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Iconsax.broom),
                      const SizedBox(width: 5),
                      Text(
                        widget.cardDetail.category,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Date : ${widget.cardDetail.dateTime.toString().substring(0, 10)}\n'
                        'Time : ${widget.cardDetail.dateTime.toString().substring(11, 19)}',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300
                        ),
                      ),
                      Container(
                        // margin: const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
                        // alignment: const Alignment(-0.6, 0.0),
                        height: AppHelpers.screenHeight(context) * 0.2,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(widget.cardDetail.imageUrl),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                        ),
                        width: MediaQuery.of(context).size.width * 0.4,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Description : ${widget.cardDetail.description}\n',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Location : ${widget.cardDetail.place}\n',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  const Divider(
                    height: 20,
                    thickness: 2,
                    indent: 10,
                    endIndent: 10,
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
                    ),

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
                                    Text('Uploading data...'),
                                  ],
                                ),
                              );
                            },
                          );
                          try {
                            await Dio().post('${url.link}/resolveComplaint',
                                data: {
                                  'complaintID': widget.cardDetail.queryID
                                });
                          }catch(err){

                          }finally{
                            Navigator.pop(context);
                            Navigator.pop(context);

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
                          "Mark as Resolved",
                          style: AppTextStyles.buttontext,
                        ),
                      )
                    ],
                  )
                ],
            ),
            ),
          ),
        )
    );
  }
}
