import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kumbh_sight/constants/url.dart';
import 'package:kumbh_sight/models/points.dart';

class hotZone extends StatefulWidget {
  const hotZone({super.key});

  @override
  State<hotZone> createState() => _hotZoneState();
}

class _hotZoneState extends State<hotZone> {
  late GoogleMapController _mapController;
  late bool serverCalled = false;
  LatLng _currentCenter = LatLng(25.443920, 81.825027);
  late Set<Marker>markers={};
  late Set<Circle>circles={};

  @override
  void initState() {
    super.initState();
    (()async =>{
      await fetchDetails()
    })();
  }

  Future<void> fetchDetails() async {
    final Dio dio = Dio();
    var res = await dio.post('${url.link}/predictionsML');
    print(res.data);
    Map<String,point>rev={'Jhalwa':point(x:25.434711,y:81.765030),'Rajruppur':point(x:25.4374395,y:81.79859822547),"Dhoomanganj":point(x:25.4542189,y:81.7946294),"Bajha":point(x:25.4542,y: 81.75)};
    int threshold=500;
    res.data.forEach((key, value) {
      markers.add(
        Marker(
          markerId: MarkerId(key),
          position: LatLng(rev[key]!.x,rev[key]!.y),
          infoWindow: InfoWindow(title: 'Marker for $key', snippet: 'Marker Snippet'),
        )
      );
      circles.add(
          Circle(
            circleId: CircleId(key),
            center:  LatLng(rev[key]!.x,rev[key]!.y),
            radius: 500,
            fillColor: value>threshold?Colors.red.withOpacity(0.3):Colors.green.withOpacity(0.3),
            strokeWidth: 2,
            strokeColor: value>threshold?Colors.red:Colors.green,
          )
      );
    });
    setState(() {
      serverCalled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: const Text('Predicted Hot Zone'),
      ),
      body: serverCalled
        ? GoogleMap(
        onMapCreated: (controller) {
          setState(() {
            _mapController = controller;
          });
        },
        initialCameraPosition: CameraPosition(
          target: _currentCenter,
          zoom: 12,
        ),
        markers: markers,
        circles: circles,
      )
        : const Center(child: CircularProgressIndicator()),
    ));
  }
}
