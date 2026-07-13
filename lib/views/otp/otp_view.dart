import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/gradient_background.dart';
import '../../controllers/auth_controller.dart';
import 'widgets/otp_header.dart';
import 'widgets/otp_input_field.dart';
import '../../components/custom_toast.dart';
import '../welcome/welcome_view.dart';
import '../home/home_view.dart';

class OtpView extends StatefulWidget {
  final bool isExistingUser;

  const OtpView({super.key, required this.isExistingUser});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  bool _isVerifying = false;

  void _handleOtpVerification(BuildContext context, String otpCode) async {
    if (_isVerifying) return;

    if (otpCode == "111111" || otpCode == "123456") {
      setState(() {
        _isVerifying = true;
      });

      final authCtx = context.read<AuthController>();

      if (widget.isExistingUser) {
        await authCtx.saveExistingUserSession();
        if (mounted) {
          setState(() {
            _isVerifying = false;
          });
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeView()),
            (route) => false,
          );
        }
      } else {
        if (mounted) {
          setState(() {
            _isVerifying = false;
          });
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const WelcomeView()),
          );
        }
      }
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
                const OtpHeader(),
                const SizedBox(height: 40),
                _isVerifying
                    ? const Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: CircularProgressIndicator(color: Color(0xff2563EB)),
                      )
                    : OtpInputField(
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