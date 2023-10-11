import 'package:age_care/widgets/background_widget.dart';
import 'package:flutter/material.dart';

import '../../widgets/login_button_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _passwordVisiable = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(children: [
          const SizedBox(
            height: 300,
            width: double.infinity,
            child: BackGroundWidget(),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "LOGIN",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 32,
            ),
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Enter Username",
                    labelText: "Username",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.person,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  obscureText: !_passwordVisiable,
                  decoration: const InputDecoration(
                    hintText: "Enter Password",
                    labelText: "Password",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.lock,
                      size: 20,
                    ),
                    suffixIcon: IconButton(
                      onPressed: null,
                      icon: Icon(Icons.visibility),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password cannot be empty";
                    } else if (value.length < 6) {
                      return "Password length should be atleast 6";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                LoginButton(
                  text: "Login",
                  onTap: () {
                    Navigator.pushNamed(context, '/home');
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const TextButton(
                  onPressed: null,
                  child: Text("Herchaha Mobile Application Version 1.0.0"),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
