class User {
  String name;
  User(this.name);
  void login() {
    print("$name logged in");
  }
}

class AdminUser extends User {
  AdminUser(String name) : super(name);

  @override
  void login() {
    print("$name (Admin) logged in");
  }
}

void loginUser(User user) {
  user.login();
}

void main() {
  User normalUser = User("Htet Paing");
  User admin = AdminUser("Ingyin");

  loginUser(normalUser);  // Output: Htet Paing logged in
  loginUser(admin);       // Output: Ingyin (Admin) logged in
}
