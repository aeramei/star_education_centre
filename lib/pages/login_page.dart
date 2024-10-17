// import 'package:flutter/material.dart';
// import 'package:mhk_star_education/pages/shared_page.dart';
//
// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   final String correctEmail = 'minnhtetko@gmail.com';
//   final String correctPassword = 'mhk123';
//
//   void _login() {
//     String email = _emailController.text;
//     String password = _passwordController.text;
//
//     if (email == correctEmail && password == correctPassword) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text("Login Successful"),
//             content: Text("Welcome, $email!"),
//             actions: [
//               TextButton(
//                 child: Text("OK"),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                   Navigator.of(context).pushReplacement(
//                     MaterialPageRoute(
//                       builder: (BuildContext context) => const SharedPage(),
//                     ),
//                   );
//                 },
//               ),
//             ],
//           );
//         },
//       );
//     } else {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text("Login Failed"),
//             content: Text("Incorrect email or password"),
//             actions: [
//               TextButton(
//                 child: Text("Try Again"),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white, // Set background color to white
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(32.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               // App title
//               Text(
//                 'Welcome Back!',
//                 style: TextStyle(
//                   color: Colors.cyan, // Set text color to cyan
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 40),
//               // Email field
//               TextField(
//                 controller: _emailController,
//                 style: TextStyle(
//                     color: Colors.cyan), // Set input text color to cyan
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Colors.cyan.withOpacity(0.1),
//                   // Light cyan background for input fields
//                   hintText: 'Email',
//                   hintStyle: TextStyle(color: Colors.cyan),
//                   // Hint text color cyan
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30.0),
//                     borderSide: BorderSide.none,
//                   ),
//                   prefixIcon:
//                       Icon(Icons.email, color: Colors.cyan), // Cyan icon
//                 ),
//                 keyboardType: TextInputType.emailAddress,
//               ),
//               SizedBox(height: 20),
//               // Password field
//               TextField(
//                 controller: _passwordController,
//                 style: TextStyle(
//                     color: Colors.cyan), // Set input text color to cyan
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Colors.cyan.withOpacity(0.1),
//                   // Light cyan background for input fields
//                   hintText: 'Password',
//                   hintStyle: TextStyle(color: Colors.cyan),
//                   // Hint text color cyan
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30.0),
//                     borderSide: BorderSide.none,
//                   ),
//                   prefixIcon: Icon(Icons.lock, color: Colors.cyan), // Cyan icon
//                 ),
//                 obscureText: true,
//               ),
//               SizedBox(height: 30),
//               // Login button
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: _login,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.tealAccent,
//                     // Set button color to cyan
//                     padding: EdgeInsets.symmetric(vertical: 15),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30.0),
//                     ),
//                   ),
//                   child: Text(
//                     'Login',
//                     style: TextStyle(color: Colors.white, fontSize: 18),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               // Forgot password link
//               TextButton(
//                 onPressed: () {},
//                 child: Text(
//                   'Forgot Password?',
//                   style: TextStyle(
//                       color: Colors.cyan), // Set link text color to cyan
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
