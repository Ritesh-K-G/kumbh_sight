import 'package:flutter/material.dart';
import 'package:kumbh_sight/models/queryDetails.dart';
import 'package:kumbh_sight/models/userModel.dart';
import 'package:kumbh_sight/utils/widgets/personCards.dart';

class resolverList extends StatefulWidget {
  final List<userDetail> cardDetails;

  const resolverList({super.key, required this.cardDetails});

  @override
  State<resolverList> createState() => _resolverListState();
}

class _resolverListState extends State<resolverList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.cardDetails.length,
      itemBuilder: (context, index) {
        final cardDetail = widget.cardDetails[index];
        return personCard(cardDetail: cardDetail);
      },
    );
  }
}
