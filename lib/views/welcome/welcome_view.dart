import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/gradient_background.dart';
import '../../components/back_button_custom.dart';
import '../../components/custom_toast.dart';
import 'widgets/welcome_form.dart';
import '../home/home_view.dart';
import '../../controllers/auth_controller.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  bool _isRegistering = false;

  void _handleRegistrationSubmit(BuildContext context, String fullName) async {
    if (_isRegistering) return;

    setState(() {
      _isRegistering = true;
    });

    final authCtx = context.read<AuthController>();
    bool isSuccess = await authCtx.registerUser(fullName);

    setState(() {
      _isRegistering = false;
    });

    if (mounted) {
      if (isSuccess) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeView()),
          (route) => false,
        );
      } else {
        CustomToast.show(
          context: context,
          message: authCtx.errorMessage.isNotEmpty ? authCtx.errorMessage : 'Pendaftaran gagal',
          isSuccess: false,
        );
      }
    }
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
                  _isRegistering
                      ? const Padding(
                          padding: EdgeInsets.only(top: 40.0),
                          child: Center(child: CircularProgressIndicator(color: Color(0xff2563EB))),
                        )
                      : WelcomeForm(
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