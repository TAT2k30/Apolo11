import 'package:flutter/material.dart';
import 'package:tripbudgeter/features/expenses/models/expense_model.dart';
import 'package:tripbudgeter/features/expenses/services/expense_service.dart';

class ExpenseViewModel extends ChangeNotifier {
  final List<ExpenseModel> _expenses = [];
  final ExpenseService _expenseService = ExpenseService();

  List<ExpenseModel> get expenses => _expenses;

  Future<void> getExpenses() async {
    final expenses = await _expenseService.getExpenses();
    if (expenses != null) {
      _expenses.clear();
      _expenses.addAll(expenses);
      notifyListeners();
    }
  }

  Future<void> addExpense(ExpenseModel expense) async {
    await _expenseService.addExpense(expense);
    await getExpenses();
  }

  Future<void> updateExpense(ExpenseModel expense) async {
    await _expenseService.updateExpense(expense);
    await getExpenses();
  }

  Future<void> deleteExpense(ExpenseModel expense) async {
    await _expenseService.deleteExpense(expense);
    await getExpenses();
  }
}