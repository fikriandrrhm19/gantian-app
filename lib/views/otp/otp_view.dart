import 'package:flutter/material.dart';
import '../../components/gradient_background.dart';
import 'widgets/otp_header.dart';
import 'widgets/otp_input_field.dart';

class OtpView extends StatelessWidget {
  final String phoneNumber;

  const OtpView({super.key, required this.phoneNumber});

  void _handleOtpVerification(BuildContext context, String otpCode) {
    if (otpCode == "111111") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Verification Success! New User Detected.'), backgroundColor: Colors.green),
      );
      // TODO: Navigator.push ke WelcomeView
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Verification Success! Welcome Back.'), backgroundColor: Colors.green),
      );
      // TODO: Navigator.pushReplacement ke HomeView
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                OtpHeader(phoneNumber: phoneNumber),
                const SizedBox(height: 40),
                OtpInputField(
                  onVerificationComplete: (code) => _handleOtpVerification(context, code),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}