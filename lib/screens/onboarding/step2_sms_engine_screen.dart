import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_theme.dart';

class Step2SmsEngineScreen extends StatelessWidget {
  const Step2SmsEngineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Column(
          children: [
            _OnboardingHeader(step: 2, progress: 0.66),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppTheme.screenMargin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Technical Automation', style: AppTheme.headlineLg),
                    const SizedBox(height: 8),
                    Text(
                      'Configure your SMS engine to parse financial notifications in real-time',
                      style: AppTheme.bodySm.copyWith(fontSize: 15),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(AppTheme.cardPadding),
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceHigh,
                        borderRadius:
                            BorderRadius.circular(AppTheme.radiusCard),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('AUTOMATION ENGINE', style: AppTheme.labelCyan),
                          const SizedBox(height: 16),
                          Text('RAW INPUT', style: AppTheme.labelCyan.copyWith(
                            color: AppTheme.onSurfaceVariant,
                            fontSize: 10,
                          )),
                          const SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppTheme.surfaceLowest,
                              borderRadius:
                                  BorderRadius.circular(AppTheme.radiusButton),
                              border: Border.all(color: AppTheme.outlineVariant),
                            ),
                            child: Text(
                              'CIB: Your account ending ████ has been debited by EGP 1,500.00 at Amazon Egypt on 12-OCT-2023. Ref: ████',
                              style: AppTheme.bodySm.copyWith(
                                fontFamily: 'monospace',
                                fontSize: 12,
                                color: AppTheme.onSurface,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'OTP strings and secure access links are drop-redacted natively.',
                            style: AppTheme.bodySm.copyWith(
                              fontSize: 11,
                              fontStyle: FontStyle.italic,
                              color: AppTheme.errorRed,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text('STRUCTURED OUTPUT', style: AppTheme.labelCyan),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: AppTheme.glassCard(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: AppTheme.squircle(
                                        color: AppTheme.cyan.withValues(alpha: 0.12),
                                      ),
                                      child: const Icon(
                                        Icons.shopping_cart_outlined,
                                        color: AppTheme.cyan,
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Amazon Egypt / Shopping & E-commerce',
                                            style: AppTheme.titleMd.copyWith(
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            '-EGP 1,500.00 / Oct 12, 14:20',
                                            style: AppTheme.bodySm,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Source: CIB Bank • Method: Debit Card',
                                  style: AppTheme.bodySm.copyWith(fontSize: 11),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Confidence: 99.8%',
                                  style: AppTheme.bodySm.copyWith(
                                    color: AppTheme.mint,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppTheme.screenMargin),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => context.go('/onboarding/1'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.onSurfaceVariant,
                        side: const BorderSide(color: AppTheme.outlineVariant),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppTheme.radiusButton),
                        ),
                      ),
                      child: const Text('Previous'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () => context.go('/onboarding/3'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.cyan,
                        foregroundColor: AppTheme.background,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppTheme.radiusButton),
                        ),
                      ),
                      child: Text(
                        'Deploy Engine →',
                        style: AppTheme.titleMd.copyWith(
                          color: AppTheme.background,
                          fontSize: 14,
                        ),
                      ),
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

class _OnboardingHeader extends StatelessWidget {
  const _OnboardingHeader({required this.step, required this.progress});

  final int step;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      child: Row(
        children: [
          Text('FinTrack', style: AppTheme.headlineMd.copyWith(fontSize: 18)),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Step $step of 3', style: AppTheme.bodySm),
              const SizedBox(height: 6),
              SizedBox(
                width: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppTheme.radiusPill),
                  child: LinearProgressIndicator(
                    value: progress,
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
    );
  }
}
