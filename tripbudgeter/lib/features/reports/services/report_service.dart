import 'package:tripbudgeter/features/expenses/models/expense_model.dart';

class ReportService {
  // get expenses by tripId
  Future<List<ExpenseModel>> getExpensesByTripId(int tripId) {
    // implement this method
    throw UnimplementedError();
  }

  // get expenses by categoryId
  Future<List<ExpenseModel>> getExpensesByCategoryId(int categoryId) {
    // implement this method
    throw UnimplementedError();
  }

  // get expenses by tripId and categoryId
  Future<List<ExpenseModel>> getExpensesByTripIdAndCategoryId(
      int tripId, int categoryId) {
    // implement this method
    throw UnimplementedError();
  }

  // get total expenses by range date
  Future<List<ExpenseModel>> getTotalExpensesByRangeDate(
      DateTime startDate, DateTime endDate) {
    // implement this method
    throw UnimplementedError();
  }
}