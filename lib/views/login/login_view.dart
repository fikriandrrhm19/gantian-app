import 'package:flutter/material.dart';
import '../../components/gradient_background.dart';
import 'widgets/login_illustration.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              LoginIllustration(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Text(
                  "[ Form Input Akan Dislicing Pada Tahap B ]",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}