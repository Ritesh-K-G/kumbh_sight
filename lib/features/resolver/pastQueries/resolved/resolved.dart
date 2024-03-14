import 'package:flutter/material.dart';
import 'package:kumbh_sight/models/queryDetails.dart';
import 'package:kumbh_sight/utils/widgets/card.dart';

class CleanerResolvedList extends StatefulWidget {
  @override
  _CleanerResolvedListState createState() => _CleanerResolvedListState();
}

class _CleanerResolvedListState extends State<CleanerResolvedList> {
  final List<CardDetail> cardDetails = [
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cardDetails.length,
      itemBuilder: (context, index) {
        final cardDetail = cardDetails[index];
        return CardItem(cardDetail: cardDetail);
      },
    );
  }
}

