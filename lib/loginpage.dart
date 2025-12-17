import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_series/forgotpassword.dart';
import 'package:firebase_series/main.dart';
import 'package:firebase_series/phoneauthpage.dart';
import 'package:firebase_series/signuppage.dart';
import 'package:firebase_series/ui_helper.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      UiHelper.CustomAlertBox(context, 'Please enter all fields');
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => MyHomePage(title: 'Welcome Back'),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      UiHelper.CustomAlertBox(context, e.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UiHelper.CustomTextField(
            emailController,
            "Email",
            Icons.mail,
            false,
          ),
          UiHelper.CustomTextField(
            passwordController,
            'Password',
            Icons.password,
            true,
          ),
          const SizedBox(height: 30),
          UiHelper.CustomButton(
            () {
              login(
                emailController.text.trim(),
                passwordController.text.trim(),
              );
            },
            'Login',
          ),
          const SizedBox(height: 10),
          UiHelper.CustomButton(
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PhoneAuthPage(),
                ),
              );
            },
            'Continue with Phone',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Don\'t have account?',
                style: TextStyle(fontSize: 15),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SIgnupPage(),
                    ),
                  );
                },
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ForgotPassword(),
                ),
              );
            },
            child: const Text(
              'Forgot Password',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
