import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/account.dart';
import '../models/credit_card.dart';

final accountsProvider = Provider<List<Account>>((ref) {
  return const [
    Account(
      id: 'debit-1',
      name: 'CIB Main Savings',
      type: AccountType.debit,
      balance: 142500,
      subtitle: 'Debit • Primary node',
      icon: Icons.account_balance_outlined,
      isActive: true,
      changePercent: 2.4,
    ),
    Account(
      id: 'cash-1',
      name: 'Daily Cash',
      type: AccountType.cash,
      balance: 3450,
      subtitle: 'Physical Wallet',
      icon: Icons.payments_outlined,
    ),
    Account(
      id: 'credit-1',
      name: 'Titanium Card CIB',
      type: AccountType.credit,
      balance: 45400,
      subtitle: 'Credit • Visa Platinum',
      icon: Icons.credit_card_outlined,
    ),
    Account(
      id: 'ewallet-1',
      name: 'Mobile E-Wallet Vodafone Cash',
      type: AccountType.ewallet,
      balance: 8240.50,
      subtitle: 'E-Wallet • Vodafone',
      icon: Icons.phone_android_outlined,
    ),
  ];
});

final creditCardsProvider = Provider<List<CreditCard>>((ref) {
  return [
    CreditCard(
      accountId: 'credit-1',
      name: 'Titanium Card CIB',
      dueAmount: 12400,
      totalDebt: 45000,
      limit: 150000,
      dueInDays: 4,
      cycleStart: DateTime(2026, 10, 1),
      cycleEnd: DateTime(2026, 10, 31),
    ),
  ];
});

final netPositionProvider = Provider<double>((ref) {
  const netPosition = 34500.00;
  return netPosition;
});

final dashboardStatsProvider = Provider<DashboardStats>((ref) {
  return const DashboardStats(
    income: 15000,
    spent: 8650,
    creditDue: 12400,
  );
});

class DashboardStats {
  const DashboardStats({
    required this.income,
    required this.spent,
    required this.creditDue,
  });

  final double income;
  final double spent;
  final double creditDue;
}
