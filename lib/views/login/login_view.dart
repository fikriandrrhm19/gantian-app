import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/gradient_background.dart';
import 'widgets/login_illustration.dart';
import 'widgets/login_form.dart';
import 'widgets/login_footer.dart';
import '../otp/otp_view.dart';
import '../../components/custom_toast.dart';
import '../../controllers/auth_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  void _handleLoginSubmit(String phoneNumber) {
    context.read<AuthController>().setPhoneNumber(phoneNumber);

    CustomToast.show(
      context: context,
      message: 'Kode verifikasi dikirim',
      isSuccess: true,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const OtpView(),
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