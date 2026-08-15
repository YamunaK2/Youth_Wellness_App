class FirebaseService {
  Future<void> initialize() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> saveMood(String mood) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // Placeholder for Firebase integration.
    debugPrint('Saved mood: $mood');
  }
}

void debugPrint(String message) {
  // no-op placeholder for compatibility with Flutter environment
}
