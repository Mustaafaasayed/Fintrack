import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/accounts_provider.dart';
import '../theme/app_theme.dart';

class NetPositionCard extends ConsumerWidget {
  const NetPositionCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final netPosition = ref.watch(netPositionProvider);
    final stats = ref.watch(dashboardStatsProvider);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'NET POSITION',
            style: AppTheme.labelLg.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.unit),
          Text(
            AppTheme.formatAmount(netPosition),
            style: AppTheme.amountHero,
          ),
          const SizedBox(height: AppSpacing.unit * 2.5),
          Row(
            children: [
              _StatChip(
                label: 'Income',
                value: AppTheme.formatAmount(stats.income, showSign: true),
                icon: Icons.arrow_upward_rounded,
                color: AppColors.secondary,
              ),
              const SizedBox(width: AppSpacing.unit * 2),
              _StatChip(
                label: 'Spent',
                value: AppTheme.formatAmount(-stats.spent),
                icon: Icons.arrow_downward_rounded,
                color: AppColors.errorDue,
              ),
              const SizedBox(width: AppSpacing.unit * 2),
              _StatChip(
                label: 'Credit Due',
                value: AppTheme.formatAmount(stats.creditDue),
                icon: Icons.warning_amber_rounded,
                color: AppColors.errorDue,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({
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
              Text(label, style: AppTheme.labelMd),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTheme.bodySm.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
