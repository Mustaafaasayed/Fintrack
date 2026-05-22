import 'package:flutter/material.dart';

import '../models/transaction.dart';
import '../theme/app_theme.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({super.key, required this.transaction});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    final amountColor = transaction.isDebit
        ? AppColors.errorDue
        : AppColors.secondary;
    final displayAmount = transaction.isDebit
        ? AppTheme.formatAmount(transaction.amount)
        : AppTheme.formatAmount(transaction.amount, showSign: true);

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.unit * 1.5),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: AppTheme.glassCard(),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: AppTheme.squircle(color: AppColors.surfaceContainerHigh),
            child: Icon(
              transaction.icon,
              color: AppColors.onSurfaceVariant,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(transaction.merchant, style: AppTheme.titleMd),
                const SizedBox(height: 2),
                Text(
                  '${transaction.source} • ${transaction.timeAgo}',
                  style: AppTheme.bodySm.copyWith(fontSize: 11),
                ),
              ],
            ),
          ),
          Text(
            displayAmount,
            style: AppTheme.bodyMd.copyWith(
              fontWeight: FontWeight.w600,
              color: amountColor,
            ),
          ),
        ],
      ),
    );
  }
}
