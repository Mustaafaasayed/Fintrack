import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fintrack/main.dart';
import 'package:fintrack/providers/onboarding_provider.dart';

class _CompletedOnboarding extends OnboardingNotifier {
  @override
  bool build() => true;
}

void main() {
  testWidgets('Dash dashboard renders after onboarding', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          hasCompletedOnboardingProvider.overrideWith(() {
            return _CompletedOnboarding();
          }),
        ],
        child: const FintrackApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('NET POSITION'), findsOneWidget);
    expect(find.text('LEDGER NODES'), findsWidgets);
    expect(find.text('FinTrack'), findsOneWidget);
  });
}
