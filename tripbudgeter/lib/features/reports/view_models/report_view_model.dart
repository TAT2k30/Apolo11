import 'package:flutter/material.dart';
import 'package:tripbudgeter/features/expenses/models/expense_model.dart';
import 'package:tripbudgeter/features/reports/services/report_service.dart';

class ReportViewModel extends ChangeNotifier {
  late int _tripId = 0;
  final ReportService _reportService = ReportService();
  final List<ExpenseModel> _expenses = [];

  int get tripId => _tripId;

  void setTripId(int tripId) {
    _tripId = tripId;
    notifyListeners();
  }

  void resetTripId() {
    _tripId = 0;
    notifyListeners();
  }

  //set list of expenses
  void setExpenses(List<ExpenseModel> expenses) {
    _expenses.clear();
    _expenses.addAll(expenses);
    notifyListeners();
  }

  // get expenses by tripId
  Future<List<ExpenseModel>> getExpensesByTripId(int tripId) async {
    List<ExpenseModel> expenses =
        await _reportService.getExpensesByTripId(tripId);
    setExpenses(expenses);
    return expenses;
  }

  // get expenses by categoryId
  Future<List<ExpenseModel>> getExpensesByCategoryId(int categoryId) async {
    List<ExpenseModel> expenses =
        await _reportService.getExpensesByCategoryId(categoryId);
    setExpenses(expenses);
    return expenses;
  }

  // get total expenses by range date
  Future<List<ExpenseModel>> getTotalExpensesByRangeDate(
      DateTime startDate, DateTime endDate) async {
    List<ExpenseModel> expenses =
        await _reportService.getTotalExpensesByRangeDate(startDate, endDate);
    setExpenses(expenses);
    return expenses;
  }
}