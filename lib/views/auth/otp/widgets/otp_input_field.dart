import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'dart:async';
import '../../../../components/primary_button.dart';

class OtpInputField extends StatefulWidget {
  final Function(String) onVerificationComplete;

  const OtpInputField({super.key, required this.onVerificationComplete});

  @override
  State<OtpInputField> createState() => _OtpInputFieldState();
}

class _OtpInputFieldState extends State<OtpInputField> {
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _pinFocusNode = FocusNode();
  
  int _secondsLeft = 59;
  Timer? _countdownTimer;
  bool _canResend = false;
  bool _isButtonActive = false;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    setState(() {
      _secondsLeft = 59;
      _canResend = false;
    });
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        if (_secondsLeft == 0) {
          setState(() {
            _canResend = true;
            _countdownTimer?.cancel();
          });
        } else {
          setState(() {
            _secondsLeft--;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _pinController.dispose();
    _pinFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 44,
      height: 56,
      textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Color(0xff0F172A)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xffE2E8F0), width: 1.5),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: const Color(0xff2563EB), width: 2.0),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          Pinput(
            length: 6,
            controller: _pinController,
            focusNode: _pinFocusNode,
            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: focusedPinTheme,
            onChanged: (value) {
              setState(() {
                _isButtonActive = value.length == 6;
              });
            },
            onCompleted: (pin) {
              widget.onVerificationComplete(pin);
            },
          ),
          const SizedBox(height: 23),
          Column(
            children: [
              const Text(
                'Tidak menerima kode?',
                style: TextStyle(color: Color(0xff64748B), fontSize: 13, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 6),
              GestureDetector(
                onTap: _canResend ? _startCountdown : null,
                child: Text(
                  _canResend 
                      ? 'Kirim ulang sekarang' 
                      : 'Kirim ulang dalam 00:${_secondsLeft.toString().padLeft(2, '0')}',
                  style: TextStyle(
                    color: const Color(0xff2563EB),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    decoration: _canResend ? TextDecoration.underline : TextDecoration.none,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          PrimaryButton(
            text: 'Verifikasi',
            onPressed: _isButtonActive
                ? () {
                    FocusScope.of(context).unfocus();
                    widget.onVerificationComplete(_pinController.text);
                  }
                : null,
          ),
        ],
      ),
    );
  }
}