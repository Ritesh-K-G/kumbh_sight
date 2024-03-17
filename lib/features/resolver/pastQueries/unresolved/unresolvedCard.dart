import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kumbh_sight/features/resolver/queryDetails/queryDetails.dart';
import 'package:kumbh_sight/models/queryDetails.dart';

class unresolvedCardItem extends StatefulWidget {
  final CardDetail cardDetail;

  unresolvedCardItem({required this.cardDetail});

  @override
  _unresolvedCardItemState createState() => _unresolvedCardItemState();
}

class _unresolvedCardItemState extends State<unresolvedCardItem> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => queryDetails(cardDetail: widget.cardDetail)))
        .then((value) => setState(() {
        }));
      },
      child: Card(
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
                    child: Image.asset(widget.cardDetail.imageUrl),
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
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
