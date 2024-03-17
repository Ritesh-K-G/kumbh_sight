import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kumbh_sight/constants/url.dart';
import 'package:kumbh_sight/features/admin/stats/resolverList/personStat.dart';
import 'package:kumbh_sight/models/points.dart';
import 'package:kumbh_sight/models/userModel.dart';

class personCard extends StatefulWidget {
  final userDetail cardDetail;

  personCard({required this.cardDetail});

  @override
  _personCardState createState() => _personCardState();
}

class _personCardState extends State<personCard> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Showing Stats...'),
                ],
              ),
            );
          },
        );
        try {
          final Dio dio = Dio();
          var res = await dio.post('${url.link}/getStats',
            data: {
              'location': widget.cardDetail.assignedLocation,
              'category': widget.cardDetail.category
            }
          );
          List<point>lineData=[];
          res.data['hourCounts'].asMap().forEach((index, item) {
            lineData.add(point(x:index.toDouble(),y:item.toDouble()));
          });
          List<point> barData = res.data['counts'].map((e)=>point(x:e['key'].toDouble(),y:e['value'].toDouble())).toList().cast<point>();
          print(lineData);
          print(barData);
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) => personStat(lineData: lineData, barData: barData)));
        } catch(err) {
          Navigator.pop(context);
          print(err);
        }
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
                    child: Image.asset('assets/images/resolvers.png'),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name: ${widget.cardDetail.name}\n',
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'Category: ${widget.cardDetail.category}\n',
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'Location: ${widget.cardDetail.assignedLocation}\n',
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
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
