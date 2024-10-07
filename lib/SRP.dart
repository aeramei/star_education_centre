import 'package:flutter/material.dart';

class UserService {
  void saveUser(String userName) {
    // Save the user to a database
    print("User $userName saved!");
  }
}

class UserInterface extends StatelessWidget {
  final UserService userService = UserService();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        userService.saveUser("Ingyin Mei");
      },
      child: Text("Save User"),
    );
  }
}
