import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/credit_card.dart';

final creditCardProvider = Provider<CreditCard>((ref) {
  return CreditCard(
    accountId: 'cib_credit',
    name: 'Titanium Card',
    dueAmount: 12400,
    totalDebt: 45000,
    limit: 150000,
    dueInDays: 4,
    cycleStart: DateTime(2026, 10, 1),
    cycleEnd: DateTime(2026, 10, 31),
  );
});
