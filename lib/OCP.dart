abstract class User {
  void login();
}

class FacebookUser extends User {
  @override
  void login() {
    print("Logging in with Facebook");
  }
}

class GoogleUser extends User {
  @override
  void login() {
    print("Logging in with Google");
  }
}

void performLogin(User user) {
  user.login();
}
