import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/accounts_provider.dart';
import '../providers/transactions_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/account_tile.dart';
import '../widgets/app_bar.dart';
import '../widgets/net_position_card.dart';
import '../widgets/transaction_tile.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accounts = ref.watch(accountsProvider);
    final transactions = ref.watch(transactionsProvider);

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
            child: Text(
              '${_greeting()}, Ahmed 👋',
              style: AppTheme.headlineLg,
            ),
          ),
          const SizedBox(height: AppSpacing.unit * 2.5),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: NetPositionCard(),
          ),
          const SizedBox(height: AppSpacing.unit * 3),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenMargin,
            ),
            child: Text(
              'LEDGER NODES',
              style: AppTheme.labelLg,
            ),
          ),
          const SizedBox(height: AppSpacing.unit * 1.5),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenMargin,
            ),
            child: Column(
              children: accounts
                  .map((a) => AccountTile(account: a))
                  .toList(),
            ),
          ),
          const SizedBox(height: AppSpacing.unit * 2),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenMargin,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'RECENT TRANSACTIONS',
                  style: AppTheme.labelLg,
                ),
                Text(
                  'View All',
                  style: AppTheme.bodySm.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.unit * 1.5),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenMargin,
            ),
            child: Column(
              children: transactions
                  .map((t) => TransactionTile(transaction: t))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
