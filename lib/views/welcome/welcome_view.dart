import 'package:flutter/material.dart';
import '../../components/gradient_background.dart';
import '../../components/back_button_custom.dart';
import '../../components/custom_toast.dart';
import 'widgets/welcome_form.dart';
import '../home/home_view.dart';

class WelcomeView extends StatelessWidget {
  final String phoneNumber;

  const WelcomeView({super.key, required this.phoneNumber});

  void _handleRegistrationSubmit(BuildContext context, String fullName) {
    CustomToast.show(
      context: context,
      message: 'Pendaftaran berhasil, selamat datang $fullName!',
      isSuccess: true,
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeView(),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 49.0, left: 24.0, right: 24.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: BackButtonCustom(),
                    ),
                  ),
                  const SizedBox(height: 31),

                  WelcomeForm(
                    phoneNumber: phoneNumber,
                    onSubmitted: (name) => _handleRegistrationSubmit(context, name),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}