import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/quick_log_screen.dart';
import '../theme/app_theme.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key});

  static const _tabs = [
    _TabData('Dash', Icons.grid_view_rounded, '/home'),
    _TabData('Accounts', Icons.account_balance_outlined, '/accounts'),
    _TabData('Quick-Log', Icons.add_rounded, ''),
    _TabData('Insights', Icons.bar_chart_rounded, '/insights'),
    _TabData('Settings', Icons.settings_outlined, '/settings'),
  ];

  int _indexFromLocation(String location) {
    if (location.startsWith('/accounts')) return 1;
    if (location.startsWith('/insights')) return 3;
    if (location.startsWith('/settings')) return 4;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final selected = _indexFromLocation(location);

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceLowest,
        border: Border(
          top: BorderSide(
            color: AppTheme.outlineVariant.withValues(alpha: 0.3),
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_tabs.length, (index) {
              if (index == 2) {
                return _QuickLogButton(
                  onTap: () => QuickLogScreen.show(context),
                );
              }
              final tab = _tabs[index];
              final navIndex = index < 2 ? index : index - 1;
              final isSelected = selected == navIndex;
              return _NavItem(
                label: tab.label,
                icon: tab.icon,
                selected: isSelected,
                onTap: () => context.go(tab.route),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _TabData {
  const _TabData(this.label, this.icon, this.route);
  final String label;
  final IconData icon;
  final String route;
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppTheme.cyan : AppTheme.outline;
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
              style: AppTheme.labelCyan.copyWith(
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
          color: AppTheme.cyan,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppTheme.cyan.withValues(alpha: 0.45),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(
          Icons.add_rounded,
          color: AppTheme.background,
          size: 28,
        ),
      ),
    );
  }
}
