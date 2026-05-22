import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/account.dart';
import '../providers/accounts_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/account_tile.dart';
import '../widgets/credit_card_expanded.dart';
import '../widgets/fintrack_app_bar.dart';

class AccountsScreen extends ConsumerWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accounts = ref.watch(accountsProvider);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FintrackAppBar(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.screenMargin,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Accounts Overview', style: AppTheme.headlineLg),
                      const SizedBox(height: 8),
                      Text(
                        'Manage your liquid assets and credit facilities',
                        style: AppTheme.bodySm,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppTheme.radiusPill),
                    border: Border.all(color: AppTheme.cyan, width: 1.5),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.add, size: 16, color: AppTheme.cyan),
                      const SizedBox(width: 4),
                      Text(
                        'Add Node',
                        style: AppTheme.bodySm.copyWith(
                          color: AppTheme.cyan,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
              children:
                  accounts.map((a) => AccountTile(account: a, showBalance: false)).toList(),
            ),
          ),
          const SizedBox(height: 8),
          ...accounts.map((account) => _ExpandedCard(account: account)),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _ExpandedCard extends ConsumerWidget {
  const _ExpandedCard({required this.account});

  final Account account;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    switch (account.type) {
      case AccountType.debit:
        return _DebitExpanded(account: account);
      case AccountType.credit:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.screenMargin),
          child: CreditCardExpanded(account: account),
        );
      case AccountType.ewallet:
        return _EwalletExpanded(account: account);
      case AccountType.cash:
        return _CashExpanded(account: account);
    }
  }
}

class _DebitExpanded extends StatelessWidget {
  const _DebitExpanded({required this.account});

  final Account account;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppTheme.screenMargin, 0, AppTheme.screenMargin, 16,
      ),
      child: Container(
        padding: const EdgeInsets.all(AppTheme.cardPadding),
        decoration: AppTheme.glassCard(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('DEBIT ACCOUNT', style: AppTheme.labelCyan),
            const SizedBox(height: 8),
            Text(account.name, style: AppTheme.titleMd),
            const SizedBox(height: 12),
            Text(AppTheme.formatCurrency(account.balance), style: AppTheme.amountLg),
            if (account.changePercent != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.trending_up_rounded,
                      size: 14, color: AppTheme.mint),
                  const SizedBox(width: 4),
                  Text(
                    '+${account.changePercent}% vs last month',
                    style: AppTheme.bodySm.copyWith(color: AppTheme.mint),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: AppTheme.innerCard(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Available Liquidity', style: AppTheme.bodySm),
                  Text(
                    AppTheme.formatCurrency(account.balance),
                    style: AppTheme.titleMd.copyWith(color: AppTheme.mint),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EwalletExpanded extends StatelessWidget {
  const _EwalletExpanded({required this.account});

  final Account account;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppTheme.screenMargin, 0, AppTheme.screenMargin, 16,
      ),
      child: Container(
        padding: const EdgeInsets.all(AppTheme.cardPadding),
        decoration: AppTheme.glassCard(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('E-WALLET', style: AppTheme.labelCyan),
            const SizedBox(height: 8),
            Text(account.name, style: AppTheme.titleMd),
            const SizedBox(height: 12),
            Text(AppTheme.formatCurrency(account.balance), style: AppTheme.amountLg),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: AppTheme.innerCard(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Available Liquidity', style: AppTheme.bodySm),
                  Text(
                    AppTheme.formatCurrency(account.balance),
                    style: AppTheme.titleMd.copyWith(color: AppTheme.mint),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _GhostBtn(label: 'Transfer')),
                const SizedBox(width: 12),
                Expanded(child: _GhostBtn(label: 'Pay Bill')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CashExpanded extends StatelessWidget {
  const _CashExpanded({required this.account});

  final Account account;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppTheme.screenMargin, 0, AppTheme.screenMargin, 16,
      ),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppTheme.cardPadding),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(AppTheme.radiusCard),
              border: Border.all(color: AppTheme.cyan.withValues(alpha: 0.35)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('PHYSICAL CASH', style: AppTheme.labelCyan),
                const SizedBox(height: 8),
                Text(account.name, style: AppTheme.titleMd),
                const SizedBox(height: 12),
                Text(AppTheme.formatCurrency(account.balance), style: AppTheme.amountLg),
                const SizedBox(height: 40),
              ],
            ),
          ),
          Positioned(
            right: 16,
            bottom: 16,
            child: Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: AppTheme.cyan,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add_rounded, color: AppTheme.background),
            ),
          ),
        ],
      ),
    );
  }
}

class _GhostBtn extends StatelessWidget {
  const _GhostBtn({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppTheme.radiusButton),
        border: Border.all(color: AppTheme.outlineVariant),
      ),
      child: Text(label, style: AppTheme.bodyMd.copyWith(fontWeight: FontWeight.w600)),
    );
  }
}
