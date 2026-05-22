import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/accounts_provider.dart';
import '../providers/transactions_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/account_tile.dart';
import '../widgets/fintrack_app_bar.dart';
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
    final recent = transactions.take(4).toList();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FintrackAppBar(showAvatar: true),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.screenMargin,
            ),
            child: Text(
              '${_greeting()}, Ahmed 👋',
              style: AppTheme.headlineLg,
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppTheme.screenMargin),
            child: NetPositionCard(),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.screenMargin,
            ),
            child: Text('LEDGER NODES', style: AppTheme.labelCyan),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.screenMargin,
            ),
            child: Column(
              children: accounts.map((a) => AccountTile(account: a)).toList(),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.screenMargin,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('RECENT TRANSACTIONS', style: AppTheme.labelCyan),
                Text(
                  'View All',
                  style: AppTheme.bodySm.copyWith(
                    color: AppTheme.cyan,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.screenMargin,
            ),
            child: Column(
              children:
                  recent.map((t) => TransactionTile(transaction: t)).toList(),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
