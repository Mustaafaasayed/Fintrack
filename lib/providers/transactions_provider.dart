import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/transaction.dart';

final transactionsProvider = Provider<List<Transaction>>((ref) {
  return const [
    Transaction(
      id: 'tx-1',
      merchant: 'Carrefour Market',
      category: 'Food & Groceries',
      amount: -450,
      kind: TransactionKind.debit,
      source: 'Auto-logged via SMS',
      timeAgo: 'Just now',
      icon: Icons.shopping_cart_outlined,
    ),
    Transaction(
      id: 'tx-2',
      merchant: 'Salary Deposit',
      category: 'Income',
      amount: 15000,
      kind: TransactionKind.credit,
      source: 'Auto-logged via SMS',
      timeAgo: '2h ago',
      icon: Icons.account_balance_outlined,
    ),
    Transaction(
      id: 'tx-3',
      merchant: 'Vodafone Bill',
      category: 'Utilities',
      amount: -200,
      kind: TransactionKind.debit,
      source: 'Auto-logged via SMS',
      timeAgo: '5h ago',
      icon: Icons.phone_android_outlined,
    ),
    Transaction(
      id: 'tx-4',
      merchant: 'ATM Withdrawal',
      category: 'Cash',
      amount: -1000,
      kind: TransactionKind.debit,
      source: 'Auto-logged via SMS',
      timeAgo: 'Yesterday',
      icon: Icons.atm_outlined,
    ),
    Transaction(
      id: 'tx-5',
      merchant: 'Rental Income',
      category: 'Income',
      amount: 5000,
      kind: TransactionKind.credit,
      source: 'Manual Entry',
      timeAgo: 'May 1',
      icon: Icons.home_outlined,
    ),
  ];
});

final monthlyIncomeProvider = Provider<double>((ref) {
  final txs = ref.watch(transactionsProvider);
  return txs
      .where((t) => t.kind == TransactionKind.credit)
      .fold<double>(0, (s, t) => s + t.amount);
});

final monthlySpentProvider = Provider<double>((ref) {
  final txs = ref.watch(transactionsProvider);
  return txs
      .where((t) => t.kind == TransactionKind.debit)
      .fold<double>(0, (s, t) => s + t.amount.abs());
});
