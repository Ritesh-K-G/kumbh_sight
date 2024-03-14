import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
    userID = 'ishaan';
    (()async =>{
      await fetchCardDetails()
    })();
  }

  List<CardDetail> convertToQueryModels(List<dynamic> list) {
    return list.map((item) => CardDetail.fromMap(item)).toList();
  }
  Future<void> fetchCardDetails() async {
    final dio = Dio();
    final cards = await dio.get('https://8ca2-2409-40e3-d-3003-d912-c00e-e862-44f0.ngrok-free.app/viewComplaintsUserResolved?user=$userID');
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

  @override
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

