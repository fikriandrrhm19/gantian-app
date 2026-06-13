import 'package:flutter/material.dart';
import '../../components/gradient_background.dart';
import 'widgets/login_illustration.dart';
import 'widgets/login_form.dart';
import 'widgets/login_footer.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  void _handleLoginSubmit(String phoneNumber) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Simulasi OTP dikirimkan ke: +62 $phoneNumber'),
        backgroundColor: const Color(0xff2563EB),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GradientBackground(
        child: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const LoginIllustration(),
                      LoginForm(onSubmitted: _handleLoginSubmit),
                    ],
                  ),
                  const LoginFooter(),
                ],
              ),
            ),
          ),
        ),  
      ),
    );
  }
}