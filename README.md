
 Expense Tracker

A Flutter app to track daily expenses with category breakdown and visual charts.

## Features
- Add and delete expenses
- Category tags (Food, Transport, Shopping, Health, etc.)
- Pie chart breakdown by category using fl_chart
- Local persistence with Hive (no internet needed)
- Swipe to delete expenses

## Tech Stack
- **Flutter** & **Dart**
- **Provider** — state management
- **Hive** — local NoSQL storage
- **fl_chart** — pie chart visualisation
- **intl** — currency formatting

## Getting Started

1. Clone the repo
2. Run `flutter pub get`
3. Run `dart run build_runner build` (generates Hive adapters)
4. Run `flutter run`

## Project Structure
```
lib/
├── main.dart
├── models/
│   └── expense_model.dart
├── providers/
│   └── expense_provider.dart
├── screens/
│   ├── home_screen.dart
│   └── add_expense_screen.dart
└── widgets/
    └── summary_chart.dart
