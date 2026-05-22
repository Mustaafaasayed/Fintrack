import 'package:flutter/material.dart';

enum AccountType { debit, credit, ewallet, cash }

class Account {
  const Account({
    required this.id,
    required this.name,
    required this.type,
    required this.balance,
    required this.subtitle,
    required this.icon,
    this.isActive = false,
    this.changePercent,
  });

  final String id;
  final String name;
  final AccountType type;
  final double balance;
  final String subtitle;
  final IconData icon;
  final bool isActive;
  final double? changePercent;

  String get typeLabel {
    switch (type) {
      case AccountType.debit:
        return 'Debit';
      case AccountType.credit:
        return 'Credit Card';
      case AccountType.ewallet:
        return 'E-Wallet';
      case AccountType.cash:
        return 'Physical Cash';
    }
  }
}
