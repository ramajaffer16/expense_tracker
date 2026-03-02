import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import '../models/expense_model.dart';

class ExpenseProvider extends ChangeNotifier {
  static const String _boxName = 'expenses';
  late Box<Map> _box;
  List<Expense> _expenses = [];
  bool _isLoaded = false;

  List<Expense> get expenses => List.unmodifiable(_expenses);
  bool get isLoaded => _isLoaded;

  double get totalSpent =>
      _expenses.fold(0, (sum, e) => sum + e.amount);

  Map<String, double> get categoryTotals {
    final Map<String, double> totals = {};
    for (final e in _expenses) {
      totals[e.category] = (totals[e.category] ?? 0) + e.amount;
    }
    return totals;
  }

  Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox<Map>(_boxName);
    _loadExpenses();
  }

  void _loadExpenses() {
    _expenses = _box.values.map((map) {
      return Expense(
        id: map['id'] as String,
        title: map['title'] as String,
        amount: map['amount'] as double,
        category: map['category'] as String,
        date: DateTime.parse(map['date'] as String),
      );
    }).toList()
      ..sort((a, b) => b.date.compareTo(a.date));

    _isLoaded = true;
    notifyListeners();
  }

  Future<void> addExpense({
    required String title,
    required double amount,
    required String category,
  }) async {
    final expense = Expense(
      id: const Uuid().v4(),
      title: title,
      amount: amount,
      category: category,
      date: DateTime.now(),
    );

    await _box.put(expense.id, {
      'id': expense.id,
      'title': expense.title,
      'amount': expense.amount,
      'category': expense.category,
      'date': expense.date.toIso8601String(),
    });

    _expenses.insert(0, expense);
    notifyListeners();
  }

  Future<void> deleteExpense(String id) async {
    await _box.delete(id);
    _expenses.removeWhere((e) => e.id == id);
    notifyListeners();
  }
}
