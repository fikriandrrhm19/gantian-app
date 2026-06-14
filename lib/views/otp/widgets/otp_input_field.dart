import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class OtpInputField extends StatefulWidget {
  final Function(String) onVerificationComplete;

  const OtpInputField({super.key, required this.onVerificationComplete});

  @override
  State<OtpInputField> createState() => _OtpInputFieldState();
}

class _OtpInputFieldState extends State<OtpInputField> {
  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  
  int _secondsLeft = 42;
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
      _secondsLeft = 42;
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
    for (int i = 0; i < 6; i++) {
      _controllers[i].dispose();
      _focusNodes[i].dispose();
    }
    super.dispose();
  }

  void _checkOtpStatus() {
    String otpCode = "";
    for (var controller in _controllers) {
      otpCode += controller.text;
    }
    setState(() {
      _isButtonActive = otpCode.length == 6;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(6, (index) {
              return KeyboardListener(
                focusNode: FocusNode(), 
                onKeyEvent: (KeyEvent event) {
                  if (event is KeyDownEvent && 
                      event.logicalKey == LogicalKeyboardKey.backspace) {
                    if (_controllers[index].text.isEmpty && index > 0) {
                      _focusNodes[index - 1].requestFocus();
                    }
                  }
                },
                child: SizedBox(
                  width: 44,
                  child: TextField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    showCursor: false,
                    enableInteractiveSelection: true,
                    style: const TextStyle(
                      fontSize: 22, 
                      fontWeight: FontWeight.w700, 
                      color: Color(0xff0F172A)
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],

                    onTap: () {
                      if (_controllers[index].text.isNotEmpty) {
                        _controllers[index].selection = TextSelection(
                          baseOffset: 0,
                          extentOffset: _controllers[index].text.length,
                        );
                      }
                    },
                    onChanged: (value) {
                      final String cleanValue = value.trim();

                      if (cleanValue.length > 1 && cleanValue.length <= 6) {
                        for (var controller in _controllers) {
                          controller.clear();
                        }
                        for (int i = 0; i < cleanValue.length; i++) {
                          if (i < 6) _controllers[i].text = cleanValue[i];
                        }
                        _focusNodes[cleanValue.length - 1].requestFocus();
                        _checkOtpStatus();
                        return;
                      }

                      if (cleanValue.isNotEmpty) {
                        if (cleanValue.length > 1) {
                          String lastChar = cleanValue.substring(cleanValue.length - 1);
                          _controllers[index].text = lastChar;
                        }

                        _controllers[index].selection = TextSelection(
                          baseOffset: 0,
                          extentOffset: _controllers[index].text.length,
                        );

                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (index < 5 && _focusNodes[index].hasFocus) {
                            _focusNodes[index + 1].requestFocus();
                          }
                        });
                      }
                      _checkOtpStatus();
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Color(0xffE2E8F0), width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Color(0xff2563EB), width: 2.0),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 23),
          
          Column(
            children: [
              const Text(
                'Tidak menerima kode?',
                style: TextStyle(
                  color: Color(0xff64748B), 
                  fontSize: 13, 
                  fontWeight: FontWeight.w500
                ),
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

          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _isButtonActive
                  ? () {
                      FocusScope.of(context).unfocus();
                      
                      String finalCode = "";
                      for (var c in _controllers) { finalCode += c.text; }
                      widget.onVerificationComplete(finalCode);
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff2563EB),
                disabledBackgroundColor: const Color(0xff94A3B8).withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: _isButtonActive ? 4 : 0,
              ),
              child: const Text(
                'Verifikasi',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}