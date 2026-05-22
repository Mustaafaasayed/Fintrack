import 'package:flutter/material.dart';

import '../models/account.dart';
import '../theme/app_theme.dart';

class AccountTile extends StatelessWidget {
  const AccountTile({
    super.key,
    required this.account,
    this.showBalance = true,
    this.onTap,
  });

  final Account account;
  final bool showBalance;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: AppTheme.glassCard(isActive: account.isActive),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: AppTheme.squircle(
                color: AppTheme.cyan.withValues(alpha: 0.12),
              ),
              child: Icon(account.icon, color: AppTheme.cyan, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(account.name, style: AppTheme.titleMd),
                  const SizedBox(height: 2),
                  Text(account.subtitle, style: AppTheme.bodySm),
                ],
              ),
            ),
            if (showBalance)
              Text(
                AppTheme.formatCurrency(account.balance),
                style: AppTheme.bodyMd.copyWith(fontWeight: FontWeight.w600),
              ),
          ],
        ),
      ),
    );
  }
}
