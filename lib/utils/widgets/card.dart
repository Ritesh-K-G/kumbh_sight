import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kumbh_sight/models/queryDetails.dart';

class CardItem extends StatefulWidget {
  final CardDetail cardDetail;

  CardItem({required this.cardDetail});

  @override
  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      margin: const EdgeInsets.all(10.0),
      color: const Color(0xFFFFFFFF),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 130,
                  height: 200,
                  child: Image.asset('assets/gifs/cleaning.gif'),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.cardDetail.category,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                          'Date: ${widget.cardDetail.dateTime.toString().substring(0, 10)}\n'
                          'Time: ${widget.cardDetail.dateTime.toString().substring(11, 19)}\n'),
                      Row(
                        children: [
                          isExpanded == false
                            ? const Text('Show Description')
                            : const Text('Hide Description'),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  isExpanded = !isExpanded;
                                });
                              },
                              icon: isExpanded == false
                                  ? const Icon(Icons.arrow_downward)
                                  : const Icon(Icons.arrow_upward))
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            Visibility(
                visible: isExpanded,
                child: Text('Description: ${widget.cardDetail.description}\n'))
          ],
        ),
      ),
    );
  }
}
