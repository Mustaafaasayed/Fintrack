import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/account.dart';
import '../providers/credit_card_provider.dart';
import '../theme/app_theme.dart';

class CreditCardExpanded extends ConsumerWidget {
  const CreditCardExpanded({super.key, required this.account});

  final Account account;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final card = ref.watch(creditCardProvider);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(AppTheme.cardPadding),
      decoration: AppTheme.glassCard(isDue: card.isDueSoon),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('CREDIT CARD', style: AppTheme.labelCyan),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.dueBadge.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppTheme.radiusPill),
                ),
                child: Text(
                  'DUE IN ${card.dueInDays} DAYS',
                  style: AppTheme.labelCyan.copyWith(
                    color: AppTheme.dueBadge,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(account.name, style: AppTheme.titleMd),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Due Amount', style: AppTheme.bodySm),
                    const SizedBox(height: 4),
                    Text(
                      AppTheme.formatCurrency(card.dueAmount),
                      style: AppTheme.amountLg.copyWith(
                        fontSize: 20,
                        color: AppTheme.errorRed,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total Debt', style: AppTheme.bodySm),
                    const SizedBox(height: 4),
                    Text(
                      AppTheme.formatCurrency(card.totalDebt),
                      style: AppTheme.amountLg.copyWith(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppTheme.radiusPill),
            child: LinearProgressIndicator(
              value: card.utilization,
              minHeight: 6,
              backgroundColor: AppTheme.surfaceHigh,
              color: AppTheme.errorRed,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Cycle: ${card.cycleLabel} • Limit: ${AppTheme.formatCurrency(card.limit)}',
            style: AppTheme.bodySm.copyWith(fontSize: 11),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: AppTheme.innerCard(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Available Credit', style: AppTheme.bodySm),
                Text(
                  AppTheme.formatCurrency(card.availableCredit),
                  style: AppTheme.titleMd.copyWith(color: AppTheme.mint),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
