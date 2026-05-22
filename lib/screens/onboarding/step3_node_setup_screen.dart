import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/onboarding_provider.dart';
import '../../theme/app_theme.dart';

class Step3NodeSetupScreen extends ConsumerStatefulWidget {
  const Step3NodeSetupScreen({super.key});

  @override
  ConsumerState<Step3NodeSetupScreen> createState() =>
      _Step3NodeSetupScreenState();
}

class _Step3NodeSetupScreenState extends ConsumerState<Step3NodeSetupScreen> {
  final Set<String> _selected = {'credit'};
  final _institutionCtrl = TextEditingController(text: 'CIB');
  final _signatureCtrl = TextEditingController(text: '1029');
  final _balanceCtrl = TextEditingController(text: '45000');

  static const _nodes = [
    _NodeOption('debit', 'Debit Account', Icons.account_balance_outlined),
    _NodeOption('credit', 'Credit Card', Icons.credit_card_outlined),
    _NodeOption('ewallet', 'Mobile E-Wallet', Icons.phone_android_outlined),
    _NodeOption('cash', 'Physical Cash', Icons.payments_outlined),
  ];

  @override
  void dispose() {
    _institutionCtrl.dispose();
    _signatureCtrl.dispose();
    _balanceCtrl.dispose();
    super.dispose();
  }

  void _toggleNode(String id) {
    setState(() {
      if (_selected.contains(id)) {
        _selected.remove(id);
      } else {
        _selected.add(id);
      }
    });
  }

  void _completeSetup() {
    ref.read(hasCompletedOnboardingProvider.notifier).complete();
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: Row(
                children: [
                  Text('FinTrack', style: AppTheme.headlineMd.copyWith(fontSize: 18)),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Step 3 of 3', style: AppTheme.bodySm),
                      const SizedBox(height: 6),
                      SizedBox(
                        width: 100,
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(AppTheme.radiusPill),
                          child: const LinearProgressIndicator(
                            value: 1,
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
                    Text('Step 3 of 3: Asset Activation', style: AppTheme.headlineLg),
                    const SizedBox(height: 24),
                    Text('Select Liquidity Nodes', style: AppTheme.labelCyan),
                    const SizedBox(height: 12),
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 1.4,
                      children: _nodes.map((node) {
                        final selected = _selected.contains(node.id);
                        return GestureDetector(
                          onTap: () => _toggleNode(node.id),
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: AppTheme.glassCard(isActive: selected),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(node.icon,
                                        color: AppTheme.cyan, size: 22),
                                    const Spacer(),
                                    if (selected)
                                      const Icon(
                                        Icons.check_circle,
                                        color: AppTheme.cyan,
                                        size: 18,
                                      ),
                                  ],
                                ),
                                const Spacer(),
                                Text(node.label,
                                    style: AppTheme.titleMd.copyWith(fontSize: 13)),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                    Text('NODE CONFIGURATION', style: AppTheme.labelCyan),
                    const SizedBox(height: 12),
                    _Field(
                      label: 'INSTITUTION IDENTIFIER',
                      controller: _institutionCtrl,
                      hint: 'CIB',
                    ),
                    const SizedBox(height: 12),
                    _Field(
                      label: 'NODE SIGNATURE (LAST 4)',
                      controller: _signatureCtrl,
                      hint: '1029',
                    ),
                    const SizedBox(height: 12),
                    _Field(
                      label: 'INITIAL CALIBRATION (BALANCE)',
                      controller: _balanceCtrl,
                      hint: '45000',
                      prefix: 'EGP ',
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceLow,
                        borderRadius:
                            BorderRadius.circular(AppTheme.radiusCard),
                      ),
                      child: Text(
                        'Node credentials are encrypted with AES-256 via Android Keystore before persistence.',
                        style: AppTheme.bodySm.copyWith(fontSize: 11),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppTheme.screenMargin),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _completeSetup,
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
                    'Complete Setup & Enter Hub →',
                    style: AppTheme.titleMd.copyWith(
                      color: AppTheme.background,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NodeOption {
  const _NodeOption(this.id, this.label, this.icon);
  final String id;
  final String label;
  final IconData icon;
}

class _Field extends StatelessWidget {
  const _Field({
    required this.label,
    required this.controller,
    required this.hint,
    this.prefix,
  });

  final String label;
  final TextEditingController controller;
  final String hint;
  final String? prefix;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTheme.labelCyan.copyWith(fontSize: 10)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          style: AppTheme.bodyMd,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTheme.bodySm,
            prefixText: prefix,
            prefixStyle: AppTheme.bodyMd.copyWith(color: AppTheme.cyan),
            filled: true,
            fillColor: AppTheme.surfaceHigh,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusButton),
              borderSide: const BorderSide(color: AppTheme.outlineVariant),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusButton),
              borderSide: const BorderSide(color: AppTheme.outlineVariant),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          ),
        ),
      ],
    );
  }
}
