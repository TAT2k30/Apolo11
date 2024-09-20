import 'dart:core';

import 'package:tripbudgeter/features/expenses/models/dto/responses/category_item.dart';
import 'package:tripbudgeter/features/expenses/models/expense_model.dart';

class CategoryServices {
  // data sample
  static List<String> CategoryList() {
    return [
      'Food',
      'Transport',
      'Shopping',
      'Entertainment',
      'Health',
      'Bills',
      'Others'
    ];
  }

  // data sample
  static List<CategoryItem> getCategories() {
    return [
      CategoryItem(id: 1, name: 'Food', amount: 20),
      CategoryItem(id: 2, name: 'Transport', amount: 10),
      CategoryItem(id: 3, name: 'Shopping', amount: 30),
      CategoryItem(id: 4, name: 'Entertainment', amount: 40),
      CategoryItem(id: 5, name: 'Health', amount: 50),
      CategoryItem(id: 6, name: 'Bills', amount: 60),
      CategoryItem(id: 7, name: 'Others', amount: 70),
    ];
  }

  final List<CategoryModel> categories = [];
}