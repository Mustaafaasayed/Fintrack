import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class FintrackAppBar extends StatelessWidget {
  const FintrackAppBar({
    super.key,
    this.showAvatar = false,
    this.avatarLetter = 'A',
  });

  final bool showAvatar;
  final String avatarLetter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppTheme.screenMargin,
        16,
        AppTheme.screenMargin,
        8,
      ),
      child: Row(
        children: [
          _LogoMark(),
          const Spacer(),
          _CircleIconButton(icon: Icons.notifications_outlined),
          const SizedBox(width: 8),
          if (showAvatar)
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppTheme.surfaceHigh,
                shape: BoxShape.circle,
                border: Border.all(color: AppTheme.cyan, width: 1.5),
              ),
              alignment: Alignment.center,
              child: Text(
                avatarLetter,
                style: AppTheme.titleMd.copyWith(color: AppTheme.cyan),
              ),
            )
          else
            _CircleIconButton(icon: Icons.menu_rounded),
        ],
      ),
    );
  }
}

class _LogoMark extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
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
            style: AppTheme.titleMd.copyWith(
              color: AppTheme.cyan,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          'FinTrack',
          style: AppTheme.headlineMd.copyWith(fontSize: 18),
        ),
      ],
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusButton),
        border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
      ),
      child: Icon(icon, color: AppTheme.onSurfaceVariant, size: 20),
    );
  }
}
