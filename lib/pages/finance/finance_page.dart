import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:izma_foods_vendor/config/theme.dart';
import 'package:izma_foods_vendor/pages/widget/izma_app_bar.dart';
import 'package:izma_foods_vendor/pages/widget/izma_radial_gradient_container.dart';

enum FinanceFilter {
  today,
  yesterday,
  last7Days,
  lastMonth,
}

class FinancePage extends StatefulWidget {
  const FinancePage({super.key});

  @override
  State<FinancePage> createState() => _FinancePageState();
}

class _FinancePageState extends State<FinancePage> {
  FinanceFilter _selectedFilter = FinanceFilter.today;

  // Dummy data model for now – replace with API data later.
  final List<_FinanceItem> _items = [
    _FinanceItem(
      orderId: '#1001',
      orderValue: 2500.0,
      commission: 250.0,
      orderTotal: 2250.0,
      createdAt: DateTime(2026, 2, 9),
    ),
    _FinanceItem(
      orderId: '#1002',
      orderValue: 1800.0,
      commission: 180.0,
      orderTotal: 1620.0,
      createdAt: DateTime(2026, 2, 8),
    ),
    _FinanceItem(
      orderId: '#1003',
      orderValue: 3200.0,
      commission: 320.0,
      orderTotal: 2880.0,
      createdAt: DateTime(2026, 2, 3),
    ),
    _FinanceItem(
      orderId: '#1004',
      orderValue: 1500.0,
      commission: 150.0,
      orderTotal: 1350.0,
      createdAt: DateTime(2026, 1, 18),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredItems = _filteredItems();

    return Scaffold(
      body: IzmaRadialGradientContainer(
        child: SafeArea(
          child: Column(
            children: [
              const IzmaAppBar(
                title: 'Finance',
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: kdPadding,
                  vertical: 8.h,
                ),
                child: _buildFilters(context),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: kdPadding,
                    vertical: 4.h,
                  ),
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      return _buildFinanceRow(context, item);
                    },
                    separatorBuilder: (_, __) => SizedBox(height: 8.h),
                    itemCount: filteredItems.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilters(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: kcPrimaryColor,
        borderRadius: BorderRadius.circular(kdBorderRadius),
        border: Border.all(color: kcSecondaryColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildFilterChip(
            context: context,
            label: 'Daily',
            filter: FinanceFilter.today,
          ),
          _buildFilterChip(
            context: context,
            label: 'Yesterday',
            filter: FinanceFilter.yesterday,
          ),
          _buildFilterChip(
            context: context,
            label: 'Last 7 Days',
            filter: FinanceFilter.last7Days,
          ),
          _buildFilterChip(
            context: context,
            label: 'Last Month',
            filter: FinanceFilter.lastMonth,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required BuildContext context,
    required String label,
    required FinanceFilter filter,
  }) {
    final bool isSelected = _selectedFilter == filter;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedFilter = filter;
          });
        },
        child: Container(
          height: 36.h,
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          decoration: BoxDecoration(
            color: isSelected ? kcSecondaryColor : kcPrimaryColor,
            borderRadius: BorderRadius.circular(kdBorderRadius),
            border: Border.all(
              color: kcSecondaryColor,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isSelected ? kcPrimaryColor : kcTextGreyColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 11.sp,
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildFinanceRow(BuildContext context, _FinanceItem item) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: kcPrimaryColor,
        borderRadius: BorderRadius.circular(kdBorderRadius),
        border: Border.all(color: kcSecondaryColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildLabelValue(
              context: context,
              label: 'Order ID',
              value: item.orderId,
            ),
          ),
          Expanded(
            child: _buildLabelValue(
              context: context,
              label: 'Order Value',
              value: 'Rs ${item.orderValue.toStringAsFixed(0)}',
            ),
          ),
          Expanded(
            child: _buildLabelValue(
              context: context,
              label: 'Commission',
              value: 'Rs ${item.commission.toStringAsFixed(0)}',
            ),
          ),
          Expanded(
            child: _buildLabelValue(
              context: context,
              label: 'Order Total',
              value: 'Rs ${item.orderTotal.toStringAsFixed(0)}',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabelValue({
    required BuildContext context,
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: kcTextGreyColor,
                fontSize: 10.sp,
              ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
              ),
        ),
      ],
    );
  }

  List<_FinanceItem> _filteredItems() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    return _items.where((item) {
      final itemDate = DateTime(
        item.createdAt.year,
        item.createdAt.month,
        item.createdAt.day,
      );

      switch (_selectedFilter) {
        case FinanceFilter.today:
          return itemDate == today;
        case FinanceFilter.yesterday:
          final yesterday = today.subtract(const Duration(days: 1));
          return itemDate == yesterday;
        case FinanceFilter.last7Days:
          final sevenDaysAgo = today.subtract(const Duration(days: 7));
          return itemDate.isAfter(sevenDaysAgo.subtract(const Duration(days: 1))) &&
              itemDate.isBefore(today.add(const Duration(days: 1)));
        case FinanceFilter.lastMonth:
          final lastMonthStart =
              DateTime(today.year, today.month - 1, 1);
          final lastMonthEnd =
              DateTime(today.year, today.month, 1).subtract(const Duration(days: 1));
          return itemDate.isAtSameMomentAs(lastMonthStart) ||
              (itemDate.isAfter(lastMonthStart) &&
                  itemDate.isBefore(lastMonthEnd.add(const Duration(days: 1))));
      }
    }).toList();
  }
}

class _FinanceItem {
  final String orderId;
  final double orderValue;
  final double commission;
  final double orderTotal;
  final DateTime createdAt;

  const _FinanceItem({
    required this.orderId,
    required this.orderValue,
    required this.commission,
    required this.orderTotal,
    required this.createdAt,
  });
}

