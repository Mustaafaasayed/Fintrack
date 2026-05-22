import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fintrack/main.dart';

void main() {
  testWidgets('Dash dashboard renders', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: FintrackApp()),
    );
    await tester.pumpAndSettle();

    expect(find.text('NET POSITION'), findsOneWidget);
    expect(find.text('LEDGER NODES'), findsWidgets);
    expect(find.text('FinTrack'), findsOneWidget);
  });
}
