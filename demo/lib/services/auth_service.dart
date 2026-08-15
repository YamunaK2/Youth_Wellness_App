class AuthService {
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 700));
    return email.trim().isNotEmpty && password.trim().isNotEmpty;
  }
}
