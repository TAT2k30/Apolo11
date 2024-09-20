class TripModel {
  late int? id;
  final String name;
  final String location;
  final String url;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final int totalBudget;

  TripModel({
    this.id,
    required this.name,
    required this.location,
    required this.url,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.totalBudget,
  });

  factory TripModel.fromMap(Map<String, dynamic> map) {
    return TripModel(
      id: map['id'],
      name: map['name'],
      location: map['location'],
      url: map['url'],
      description: map['description'],
      startDate: DateTime.parse(map['startDate']),
      endDate: DateTime.parse(map['endDate']),
      totalBudget: map['totalBudget'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'url': url,
      'description': description,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'totalBudget': totalBudget,
    };
  }
}