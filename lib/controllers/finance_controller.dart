import 'package:get/get.dart';

enum FinanceFilter {
  today,
  yesterday,
  last7Days,
  lastMonth,
}

class FinanceController extends GetxController {
  final selectedFilter = FinanceFilter.today.obs;

  final items = <FinanceItem>[
    FinanceItem(
      orderId: '#1001',
      orderValue: 2500.0,
      commission: 250.0,
      orderTotal: 2250.0,
      createdAt: DateTime(2026, 2, 9),
    ),
    FinanceItem(
      orderId: '#1002',
      orderValue: 1800.0,
      commission: 180.0,
      orderTotal: 1620.0,
      createdAt: DateTime(2026, 2, 8),
    ),
    FinanceItem(
      orderId: '#1003',
      orderValue: 3200.0,
      commission: 320.0,
      orderTotal: 2880.0,
      createdAt: DateTime(2026, 2, 3),
    ),
    FinanceItem(
      orderId: '#1004',
      orderValue: 1500.0,
      commission: 150.0,
      orderTotal: 1350.0,
      createdAt: DateTime(2026, 1, 18),
    ),
  ].obs;

  void changeFilter(FinanceFilter filter) {
    selectedFilter.value = filter;
  }

  List<FinanceItem> get filteredItems {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    return items.where((item) {
      final itemDate = DateTime(
        item.createdAt.year,
        item.createdAt.month,
        item.createdAt.day,
      );

      switch (selectedFilter.value) {
        case FinanceFilter.today:
          return itemDate == today;
        case FinanceFilter.yesterday:
          final yesterday = today.subtract(const Duration(days: 1));
          return itemDate == yesterday;
        case FinanceFilter.last7Days:
          final sevenDaysAgo = today.subtract(const Duration(days: 7));
          return itemDate.isAfter(
                sevenDaysAgo.subtract(const Duration(days: 1)),
              ) &&
              itemDate.isBefore(
                today.add(const Duration(days: 1)),
              );
        case FinanceFilter.lastMonth:
          final lastMonthStart = DateTime(today.year, today.month - 1, 1);
          final lastMonthEnd =
              DateTime(today.year, today.month, 1).subtract(const Duration(days: 1));
          return itemDate.isAtSameMomentAs(lastMonthStart) ||
              (itemDate.isAfter(lastMonthStart) &&
                  itemDate.isBefore(lastMonthEnd.add(const Duration(days: 1))));
      }
    }).toList();
  }
}

class FinanceItem {
  final String orderId;
  final double orderValue;
  final double commission;
  final double orderTotal;
  final DateTime createdAt;

  const FinanceItem({
    required this.orderId,
    required this.orderValue,
    required this.commission,
    required this.orderTotal,
    required this.createdAt,
  });
}

