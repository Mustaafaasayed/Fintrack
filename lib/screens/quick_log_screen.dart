import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class QuickLogSheet extends StatefulWidget {
  const QuickLogSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const QuickLogSheet(),
    );
  }

  @override
  State<QuickLogSheet> createState() => _QuickLogSheetState();
}

class _QuickLogSheetState extends State<QuickLogSheet> {
  String _amount = '0';
  int _selectedSource = 0;
  int? _selectedCategory;

  static const _sources = ['Wallet', 'Checking', 'Savings'];
  static const _categories = [
    (Icons.restaurant_outlined, 'Food'),
    (Icons.directions_car_outlined, 'Transport'),
    (Icons.shopping_bag_outlined, 'Shopping'),
    (Icons.receipt_long_outlined, 'Bills'),
  ];

  void _onKey(String key) {
    setState(() {
      if (key == 'del') {
        if (_amount.length > 1) {
          _amount = _amount.substring(0, _amount.length - 1);
        } else {
          _amount = '0';
        }
      } else if (key == '.') {
        if (!_amount.contains('.')) _amount = '$_amount.';
      } else {
        _amount = _amount == '0' ? key : '$_amount$key';
      }
    });
  }

  String get _displayAmount {
    final value = double.tryParse(_amount) ?? 0;
    return AppTheme.formatAmount(value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.modal)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.screenMargin),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.outlineVariant,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.unit * 2.5),
              Text('QUICK ENTRY', style: AppTheme.labelLg, textAlign: TextAlign.center),
              const SizedBox(height: AppSpacing.unit * 2),
              Text(_displayAmount, style: AppTheme.amountQuickLog, textAlign: TextAlign.center),
              const SizedBox(height: AppSpacing.unit * 2.5),
              _Numpad(onKey: _onKey),
              const SizedBox(height: AppSpacing.unit * 3),
              Text('SOURCE ACCOUNT', style: AppTheme.labelLg),
              const SizedBox(height: AppSpacing.unit * 1.5),
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _sources.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final selected = _selectedSource == index;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedSource = index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: selected
                              ? AppColors.primary.withValues(alpha: 0.15)
                              : AppColors.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                          border: Border.all(
                            color: selected
                                ? AppColors.primary
                                : AppColors.outlineVariant,
                          ),
                        ),
                        child: Text(
                          _sources[index],
                          style: AppTheme.bodyMd.copyWith(
                            color: selected
                                ? AppColors.primary
                                : AppColors.onSurfaceVariant,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.unit * 3),
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
                                ? AppColors.primary.withValues(alpha: 0.15)
                                : AppColors.surfaceContainerHigh,
                          ),
                          child: Icon(
                            icon,
                            color: selected
                                ? AppColors.primary
                                : AppColors.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(label, style: AppTheme.bodySm.copyWith(fontSize: 11)),
                      ],
                    ),
                  );
                }),
              ),
              const SizedBox(height: AppSpacing.unit * 3),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(AppRadius.button),
                  border: Border.all(color: AppColors.outlineVariant),
                ),
                child: Text(
                  'Add a note...',
                  style: AppTheme.bodyMd.copyWith(color: AppColors.outline),
                ),
              ),
              const SizedBox(height: AppSpacing.unit * 2.5),
              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.onPrimaryDark,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.button),
                    ),
                  ),
                  child: Text(
                    'Log Transaction',
                    style: AppTheme.titleMd.copyWith(color: AppColors.onPrimaryDark),
                  ),
                ),
              ),
            ],
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
                        color: AppColors.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(AppRadius.button),
                      ),
                      child: key == 'del'
                          ? const Icon(
                              Icons.backspace_outlined,
                              color: AppColors.onSurfaceVariant,
                              size: 20,
                            )
                          : Text(key, style: AppTheme.amountMd),
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
