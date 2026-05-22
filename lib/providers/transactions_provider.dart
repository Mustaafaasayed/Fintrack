import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/transaction.dart';

final transactionsProvider = Provider<List<Transaction>>((ref) {
  return const [
    Transaction(
      id: 'tx-1',
      merchant: 'Carrefour Market',
      category: 'Food',
      amount: -450,
      kind: TransactionKind.debit,
      source: 'Auto-logged via SMS',
      timeAgo: 'just now',
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
      icon: Icons.account_balance_wallet_outlined,
    ),
    Transaction(
      id: 'tx-3',
      merchant: 'Vodafone Bill',
      category: 'Utilities',
      amount: -200,
      kind: TransactionKind.debit,
      source: 'Auto-logged via SMS',
      timeAgo: '5h ago',
      icon: Icons.receipt_long_outlined,
    ),
    Transaction(
      id: 'tx-4',
      merchant: 'ATM Withdrawal',
      category: 'Cash',
      amount: -1000,
      kind: TransactionKind.debit,
      source: 'Auto-logged via SMS',
      timeAgo: 'yesterday',
      icon: Icons.atm_outlined,
    ),
  ];
});

final insightsProvider = Provider<InsightsData>((ref) {
  return const InsightsData(
    totalSpending: 18450.75,
    spendingChangePercent: 8.2,
    remainingBudget: 6550.25,
    budgetLimit: 25000,
    cycleLabel: 'Oct 1 - Oct 31',
    categories: [
      ExpenseCategory(
        name: 'Food & Groceries',
        count: 24,
        amount: 4850,
        progress: 0.72,
        icon: Icons.restaurant_outlined,
        color: Color(0xFF00DBE7),
      ),
      ExpenseCategory(
        name: 'Utilities',
        count: 6,
        amount: 2100,
        progress: 0.45,
        icon: Icons.bolt_outlined,
        color: Color(0xFF00DBE7),
      ),
      ExpenseCategory(
        name: 'Transport',
        count: 18,
        amount: 3200,
        progress: 0.58,
        icon: Icons.directions_car_outlined,
        color: Color(0xFFA78BFA),
      ),
      ExpenseCategory(
        name: 'Shopping',
        count: 12,
        amount: 5600,
        progress: 0.81,
        icon: Icons.shopping_bag_outlined,
        color: Color(0xFF00DBE7),
      ),
      ExpenseCategory(
        name: 'Medical',
        count: 3,
        amount: 2700.75,
        progress: 0.35,
        icon: Icons.medical_services_outlined,
        color: Color(0xFFFFAB91),
      ),
    ],
  );
});

class InsightsData {
  const InsightsData({
    required this.totalSpending,
    required this.spendingChangePercent,
    required this.remainingBudget,
    required this.budgetLimit,
    required this.cycleLabel,
    required this.categories,
  });

  final double totalSpending;
  final double spendingChangePercent;
  final double remainingBudget;
  final double budgetLimit;
  final String cycleLabel;
  final List<ExpenseCategory> categories;

  double get spentPercent =>
      ((budgetLimit - remainingBudget) / budgetLimit).clamp(0.0, 1.0);
}

class ExpenseCategory {
  const ExpenseCategory({
    required this.name,
    required this.count,
    required this.amount,
    required this.progress,
    required this.icon,
    required this.color,
  });

  final String name;
  final int count;
  final double amount;
  final double progress;
  final IconData icon;
  final Color color;
}
