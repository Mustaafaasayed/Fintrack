import 'package:flutter/material.dart';

import '../models/transaction.dart';
import '../theme/app_theme.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({super.key, required this.transaction});

  final Transaction transaction;

  bool get _isManual => transaction.source.toLowerCase().contains('manual');

  @override
  Widget build(BuildContext context) {
    final amountColor =
        transaction.isDebit ? AppTheme.errorRed : AppTheme.mint;
    final displayAmount = transaction.isDebit
        ? AppTheme.formatCurrency(transaction.amount)
        : AppTheme.formatCurrency(transaction.amount, showSign: true);
    final badge = _isManual ? '✏️ Manual' : '⚡ Auto SMS';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: AppTheme.glassCard(),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: AppTheme.squircle(color: AppTheme.surfaceHigh),
            child: Icon(
              transaction.icon,
              color: AppTheme.onSurfaceVariant,
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
                  badge,
                  style: AppTheme.bodySm.copyWith(
                    fontSize: 10,
                    color: _isManual ? AppTheme.cyan : AppTheme.outline,
                  ),
                ),
                Text(
                  '${transaction.source} • ${transaction.timeAgo}',
                  style: AppTheme.bodySm.copyWith(fontSize: 10),
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
