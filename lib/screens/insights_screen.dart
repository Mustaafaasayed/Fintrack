import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/transactions_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/app_bar.dart';

class InsightsScreen extends ConsumerWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final insights = ref.watch(insightsProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: AppSpacing.unit * 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FintrackAppBar(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenMargin,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Spending Intelligence', style: AppTheme.headlineLg),
                const SizedBox(height: AppSpacing.unit),
                Text(
                  'Expense cycle: ${insights.cycleLabel}',
                  style: AppTheme.bodySm,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.unit * 2.5),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenMargin,
            ),
            child: _MonthlySpendingCard(insights: insights),
          ),
          const SizedBox(height: AppSpacing.unit * 3),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenMargin,
            ),
            child: Text('EXPENSE BREAKDOWN', style: AppTheme.labelLg),
          ),
          const SizedBox(height: AppSpacing.unit * 1.5),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenMargin,
            ),
            child: Column(
              children: insights.categories
                  .map((c) => _CategoryRow(category: c))
                  .toList(),
            ),
          ),
          const SizedBox(height: AppSpacing.unit * 2.5),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenMargin,
            ),
            child: _RemainingBudgetCard(insights: insights),
          ),
        ],
      ),
    );
  }
}

class _MonthlySpendingCard extends StatelessWidget {
  const _MonthlySpendingCard({required this.insights});

  final InsightsData insights;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: AppTheme.glassCard(),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total Monthly Spending', style: AppTheme.bodySm),
              const SizedBox(height: AppSpacing.unit),
              Text(
                AppTheme.formatAmount(insights.totalSpending),
                style: AppTheme.amountLg,
              ),
              const SizedBox(height: AppSpacing.unit),
              Row(
                children: [
                  const Icon(
                    Icons.trending_up_rounded,
                    size: 14,
                    color: AppColors.secondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '+${insights.spendingChangePercent}% vs last cycle',
                    style: AppTheme.bodySm.copyWith(color: AppColors.secondary),
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
                color: AppColors.primary.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.show_chart_rounded,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryRow extends StatelessWidget {
  const _CategoryRow({required this.category});

  final ExpenseCategory category;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.unit * 2),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: AppTheme.squircle(
                  color: category.color.withValues(alpha: 0.15),
                ),
                child: Icon(category.icon, color: category.color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(category.name, style: AppTheme.titleMd),
                    Text(
                      '${category.count} transactions',
                      style: AppTheme.bodySm.copyWith(fontSize: 11),
                    ),
                  ],
                ),
              ),
              Text(
                AppTheme.formatAmount(category.amount),
                style: AppTheme.bodyMd.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.unit),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            child: LinearProgressIndicator(
              value: category.progress,
              minHeight: 3,
              backgroundColor: AppColors.surfaceContainerHigh,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _RemainingBudgetCard extends StatelessWidget {
  const _RemainingBudgetCard({required this.insights});

  final InsightsData insights;

  @override
  Widget build(BuildContext context) {
    final spentPct = (insights.spentPercent * 100).round();
    return Container(
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: AppTheme.glassCard(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Remaining Budget', style: AppTheme.bodySm),
          const SizedBox(height: AppSpacing.unit),
          Text(
            AppTheme.formatAmount(insights.remainingBudget),
            style: AppTheme.amountLg.copyWith(color: AppColors.secondary),
          ),
          const SizedBox(height: AppSpacing.unit * 2),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            child: LinearProgressIndicator(
              value: insights.spentPercent,
              minHeight: 8,
              backgroundColor: AppColors.surfaceContainerHigh,
              color: AppColors.secondary,
            ),
          ),
          const SizedBox(height: AppSpacing.unit * 1.5),
          Text(
            "You've spent $spentPct% of your monthly limit",
            style: AppTheme.bodySm,
          ),
        ],
      ),
    );
  }
}
