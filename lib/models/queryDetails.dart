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
    const Map<String, List<String>> categoryImageUrls = {
      'LostAndFoundService' : ['assets/images/lost.png'],
      'Healthcare' : ['assets/images/doctor.png'],
      'LawEnforcement' : ['assets/images/police_1.png', 'assets/images/police_2.png'],
      'Hygiene' : ['assets/images/cleaner_1.png', 'assets/images/cleaner_2.png'],
    };

    String imageUrl = (categoryImageUrls[map['category']] ?? []).isNotEmpty
        ? categoryImageUrls[map['category']]![DateTime.now().millisecondsSinceEpoch % categoryImageUrls[map['category']]!.length]
        : 'assets/images/resolvers.png';

    return CardDetail(
      place: map['place'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      urgency: map['urgency'],
      queryID: map['queryID'],
      category: map['category'],
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['date'] * 1000),
      description: map['description'],
      imageUrl: imageUrl,
    );
  }
}