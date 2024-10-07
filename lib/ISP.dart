abstract class UserLogin {
  void login();
}

abstract class UserRegistration {
  void register();
}

class EmailUser implements UserLogin, UserRegistration {
  @override
  void login() {
    print("Email login");
  }

  @override
  void register() {
    print("Email registration");
  }
}

class InstagramUser implements UserLogin {
  @override
  void login() {
    print("Instagram login");
  }
}