import 'package:flutter/material.dart';
import '../../components/gradient_background.dart';
import 'widgets/otp_header.dart';
import 'widgets/otp_input_field.dart';
import '../../components/custom_toast.dart';

class OtpView extends StatelessWidget {
  final String phoneNumber;

  const OtpView({super.key, required this.phoneNumber});

  void _handleOtpVerification(BuildContext context, String otpCode) {
    if (otpCode == "111111") {
      CustomToast.show(
        context: context,
        message: 'Verifikasi berhasil',
        isSuccess: true,
      );
      
    } else if (otpCode == "123456") {
      CustomToast.show(
        context: context,
        message: 'Selamat datang kembali',
        isSuccess: true,
      );
      
    } else {
      CustomToast.show(
        context: context,
        message: 'Kode OTP tidak valid',
        isSuccess: false,
      );
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