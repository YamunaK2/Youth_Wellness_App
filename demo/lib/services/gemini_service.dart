class GeminiService {
  Future<String> getReply(String message) async {
    await Future.delayed(const Duration(milliseconds: 900));

    final lower = message.toLowerCase();
    if (lower.contains('sad') || lower.contains('depressed')) {
      return 'I am sorry you are feeling this way. Please take a small break, breathe slowly, and reach out to someone you trust.';
    }
    if (lower.contains('stress') || lower.contains('anxious')) {
      return 'Stress can feel overwhelming, but a brief breathing exercise and gentle movement can help you reset.';
    }
    return 'Thank you for sharing that. I am here to support you with calm, encouraging guidance.';
  }
}
