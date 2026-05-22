import 'package:flutter/material.dart';

import '../models/account.dart';
import '../theme/app_theme.dart';

class AccountTile extends StatelessWidget {
  const AccountTile({
    super.key,
    required this.account,
    this.onTap,
    this.compact = true,
  });

  final Account account;
  final VoidCallback? onTap;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.unit * 1.5),
        padding: EdgeInsets.all(compact ? 16 : AppSpacing.cardPadding),
        decoration: AppTheme.glassCard(active: account.isActive),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: AppTheme.squircle(
                color: AppColors.primary.withValues(alpha: 0.12),
              ),
              child: Icon(account.icon, color: AppColors.primary, size: 22),
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
            if (compact)
              Text(
                AppTheme.formatAmount(account.balance),
                style: AppTheme.bodyMd.copyWith(fontWeight: FontWeight.w600),
              ),
          ],
        ),
      ),
    );
  }
}
