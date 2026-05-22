import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/account.dart';

class AccountsNotifier extends Notifier<List<Account>> {
  @override
  List<Account> build() => _initialAccounts;

  double get netPosition =>
      state.fold<double>(0, (sum, account) => sum + account.balance);
}

final accountsProvider =
    NotifierProvider<AccountsNotifier, List<Account>>(AccountsNotifier.new);

final netPositionProvider = Provider<double>((ref) {
  return ref.watch(accountsProvider.notifier).netPosition;
});

const _initialAccounts = [
  Account(
    id: 'cib_debit',
    name: 'CIB Main Savings',
    type: AccountType.debit,
    balance: 142500,
    subtitle: 'HBSC • ...8842',
    icon: Icons.account_balance_outlined,
    isActive: true,
    changePercent: 2.4,
  ),
  Account(
    id: 'cash',
    name: 'Daily Cash',
    type: AccountType.cash,
    balance: 3450,
    subtitle: 'Physical Wallet',
    icon: Icons.payments_outlined,
  ),
  Account(
    id: 'cib_credit',
    name: 'Titanium Card',
    type: AccountType.credit,
    balance: -45000,
    subtitle: 'CIB • ...1029',
    icon: Icons.credit_card_outlined,
  ),
  Account(
    id: 'vf_ewallet',
    name: 'Mobile E-Wallet',
    type: AccountType.ewallet,
    balance: 8240.5,
    subtitle: 'Vodafone Cash',
    icon: Icons.phone_android_outlined,
  ),
];
