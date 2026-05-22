import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/fintrack_app_bar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _biometricLock = true;
  int _notificationMode = 0;

  Future<void> _confirmPurge() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusModal),
        ),
        title: Text('Purge All Data?', style: AppTheme.titleMd),
        content: Text(
          'This will permanently wipe all local financial records. This cannot be undone.',
          style: AppTheme.bodySm,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel', style: AppTheme.bodyMd.copyWith(color: AppTheme.outline)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Purge', style: AppTheme.bodyMd.copyWith(color: AppTheme.dueBadge)),
          ),
        ],
      ),
    );
    if (confirmed == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Purge cancelled — demo mode',
            style: AppTheme.bodyMd.copyWith(color: AppTheme.background),
          ),
          backgroundColor: AppTheme.dueBadge,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FintrackAppBar(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.screenMargin,
            ),
            child: Row(
              children: [
                Text('System Controls', style: AppTheme.headlineLg),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.mint.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(AppTheme.radiusPill),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: AppTheme.mint,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'ENCRYPTED',
                        style: AppTheme.labelCyan.copyWith(
                          color: AppTheme.mint,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.screenMargin,
            ),
            child: Text('On-Device Sovereignty', style: AppTheme.headlineMd),
          ),
          const SizedBox(height: 20),
          _SettingsTile(
            icon: Icons.fingerprint_outlined,
            title: 'Biometric Lock',
            trailing: Switch(
              value: _biometricLock,
              onChanged: (v) => setState(() => _biometricLock = v),
              activeThumbColor: AppTheme.cyan,
              activeTrackColor: AppTheme.cyan.withValues(alpha: 0.4),
            ),
          ),
          _SettingsTile(
            icon: Icons.enhanced_encryption_outlined,
            title: 'Database Encryption',
            trailing: Text(
              'ACTIVE',
              style: AppTheme.labelCyan.copyWith(fontSize: 11),
            ),
          ),
          _SettingsTile(
            icon: Icons.sms_outlined,
            title: 'SMS Parsing Rules',
            trailing: const Icon(Icons.chevron_right_rounded,
                color: AppTheme.outline, size: 20),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppTheme.screenMargin, 8, AppTheme.screenMargin, 8,
            ),
            child: Container(
              padding: const EdgeInsets.all(AppTheme.cardPadding),
              decoration: AppTheme.glassCard(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Notification Matrix', style: AppTheme.titleMd),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _NotifChip(
                        label: 'Alerts',
                        selected: _notificationMode == 0,
                        onTap: () => setState(() => _notificationMode = 0),
                      ),
                      const SizedBox(width: 8),
                      _NotifChip(
                        label: 'Muted',
                        selected: _notificationMode == 1,
                        onTap: () => setState(() => _notificationMode = 1),
                      ),
                      const SizedBox(width: 8),
                      _NotifChip(
                        label: 'Weekly',
                        selected: _notificationMode == 2,
                        onTap: () => setState(() => _notificationMode = 2),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.screenMargin,
            ),
            child: Text('NUCLEAR PROTOCOL', style: AppTheme.labelCyan.copyWith(
              color: AppTheme.dueBadge,
            )),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.screenMargin,
            ),
            child: Container(
              padding: const EdgeInsets.all(AppTheme.cardPadding),
              decoration: AppTheme.glassCard(isDue: true),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Immediately wipe all local database records and reset the on-device secure enclave.',
                    style: AppTheme.bodySm.copyWith(
                      color: AppTheme.errorRed,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: _confirmPurge,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.dueBadge,
                      side: const BorderSide(color: AppTheme.dueBadge, width: 1.5),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppTheme.radiusButton),
                      ),
                    ),
                    child: const Text('Purge All Financial Data'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.trailing,
  });

  final IconData icon;
  final String title;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppTheme.screenMargin, 0, AppTheme.screenMargin, 12,
      ),
      child: Container(
        decoration: AppTheme.glassCard(),
        child: ListTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: AppTheme.squircle(
              color: AppTheme.cyan.withValues(alpha: 0.12),
            ),
            child: Icon(icon, color: AppTheme.cyan, size: 20),
          ),
          title: Text(title, style: AppTheme.titleMd),
          trailing: trailing,
        ),
      ),
    );
  }
}

class _NotifChip extends StatelessWidget {
  const _NotifChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected
                ? AppTheme.cyan.withValues(alpha: 0.15)
                : AppTheme.surfaceHigh,
            borderRadius: BorderRadius.circular(AppTheme.radiusButton),
            border: Border.all(
              color: selected ? AppTheme.cyan : AppTheme.outlineVariant,
            ),
          ),
          child: Text(
            label,
            style: AppTheme.bodySm.copyWith(
              color: selected ? AppTheme.cyan : AppTheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
