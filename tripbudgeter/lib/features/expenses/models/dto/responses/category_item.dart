class CategoryItem {
  late int? id;
  final String name;
  final double amount;

  CategoryItem({this.id, required this.name, this.amount = 0});

  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      id: json['id'],
      name: json['name'],
      amount: json['amount'],
    );
  }
}