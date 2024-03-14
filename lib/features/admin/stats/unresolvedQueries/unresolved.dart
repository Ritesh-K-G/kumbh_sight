import 'package:flutter/material.dart';
import 'package:kumbh_sight/models/queryDetails.dart';
import 'package:kumbh_sight/utils/widgets/card.dart';

class unresolvedPage extends StatefulWidget {
  const unresolvedPage({super.key});

  @override
  State<unresolvedPage> createState() => _unresolvedPageState();
}

class _unresolvedPageState extends State<unresolvedPage> {
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
