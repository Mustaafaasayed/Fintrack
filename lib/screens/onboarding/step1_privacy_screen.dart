import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_theme.dart';
class Step1PrivacyScreen extends StatelessWidget {
  const Step1PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: Row(
                children: [
                  const _LogoOnly(),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Step 1 of 3', style: AppTheme.bodySm),
                      const SizedBox(height: 6),
                      SizedBox(
                        width: 100,
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(AppTheme.radiusPill),
                          child: LinearProgressIndicator(
                            value: 0.33,
                            minHeight: 3,
                            backgroundColor: AppTheme.surfaceHigh,
                            color: AppTheme.cyan,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppTheme.screenMargin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'On-Device Sovereignty',
                      style: AppTheme.headlineLg,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your financial data never leaves this device',
                      style: AppTheme.bodySm.copyWith(fontSize: 15),
                    ),
                    const SizedBox(height: 32),
                    const _FeatureRow(
                      icon: Icons.shield_outlined,
                      title: 'Privacy Vault',
                      subtitle:
                          'All parsing happens locally. Zero cloud transmission.',
                    ),
                    const _FeatureRow(
                      icon: Icons.lock_outline,
                      title: 'AES-256 Encryption',
                      subtitle:
                          'SQLCipher-grade database encryption via Android Keystore',
                    ),
                    const _FeatureRow(
                      icon: Icons.memory_outlined,
                      title: 'OTP Redaction',
                      subtitle:
                          'Sensitive strings are dropped before storage',
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppTheme.screenMargin),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () => context.go('/onboarding/2'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.cyan,
                        foregroundColor: AppTheme.background,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppTheme.radiusButton),
                        ),
                      ),
                      child: Text(
                        'Continue →',
                        style: AppTheme.titleMd.copyWith(
                          color: AppTheme.background,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'SECURED BY FINTRACK PROTOCOL V2.4',
                    textAlign: TextAlign.center,
                    style: AppTheme.bodySm.copyWith(
                      fontSize: 10,
                      color: AppTheme.outline,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LogoOnly extends StatelessWidget {
  const _LogoOnly();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppTheme.surfaceHigh,
            borderRadius: BorderRadius.circular(AppTheme.radiusButton),
            border: Border.all(color: AppTheme.cyan.withValues(alpha: 0.4)),
          ),
          alignment: Alignment.center,
          child: Text(
            'F>',
            style: AppTheme.titleMd.copyWith(color: AppTheme.cyan, fontSize: 14),
          ),
        ),
        const SizedBox(width: 10),
        Text('FinTrack', style: AppTheme.headlineMd.copyWith(fontSize: 18)),
      ],
    );
  }
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: AppTheme.squircle(
              color: AppTheme.cyan.withValues(alpha: 0.12),
            ),
            child: Icon(icon, color: AppTheme.cyan, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTheme.titleMd),
                const SizedBox(height: 4),
                Text(subtitle, style: AppTheme.bodySm),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
