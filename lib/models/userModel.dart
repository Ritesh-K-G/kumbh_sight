class userDetail {

  final String name, userID;
  final String category, assignedLocation;

  userDetail({
    required this.userID,
    required this.name,
    required this.category,
    required this.assignedLocation
  });

  factory userDetail.fromMap(Map<String, dynamic> map) {

    return userDetail(
        userID: map['userID'],
        name: map['firstName'] + ' ' + map['lastName'],
        category: map['category'],
        assignedLocation: map['assignedLocation']
    );
  }
}