abstract class AuthService {
  void login();
}

class EmailAuthService implements AuthService {
  @override
  void login() {
    print("Logging in with Email");
  }
}

class GoogleAuthService implements AuthService {
  @override
  void login() {
    print("Logging in with Google");
  }
}

class UserLoginController {
  final AuthService authService;

  UserLoginController(this.authService);

  void loginUser() {
    authService.login();
  }
}

void main() {
  AuthService emailAuth = EmailAuthService();
  UserLoginController controller = UserLoginController(emailAuth);
  controller.loginUser();  // Output: Logging in with Email

  AuthService googleAuth = GoogleAuthService();
  controller = UserLoginController(googleAuth);
  controller.loginUser();  // Output: Logging in with Google
}
