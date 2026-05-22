import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/accounts_provider.dart';
import '../providers/credit_card_provider.dart';
import '../providers/transactions_provider.dart';
import '../theme/app_theme.dart';

class NetPositionCard extends ConsumerWidget {
  const NetPositionCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final netPosition = ref.watch(netPositionProvider);
    final income = ref.watch(monthlyIncomeProvider);
    final spent = ref.watch(monthlySpentProvider);
    final credit = ref.watch(creditCardProvider);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppTheme.cardPadding),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusCard),
        border: Border.all(color: AppTheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('NET POSITION', style: AppTheme.labelCyan),
          const SizedBox(height: 8),
          Text(
            AppTheme.formatCurrency(netPosition),
            style: AppTheme.amountHero,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _Stat(
                label: 'Total Income',
                value: AppTheme.formatCurrency(income, showSign: true),
                icon: Icons.arrow_upward_rounded,
                color: AppTheme.mint,
              ),
              const SizedBox(width: 16),
              _Stat(
                label: 'Total Spent',
                value: AppTheme.formatCurrency(-spent),
                icon: Icons.arrow_downward_rounded,
                color: AppTheme.errorRed,
              ),
              const SizedBox(width: 16),
              _Stat(
                label: 'Credit Due',
                value: AppTheme.formatCurrency(credit.dueAmount),
                icon: Icons.warning_amber_rounded,
                color: AppTheme.errorRed,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 12, color: color),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  label,
                  style: AppTheme.bodySm.copyWith(fontSize: 10),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTheme.bodySm.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
