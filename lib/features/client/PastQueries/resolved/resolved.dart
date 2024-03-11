import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:kumbh_sight/models/queryDetails.dart';
import 'package:kumbh_sight/utils/widgets/card.dart';

class resolvedList extends StatefulWidget {
  @override
  _resolvedListState createState() => _resolvedListState();
}

class _resolvedListState extends State<resolvedList> {
  final List<CardDetail> cardDetails = [
    CardDetail(
      category: 'Category 1',
      dateTime: DateTime.now(),
      description: 'Description 1 Description 1 Description 1 Description 1 Description 1'
          'Description 1 Description 1 Description 1 Description 1 Description 1'
          'Description 1 Description 1 Description 1 Description 1 Description 1'
          'Description 1 Description 1 Description 1 Description 1 Description 1',
      imageUrl: 'assets/gifs/cleaning.gif',
    ),
    CardDetail(
      category: 'Category 2',
      dateTime: DateTime.now(),
      description: 'Description 2',
      imageUrl: 'assets/gifs/cleaning.gif',
    ),
    CardDetail(
      category: 'Category 3',
      dateTime: DateTime.now(),
      description: 'Description 3',
      imageUrl: 'assets/gifs/cleaning.gif',
    ),
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

