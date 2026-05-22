import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/accounts_provider.dart';
import '../theme/app_theme.dart';

class QuickLogScreen extends ConsumerStatefulWidget {
  const QuickLogScreen({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const QuickLogScreen(),
    );
  }

  @override
  ConsumerState<QuickLogScreen> createState() => _QuickLogScreenState();
}

class _QuickLogScreenState extends ConsumerState<QuickLogScreen> {
  String _amount = '0';
  int _selectedSource = 0;
  int? _selectedCategory;
  final _noteCtrl = TextEditingController();

  static const _categories = [
    (Icons.restaurant_outlined, 'Food'),
    (Icons.directions_car_outlined, 'Transport'),
    (Icons.shopping_bag_outlined, 'Shopping'),
    (Icons.receipt_long_outlined, 'Bills'),
    (Icons.more_horiz_rounded, 'Other'),
  ];

  @override
  void dispose() {
    _noteCtrl.dispose();
    super.dispose();
  }

  void _onKey(String key) {
    setState(() {
      if (key == 'del') {
        _amount = _amount.length > 1
            ? _amount.substring(0, _amount.length - 1)
            : '0';
      } else if (key == '.') {
        if (!_amount.contains('.')) _amount = '$_amount.';
      } else {
        _amount = _amount == '0' ? key : '$_amount$key';
      }
    });
  }

  void _logTransaction() {
    final value = double.tryParse(_amount) ?? 0;
    debugPrint('Quick-Log: EGP $value');
    final messenger = ScaffoldMessenger.of(context);
    Navigator.pop(context);
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          'Transaction logged!',
          style: AppTheme.bodyMd.copyWith(color: AppTheme.background),
        ),
        backgroundColor: AppTheme.cyan,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final accounts = ref.watch(accountsProvider);
    final displayAmount =
        AppTheme.formatCurrency(double.tryParse(_amount) ?? 0);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Container(
        margin: const EdgeInsets.only(top: 40),
        decoration: const BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppTheme.radiusModal),
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppTheme.screenMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppTheme.outlineVariant,
                      borderRadius:
                          BorderRadius.circular(AppTheme.radiusPill),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text('QUICK ENTRY',
                    style: AppTheme.labelCyan, textAlign: TextAlign.center),
                const SizedBox(height: 16),
                Text(displayAmount,
                    style: AppTheme.amountQuickLog,
                    textAlign: TextAlign.center),
                const SizedBox(height: 20),
                _Numpad(onKey: _onKey),
                const SizedBox(height: 24),
                Text('SOURCE ACCOUNT', style: AppTheme.labelCyan),
                const SizedBox(height: 12),
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: accounts.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final selected = _selectedSource == index;
                      final account = accounts[index];
                      return GestureDetector(
                        onTap: () => setState(() => _selectedSource = index),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: selected
                                ? AppTheme.cyan.withValues(alpha: 0.15)
                                : AppTheme.surfaceHigh,
                            borderRadius:
                                BorderRadius.circular(AppTheme.radiusPill),
                            border: Border.all(
                              color: selected
                                  ? AppTheme.cyan
                                  : AppTheme.outlineVariant,
                            ),
                          ),
                          child: Text(
                            account.name.split(' ').first,
                            style: AppTheme.bodyMd.copyWith(
                              color: selected
                                  ? AppTheme.cyan
                                  : AppTheme.onSurfaceVariant,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(_categories.length, (index) {
                    final (icon, label) = _categories[index];
                    final selected = _selectedCategory == index;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedCategory = index),
                      child: Column(
                        children: [
                          Container(
                            width: 52,
                            height: 52,
                            decoration: AppTheme.squircle(
                              color: selected
                                  ? AppTheme.cyan.withValues(alpha: 0.15)
                                  : AppTheme.surfaceHigh,
                            ),
                            child: Icon(
                              icon,
                              color: selected
                                  ? AppTheme.cyan
                                  : AppTheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(label,
                              style: AppTheme.bodySm.copyWith(fontSize: 11)),
                        ],
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _noteCtrl,
                  style: AppTheme.bodyMd,
                  decoration: InputDecoration(
                    hintText: 'Add a note...',
                    hintStyle: AppTheme.bodySm,
                    filled: true,
                    fillColor: AppTheme.surfaceHigh,
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(AppTheme.radiusButton),
                      borderSide:
                          const BorderSide(color: AppTheme.outlineVariant),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(AppTheme.radiusButton),
                      borderSide:
                          const BorderSide(color: AppTheme.outlineVariant),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _logTransaction,
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
                      'Log Transaction',
                      style: AppTheme.titleMd.copyWith(
                        color: AppTheme.background,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Numpad extends StatelessWidget {
  const _Numpad({required this.onKey});

  final void Function(String key) onKey;

  static const _keys = [
    ['1', '2', '3'],
    ['4', '5', '6'],
    ['7', '8', '9'],
    ['.', '0', 'del'],
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _keys.map((row) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: row.map((key) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: GestureDetector(
                    onTap: () => onKey(key),
                    child: Container(
                      height: 52,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceHigh,
                        borderRadius:
                            BorderRadius.circular(AppTheme.radiusButton),
                      ),
                      child: key == 'del'
                          ? const Icon(Icons.backspace_outlined,
                              color: AppTheme.onSurfaceVariant, size: 20)
                          : Text(key, style: AppTheme.amountLg.copyWith(fontSize: 22)),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}
