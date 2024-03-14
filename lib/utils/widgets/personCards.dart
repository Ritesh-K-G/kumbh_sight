import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kumbh_sight/models/queryDetails.dart';

class personCard extends StatefulWidget {
  final CardDetail cardDetail;

  personCard({required this.cardDetail});

  @override
  _personCardState createState() => _personCardState();
}

class _personCardState extends State<personCard> {

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
                  child: Image.asset('assets/images/resolvers.png'),
                ),
                const SizedBox(width: 20),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name: Ishaan Oberoi\n',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'Email: oberoi@ishaan.com'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
