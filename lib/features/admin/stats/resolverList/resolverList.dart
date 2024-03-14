import 'package:flutter/material.dart';
import 'package:kumbh_sight/models/queryDetails.dart';
import 'package:kumbh_sight/utils/widgets/personCards.dart';

class resolverList extends StatefulWidget {
  const resolverList({super.key});

  @override
  State<resolverList> createState() => _resolverListState();
}

class _resolverListState extends State<resolverList> {
  final List<CardDetail> cardDetails = [
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cardDetails.length,
      itemBuilder: (context, index) {
        final cardDetail = cardDetails[index];
        return personCard(cardDetail: cardDetail);
      },
    );
  }
}
