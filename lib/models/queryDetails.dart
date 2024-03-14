class CardDetail {
  final String category;
  final DateTime dateTime;
  final String description;
  final String imageUrl;
  final String place;
  final double latitude, longitude;
  final int urgency;
  final String queryID;

  CardDetail({
    required this.place,
    required this.latitude,
    required this.longitude,
    required this.urgency,
    required this.queryID,
    required this.category,
    required this.dateTime,
    required this.description,
    required this.imageUrl,
  });

  factory CardDetail.fromMap(Map<String, dynamic> map) {
    return CardDetail(
      place: map['place'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      urgency: map['urgency'],
      queryID: map['queryID'],
      category: map['category'],
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['date'] * 1000),
      description: map['description'],
      imageUrl: 'assets/images/kumbh_sight.png',
    );
  }
}