import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kumbh_sight/constants/url.dart';
import 'package:kumbh_sight/models/queryDetails.dart';
import 'package:kumbh_sight/utils/widgets/card.dart';

class resolvedList extends StatefulWidget {
  @override
  _resolvedListState createState() => _resolvedListState();
}

class _resolvedListState extends State<resolvedList> {
  bool serverCalled = false;
  late List<CardDetail> cardDetails = [];
  String? userID = '';

  void initState() {
    super.initState();
    userID = FirebaseAuth.instance.currentUser?.uid;
    (()async =>{
      await fetchCardDetails()
    })();
  }

  List<CardDetail> convertToQueryModels(List<dynamic> list) {
    return list.map((item) => CardDetail.fromMap(item)).toList();
  }
  Future<void> fetchCardDetails() async {
    final dio = Dio();
    final cards = await dio.get('${url.link}/viewComplaintsUserResolved?user=$userID');
    print(cards.data);
    cardDetails = convertToQueryModels(cards.data);
    setState(() {
      serverCalled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return serverCalled
        ? myBuild(context)
        : const Center(child: CircularProgressIndicator());
  }

  Widget myBuild(BuildContext context) {
    return cardDetails.isEmpty
    ? const Center(child: Text('No Resolved Queries'))
    : ListView.builder(
      itemCount: cardDetails.length,
      itemBuilder: (context, index) {
        final cardDetail = cardDetails[index];
        return CardItem(cardDetail: cardDetail);
      },
    );
  }
}

