import 'package:flutter/material.dart';
import 'package:kumbh_sight/models/queryDetails.dart';
import 'package:kumbh_sight/utils/widgets/card.dart';

class unresolvedPage extends StatefulWidget {
  final List<CardDetail> cardDetails;
  const unresolvedPage({super.key, required this.cardDetails});

  @override
  State<unresolvedPage> createState() => _unresolvedPageState();
}

class _unresolvedPageState extends State<unresolvedPage> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.cardDetails.length,
      itemBuilder: (context, index) {
        final cardDetail = widget.cardDetails[index];
        return CardItem(cardDetail: cardDetail);
      },
    );
  }
}
