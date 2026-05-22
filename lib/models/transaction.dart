import 'package:flutter/material.dart';

enum TransactionKind { debit, credit }

class Transaction {
  const Transaction({
    required this.id,
    required this.merchant,
    required this.category,
    required this.amount,
    required this.kind,
    required this.source,
    required this.timeAgo,
    required this.icon,
  });

  final String id;
  final String merchant;
  final String category;
  final double amount;
  final TransactionKind kind;
  final String source;
  final String timeAgo;
  final IconData icon;

  bool get isDebit => kind == TransactionKind.debit;
}
