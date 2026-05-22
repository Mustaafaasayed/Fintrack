import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/onboarding_provider.dart';
import '../screens/accounts_screen.dart';
import '../screens/home_screen.dart';
import '../screens/insights_screen.dart';
import '../screens/onboarding/step1_privacy_screen.dart';
import '../screens/onboarding/step2_sms_engine_screen.dart';
import '../screens/onboarding/step3_node_setup_screen.dart';
import '../screens/settings_screen.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav.dart';

final _routerRefresh = _RouterRefreshNotifier();

final appRouterProvider = Provider<GoRouter>((ref) {
  ref.listen(hasCompletedOnboardingProvider, (_, _) {
    _routerRefresh.notify();
  });

  return GoRouter(
    initialLocation: '/onboarding/1',
    refreshListenable: _routerRefresh,
    redirect: (context, state) {
      final completed = ref.read(hasCompletedOnboardingProvider);
      final path = state.matchedLocation;

      if (!completed && !path.startsWith('/onboarding')) {
        return '/onboarding/1';
      }
      if (completed && path.startsWith('/onboarding')) {
        return '/home';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/onboarding/1',
        pageBuilder: (context, state) => _slidePage(
          state,
          const Step1PrivacyScreen(),
        ),
      ),
      GoRoute(
        path: '/onboarding/2',
        pageBuilder: (context, state) => _slidePage(
          state,
          const Step2SmsEngineScreen(),
        ),
      ),
      GoRoute(
        path: '/onboarding/3',
        pageBuilder: (context, state) => _slidePage(
          state,
          const Step3NodeSetupScreen(),
        ),
      ),
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: '/home',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomeScreen(),
            ),
          ),
          GoRoute(
            path: '/accounts',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: AccountsScreen(),
            ),
          ),
          GoRoute(
            path: '/insights',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: InsightsScreen(),
            ),
          ),
          GoRoute(
            path: '/settings',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: SettingsScreen(),
            ),
          ),
        ],
      ),
    ],
  );
});

CustomTransitionPage<void> _slidePage(GoRouterState state, Widget child) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      final tween = Tween(begin: begin, end: end).chain(
        CurveTween(curve: Curves.easeOutCubic),
      );
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class _RouterRefreshNotifier extends ChangeNotifier {
  void notify() => notifyListeners();
}

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: child,
      bottomNavigationBar: const AppBottomNav(),
    );
  }
}
