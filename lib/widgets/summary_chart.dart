import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../models/expense_model.dart';

class SummaryChart extends StatelessWidget {
  final Map<String, double> categoryTotals;
  const SummaryChart({super.key, required this.categoryTotals});

  static const List<Color> _colors = [
    Color(0xFF2E7D32), Color(0xFF1565C0), Color(0xFFE65100),
    Color(0xFF6A1B9A), Color(0xFF00838F), Color(0xFF827717),
  ];

  @override
  Widget build(BuildContext context) {
    final entries = categoryTotals.entries.toList();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('By Category', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 16),
          SizedBox(
            height: 160,
            child: PieChart(
              PieChartData(
                sections: List.generate(entries.length, (i) {
                  final category = ExpenseCategory.values.firstWhere(
                    (c) => c.name == entries[i].key,
                    orElse: () => ExpenseCategory.other,
                  );
                  return PieChartSectionData(
                    value: entries[i].value,
                    color: _colors[i % _colors.length],
                    title: category.emoji,
                    radius: 50,
                    titleStyle: const TextStyle(fontSize: 18),
                  );
                }),
                sectionsSpace: 2,
                centerSpaceRadius: 36,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 6,
            children: List.generate(entries.length, (i) {
              final category = ExpenseCategory.values.firstWhere(
                (c) => c.name == entries[i].key,
                orElse: () => ExpenseCategory.other,
              );
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(width: 10, height: 10,
                    decoration: BoxDecoration(
                      color: _colors[i % _colors.length],
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text('${category.label} \$${entries[i].value.toStringAsFixed(0)}',
                      style: const TextStyle(fontSize: 12)),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
