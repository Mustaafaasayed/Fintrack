import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void complete() => state = true;
}

final hasCompletedOnboardingProvider =
    NotifierProvider<OnboardingNotifier, bool>(OnboardingNotifier.new);
