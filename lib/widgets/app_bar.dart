import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class FintrackAppBar extends StatelessWidget {
  const FintrackAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenMargin,
        AppSpacing.unit * 2,
        AppSpacing.screenMargin,
        AppSpacing.unit,
      ),
      child: Row(
        children: [
          _Logo(),
          const Spacer(),
          _IconButton(icon: Icons.notifications_outlined),
          const SizedBox(width: AppSpacing.unit),
          _IconButton(icon: Icons.menu_rounded),
          const SizedBox(width: AppSpacing.unit * 1.5),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHigh,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary, width: 1.5),
            ),
            alignment: Alignment.center,
            child: Text(
              'A',
              style: AppTheme.titleMd.copyWith(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(AppRadius.button),
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.4)),
          ),
          child: Center(
            child: Text(
              'F>',
              style: AppTheme.titleMd.copyWith(
                color: AppColors.primary,
                fontSize: 14,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          'FinTrack',
          style: AppTheme.titleLg.copyWith(letterSpacing: -0.3),
        ),
      ],
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(AppRadius.button),
        border: Border.all(
          color: const Color(0xFFFFFFFF).withValues(alpha: 0.07),
        ),
      ),
      child: Icon(icon, color: AppColors.onSurfaceVariant, size: 20),
    );
  }
}
