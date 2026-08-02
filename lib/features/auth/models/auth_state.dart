import '../../../core/database/app_database.dart';

class AuthState {
  const AuthState({
    required this.isAuthenticated,
    required this.needsSetup,
    this.user,
  });

  const AuthState.unauthenticated({required this.needsSetup})
      : isAuthenticated = false,
        user = null;

  final bool isAuthenticated;
  final bool needsSetup;
  final User? user;

  AuthState copyWith({
    bool? isAuthenticated,
    bool? needsSetup,
    User? user,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      needsSetup: needsSetup ?? this.needsSetup,
      user: user ?? this.user,
    );
  }
}
