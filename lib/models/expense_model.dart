import 'package:hive/hive.dart';

part 'expense_model.g.dart';

@HiveType(typeId: 0)
class Expense extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double amount;

  @HiveField(3)
  final String category;

  @HiveField(4)
  final DateTime date;

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
  });
}

enum ExpenseCategory {
  food,
  transport,
  shopping,
  health,
  entertainment,
  other;

  String get label {
    switch (this) {
      case food: return 'Food';
      case transport: return 'Transport';
      case shopping: return 'Shopping';
      case health: return 'Health';
      case entertainment: return 'Entertainment';
      case other: return 'Other';
    }
  }

  String get emoji {
    switch (this) {
      case food: return '🍔';
      case transport: return '🚗';
      case shopping: return '🛍';
      case health: return '💊';
      case entertainment: return '🎮';
      case other: return '📦';
    }
  }
}
