import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/app_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const _items = [
    (Icons.sms_outlined, 'SMS Auto-Logging', 'Parse bank SMS automatically'),
    (Icons.notifications_outlined, 'Notifications', 'Due dates & spending alerts'),
    (Icons.lock_outline, 'Security', 'Biometric lock & PIN'),
    (Icons.palette_outlined, 'Appearance', 'Dark mode (MVP only)'),
    (Icons.language_outlined, 'Language', 'English • العربية'),
    (Icons.help_outline, 'Help & Support', 'FAQ and contact'),
  ];

  @override
  Widget build(BuildContext context) {
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
            child: Text('Settings', style: AppTheme.headlineLg),
          ),
          const SizedBox(height: AppSpacing.unit),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenMargin,
            ),
            child: Text(
              'Configure your FinTrack experience',
              style: AppTheme.bodySm,
            ),
          ),
          const SizedBox(height: AppSpacing.unit * 3),
          ..._items.map(
            (item) => Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenMargin,
                0,
                AppSpacing.screenMargin,
                AppSpacing.unit * 1.5,
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: AppTheme.glassCard(),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: AppTheme.squircle(
                        color: AppColors.primary.withValues(alpha: 0.12),
                      ),
                      child: Icon(item.$1, color: AppColors.primary, size: 20),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.$2, style: AppTheme.titleMd),
                          const SizedBox(height: 2),
                          Text(item.$3, style: AppTheme.bodySm.copyWith(fontSize: 11)),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.outline,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.unit * 2),
          Center(
            child: Text(
              'FinTrack v1.0.0 • MVP',
              style: AppTheme.bodySm.copyWith(fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}
