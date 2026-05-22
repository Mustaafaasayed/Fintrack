import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/fintrack_app_bar.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  static const _categories = [
    _CategoryRowData(
      'Food & Groceries',
      4200,
      14,
      Icons.restaurant_outlined,
      Color(0xFF00DBE7),
      0.72,
    ),
    _CategoryRowData(
      'Utilities',
      2850,
      3,
      Icons.bolt_outlined,
      Color(0xFF00DBE7),
      0.45,
    ),
    _CategoryRowData(
      'Transport',
      1900,
      22,
      Icons.directions_car_outlined,
      Color(0xFFA78BFA),
      0.58,
    ),
    _CategoryRowData(
      'Shopping',
      2300,
      5,
      Icons.shopping_bag_outlined,
      Color(0xFF00DBE7),
      0.65,
    ),
    _CategoryRowData(
      'Medical',
      1200,
      2,
      Icons.medical_services_outlined,
      Color(0xFFFFAB91),
      0.35,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FintrackAppBar(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.screenMargin,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Spending Intelligence', style: AppTheme.headlineLg),
                const SizedBox(height: 8),
                Text(
                  'Expense cycle: Oct 1 – Oct 31',
                  style: AppTheme.bodySm,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.screenMargin,
            ),
            child: _MonthlySpendingCard(),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.screenMargin,
            ),
            child: _IncomeSpendingChart(),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.screenMargin,
            ),
            child: Text('EXPENSE BREAKDOWN', style: AppTheme.labelCyan),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.screenMargin,
            ),
            child: Column(
              children: _categories
                  .map((c) => _BreakdownRow(data: c))
                  .toList(),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.screenMargin,
            ),
            child: _RemainingBudgetCard(),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _MonthlySpendingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.cardPadding),
      decoration: AppTheme.glassCard(),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total Monthly Spending', style: AppTheme.bodySm),
              const SizedBox(height: 8),
              Text(
                AppTheme.formatCurrency(12450),
                style: AppTheme.amountLg,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.trending_up_rounded,
                      size: 14, color: AppTheme.mint),
                  const SizedBox(width: 4),
                  Text(
                    '+8.2% vs last cycle',
                    style: AppTheme.bodySm.copyWith(color: AppTheme.mint),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppTheme.cyan.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.show_chart_rounded, color: AppTheme.cyan),
            ),
          ),
        ],
      ),
    );
  }
}

class _IncomeSpendingChart extends StatelessWidget {
  List<FlSpot> _generateSpots({required bool isIncome}) {
    return List.generate(30, (i) {
      final base = isIncome ? 800.0 + i * 120.0 : 600.0 + i * 90.0;
      final wave = (i % 5) * (isIncome ? 80.0 : 60.0);
      return FlSpot(i.toDouble(), base + wave);
    });
  }

  @override
  Widget build(BuildContext context) {
    final incomeSpots = _generateSpots(isIncome: true);
    final spendingSpots = _generateSpots(isIncome: false);

    return Container(
      height: 220,
      padding: const EdgeInsets.fromLTRB(8, 16, 16, 8),
      decoration: AppTheme.glassCard(),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            horizontalInterval: 2000,
            verticalInterval: 5,
            getDrawingHorizontalLine: (_) => FlLine(
              color: AppTheme.outlineVariant.withValues(alpha: 0.4),
              strokeWidth: 1,
              dashArray: [4, 4],
            ),
            getDrawingVerticalLine: (_) => FlLine(
              color: AppTheme.outlineVariant.withValues(alpha: 0.25),
              strokeWidth: 1,
              dashArray: [4, 4],
            ),
          ),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: 29,
          minY: 0,
          maxY: 5000,
          lineBarsData: [
            LineChartBarData(
              spots: incomeSpots,
              isCurved: true,
              color: AppTheme.mint,
              barWidth: 2,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppTheme.mint.withValues(alpha: 0.25),
                    AppTheme.mint.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
            LineChartBarData(
              spots: spendingSpots,
              isCurved: true,
              color: AppTheme.errorRed,
              barWidth: 2,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppTheme.errorRed.withValues(alpha: 0.2),
                    AppTheme.errorRed.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ],
          lineTouchData: const LineTouchData(enabled: false),
        ),
      ),
    );
  }
}

class _BreakdownRow extends StatelessWidget {
  const _BreakdownRow({required this.data});

  final _CategoryRowData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: AppTheme.squircle(
                  color: data.color.withValues(alpha: 0.15),
                ),
                child: Icon(data.icon, color: data.color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.name, style: AppTheme.titleMd),
                    Text(
                      '${data.count} transactions',
                      style: AppTheme.bodySm.copyWith(fontSize: 11),
                    ),
                  ],
                ),
              ),
              Text(
                AppTheme.formatCurrency(data.amount),
                style: AppTheme.bodyMd.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppTheme.radiusPill),
            child: LinearProgressIndicator(
              value: data.progress,
              minHeight: 3,
              backgroundColor: AppTheme.surfaceHigh,
              color: AppTheme.cyan,
            ),
          ),
        ],
      ),
    );
  }
}

class _RemainingBudgetCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.cardPadding),
      decoration: AppTheme.glassCard(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Remaining Budget', style: AppTheme.bodySm),
          const SizedBox(height: 8),
          Text(
            AppTheme.formatCurrency(7550),
            style: AppTheme.amountLg.copyWith(color: AppTheme.mint),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppTheme.radiusPill),
            child: const LinearProgressIndicator(
              value: 0.62,
              minHeight: 8,
              backgroundColor: AppTheme.surfaceHigh,
              color: AppTheme.mint,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "You've spent 62% of your monthly limit",
            style: AppTheme.bodySm,
          ),
        ],
      ),
    );
  }
}

class _CategoryRowData {
  const _CategoryRowData(
    this.name,
    this.amount,
    this.count,
    this.icon,
    this.color,
    this.progress,
  );

  final String name;
  final double amount;
  final int count;
  final IconData icon;
  final Color color;
  final double progress;
}
