class CreditCard {
  const CreditCard({
    required this.accountId,
    required this.name,
    required this.dueAmount,
    required this.totalDebt,
    required this.limit,
    required this.dueInDays,
    required this.cycleStart,
    required this.cycleEnd,
  });

  final String accountId;
  final String name;
  final double dueAmount;
  final double totalDebt;
  final double limit;
  final int dueInDays;
  final DateTime cycleStart;
  final DateTime cycleEnd;

  double get utilization => (totalDebt / limit).clamp(0.0, 1.0);

  double get availableCredit => limit - totalDebt;

  String get cycleLabel {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[cycleStart.month - 1]} ${cycleStart.day} – '
        '${months[cycleEnd.month - 1]} ${cycleEnd.day}';
  }

  bool get isDueSoon => dueInDays <= 7;
}
