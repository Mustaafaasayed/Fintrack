import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_theme.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onQuickLog,
  });

  final int currentIndex;
  final VoidCallback onQuickLog;

  static const _routes = ['/', '/accounts', '', '/insights', '/settings'];
  static const _labels = ['Dash', 'Accounts', 'Quick-Log', 'Insights', 'Settings'];
  static const _icons = [
    Icons.grid_view_rounded,
    Icons.account_balance_outlined,
    Icons.add_rounded,
    Icons.bar_chart_rounded,
    Icons.settings_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border(
          top: BorderSide(
            color: AppColors.outlineVariant.withValues(alpha: 0.3),
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.unit,
            vertical: AppSpacing.unit,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(5, (index) {
              if (index == 2) {
                return _QuickLogButton(onTap: onQuickLog);
              }
              final navIndex = index < 2 ? index : index - 1;
              final selected = currentIndex == navIndex;
              return _NavTab(
                icon: _icons[index],
                label: _labels[index],
                selected: selected,
                onTap: () {
                  if (index == 2) return;
                  final route = _routes[index];
                  if (route.isNotEmpty) context.go(route);
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavTab extends StatelessWidget {
  const _NavTab({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primary : AppColors.outline;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 22, color: color),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTheme.labelMd.copyWith(
                color: color,
                fontSize: 10,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickLogButton extends StatelessWidget {
  const _QuickLogButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 52,
        height: 52,
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.45),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(
          Icons.add_rounded,
          color: AppColors.onPrimaryDark,
          size: 28,
        ),
      ),
    );
  }
}

int bottomNavIndexFromPath(String path) {
  switch (path) {
    case '/accounts':
      return 1;
    case '/insights':
      return 2;
    case '/settings':
      return 3;
    default:
      return 0;
  }
}
