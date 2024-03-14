import 'package:flutter/material.dart';
import 'package:kumbh_sight/features/resolver/pastQueries/unresolved/unresolvedCard.dart';
import 'package:kumbh_sight/models/queryDetails.dart';
import 'package:kumbh_sight/utils/widgets/card.dart';

class CleanerUnresolvedList extends StatefulWidget {
  @override
  _CleanerUnresolvedListState createState() => _CleanerUnresolvedListState();
}

class _CleanerUnresolvedListState extends State<CleanerUnresolvedList> {
  final List<CardDetail> cardDetails = [
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cardDetails.length,
      itemBuilder: (context, index) {
        final cardDetail = cardDetails[index];
        return unresolvedCardItem(cardDetail: cardDetail);
      },
    );
  }
}