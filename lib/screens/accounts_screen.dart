import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/account.dart';
import '../models/credit_card.dart';
import '../providers/accounts_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/account_tile.dart';
import '../widgets/app_bar.dart';

class AccountsScreen extends ConsumerWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accounts = ref.watch(accountsProvider);
    final creditCards = ref.watch(creditCardsProvider);

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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Accounts Overview', style: AppTheme.headlineLg),
                      const SizedBox(height: AppSpacing.unit),
                      Text(
                        'Manage your liquid assets and credit facilities',
                        style: AppTheme.bodySm,
                      ),
                    ],
                  ),
                ),
                _AddNodeButton(),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.unit * 3),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenMargin,
            ),
            child: Text('LEDGER NODES', style: AppTheme.labelLg),
          ),
          const SizedBox(height: AppSpacing.unit * 1.5),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenMargin,
            ),
            child: Column(
              children: accounts
                  .map((a) => AccountTile(account: a, compact: false))
                  .toList(),
            ),
          ),
          const SizedBox(height: AppSpacing.unit * 2),
          ...accounts.map((account) {
            switch (account.type) {
              case AccountType.debit:
                return _DebitExpandedCard(account: account);
              case AccountType.credit:
                final card = creditCards.firstWhere(
                  (c) => c.accountId == account.id,
                );
                return _CreditExpandedCard(account: account, card: card);
              case AccountType.ewallet:
                return _EwalletExpandedCard(account: account);
              case AccountType.cash:
                return _CashExpandedCard(account: account);
            }
          }),
        ],
      ),
    );
  }
}

class _AddNodeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.primary, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.add, size: 16, color: AppColors.primary),
          const SizedBox(width: 4),
          Text(
            'Add Node',
            style: AppTheme.bodySm.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _DebitExpandedCard extends StatelessWidget {
  const _DebitExpandedCard({required this.account});

  final Account account;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenMargin,
        0,
        AppSpacing.screenMargin,
        AppSpacing.unit * 2,
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.cardPadding),
        decoration: AppTheme.glassCard(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('DEBIT ACCOUNT', style: AppTheme.labelLg),
            const SizedBox(height: AppSpacing.unit),
            Text(account.name, style: AppTheme.titleMd),
            const SizedBox(height: AppSpacing.unit * 1.5),
            Text(
              AppTheme.formatAmount(account.balance),
              style: AppTheme.amountLg,
            ),
            if (account.changePercent != null) ...[
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
                    '+${account.changePercent}% vs last month',
                    style: AppTheme.bodySm.copyWith(color: AppColors.secondary),
                  ),
                ],
              ),
            ],
            const SizedBox(height: AppSpacing.unit * 2),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: AppTheme.innerCard(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Available Liquidity', style: AppTheme.bodySm),
                  Text(
                    AppTheme.formatAmount(account.balance),
                    style: AppTheme.titleMd.copyWith(color: AppColors.secondary),
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

class _CreditExpandedCard extends StatelessWidget {
  const _CreditExpandedCard({
    required this.account,
    required this.card,
  });

  final Account account;
  final CreditCard card;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenMargin,
        0,
        AppSpacing.screenMargin,
        AppSpacing.unit * 2,
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.cardPadding),
        decoration: AppTheme.glassCard(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('CREDIT CARD', style: AppTheme.labelLg),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.errorDue.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: Text(
                    'DUE IN ${card.dueInDays} DAYS',
                    style: AppTheme.labelMd.copyWith(
                      color: AppColors.errorDue,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.unit),
            Text(account.name, style: AppTheme.titleMd),
            const SizedBox(height: AppSpacing.unit * 2),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Due Amount', style: AppTheme.bodySm),
                      const SizedBox(height: 4),
                      Text(
                        AppTheme.formatAmount(card.dueAmount),
                        style: AppTheme.amountMd.copyWith(
                          color: AppColors.errorDue,
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
                        AppTheme.formatAmount(card.totalDebt),
                        style: AppTheme.amountMd,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.unit * 2),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.pill),
              child: LinearProgressIndicator(
                value: card.utilization,
                minHeight: 6,
                backgroundColor: AppColors.surfaceContainerHigh,
                color: AppColors.errorDue,
              ),
            ),
            const SizedBox(height: AppSpacing.unit),
            Text(
              'Cycle: ${card.cycleLabel} • Limit: ${AppTheme.formatAmount(card.limit)}',
              style: AppTheme.bodySm.copyWith(fontSize: 11),
            ),
            const SizedBox(height: AppSpacing.unit * 2),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: AppTheme.innerCard(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Available Credit', style: AppTheme.bodySm),
                  Text(
                    AppTheme.formatAmount(card.availableCredit),
                    style: AppTheme.titleMd.copyWith(color: AppColors.secondary),
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

class _EwalletExpandedCard extends StatelessWidget {
  const _EwalletExpandedCard({required this.account});

  final Account account;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenMargin,
        0,
        AppSpacing.screenMargin,
        AppSpacing.unit * 2,
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.cardPadding),
        decoration: AppTheme.glassCard(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('E-WALLET', style: AppTheme.labelLg),
            const SizedBox(height: AppSpacing.unit),
            Text(account.name, style: AppTheme.titleMd),
            const SizedBox(height: AppSpacing.unit * 1.5),
            Text(
              AppTheme.formatAmount(account.balance),
              style: AppTheme.amountLg,
            ),
            const SizedBox(height: AppSpacing.unit * 2),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: AppTheme.innerCard(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Available Liquidity', style: AppTheme.bodySm),
                  Text(
                    AppTheme.formatAmount(account.balance),
                    style: AppTheme.titleMd.copyWith(color: AppColors.secondary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.unit * 2),
            Row(
              children: [
                Expanded(child: _GhostButton(label: 'Transfer')),
                const SizedBox(width: AppSpacing.unit * 1.5),
                Expanded(child: _GhostButton(label: 'Pay Bill')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CashExpandedCard extends StatelessWidget {
  const _CashExpandedCard({required this.account});

  final Account account;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenMargin,
        0,
        AppSpacing.screenMargin,
        AppSpacing.unit * 2,
      ),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.cardPadding),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainer,
              borderRadius: BorderRadius.circular(AppRadius.card),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.35),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PHYSICAL CASH',
                  style: AppTheme.labelLg.copyWith(color: AppColors.primary),
                ),
                const SizedBox(height: AppSpacing.unit),
                Text(account.name, style: AppTheme.titleMd),
                const SizedBox(height: AppSpacing.unit * 1.5),
                Text(
                  AppTheme.formatAmount(account.balance),
                  style: AppTheme.amountLg,
                ),
                const SizedBox(height: AppSpacing.unit * 5),
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
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add_rounded,
                color: AppColors.onPrimaryDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GhostButton extends StatelessWidget {
  const _GhostButton({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.button),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Text(
        label,
        style: AppTheme.bodyMd.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
