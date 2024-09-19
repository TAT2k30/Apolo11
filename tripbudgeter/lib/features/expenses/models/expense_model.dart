import 'package:tripbudgeter/features/trips/models/trip_model.dart';

class ExpenseModel {
  late int? id;
  final CategoryModel category;
  final TripModel trip;
  final String note;
  final double amount;
  final DateTime createdAt;
  final DateTime updatedAt;

  ExpenseModel(
      {this.id,
      required this.category,
      required this.trip,
      required this.note,
      required this.amount,
      required this.createdAt,
      required this.updatedAt});

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['id'],
      category: CategoryModel.fromMap(map['category']),
      trip: TripModel.fromMap(map['trip']),
      note: map['note'],
      amount: map['amount'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}

class CategoryModel {
  late int? id;
  final String name;
  late String? icon;

  CategoryModel({this.id, required this.name, this.icon});

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      name: map['name'],
      icon: map['icon'],
    );
  }
}