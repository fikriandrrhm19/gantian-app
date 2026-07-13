import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../../../components/primary_button.dart';
import '../../../controllers/auth_controller.dart';

class LoginForm extends StatefulWidget {
  final Function(String) onSubmitted;
  final bool isRequesting;

  const LoginForm({
    super.key, 
    required this.onSubmitted,
    required this.isRequesting,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _phoneController = TextEditingController();

  bool _isFocused = false;
  bool _isValidInput = false;
  bool _isMaxLimitError = false;

  Timer? _errorTimer;

  @override
  void initState() {
    super.initState();
    final savedPhone = context.read<AuthController>().phoneNumber;
    if (savedPhone.isNotEmpty) {
      _phoneController.text = savedPhone;
      _validateInput(savedPhone);
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _errorTimer?.cancel();
    super.dispose();
  }

  void _validateInput(String value) {
    final String cleanValue = value.trim();
    if (cleanValue.length > 13) {
      _phoneController.text = cleanValue.substring(0, 13);
      _phoneController.selection = TextSelection.fromPosition(
        TextPosition(offset: _phoneController.text.length),
      );
      
      setState(() {
        _isMaxLimitError = true;
      });

      if (_errorTimer?.isActive ?? false) _errorTimer?.cancel();
      _errorTimer = Timer(const Duration(milliseconds: 1500), () {
        if (mounted) {
          setState(() {
            _isMaxLimitError = false;
          });
        }
      });
      return;
    }

    setState(() {
      _isValidInput = cleanValue.isNotEmpty && 
                      cleanValue.length >= 9 && 
                      cleanValue.length <= 13;
      
      if (cleanValue.length <= 13) {
        _isMaxLimitError = false;
        _errorTimer?.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Siap Mengambil\nAntrean?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: Color(0xff0F172A),
              height: 1.3,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Masuk dengan nomor HP untuk\nmengambil antrean, menerima\nnotifikasi, dan memantau giliranmu.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Color(0xff64748B),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),

          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Nomor HP',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xff64748B),
              ),
            ),
          ),
          const SizedBox(height: 8),

          Focus(
            onFocusChange: (hasFocus) {
              setState(() {
                _isFocused = hasFocus;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: widget.isRequesting ? const Color(0xffF8FAFC) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _isMaxLimitError
                      ? const Color(0xffBA1A1A)
                      : (_isFocused ? const Color(0xff2563EB) : const Color(0xffE2E8F0)),
                  width: (_isFocused || _isMaxLimitError) ? 2.0 : 1.5,
                ),
                boxShadow: (_isFocused || _isMaxLimitError)
                    ? [
                        BoxShadow(
                          color: _isMaxLimitError
                              ? const Color(0xffBA1A1A).withOpacity(0.1)
                              : const Color(0xff2563EB).withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        )
                      ]
                    : [],
              ),
              child: Row(
                children: [
                  const Text(
                    '+62',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff0F172A),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 1.5,
                    height: 24,
                    color: const Color(0xffCBD5E1),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.number,
                      readOnly: widget.isRequesting,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(14),
                      ],
                      onChanged: _validateInput,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '81234567890',
                        hintStyle: TextStyle(
                          color: Color(0xff94A3B8),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: widget.isRequesting ? const Color(0xff94A3B8) : const Color(0xff0F172A),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          if (_isMaxLimitError) ...[
            const SizedBox(height: 8),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 4.0),
                child: Text(
                  'Nomor telepon tidak boleh lebih dari 13 digit',
                  style: TextStyle(
                    color: Color(0xffBA1A1A),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
          const SizedBox(height: 24),

          PrimaryButton(
            text: widget.isRequesting ? 'Memuat...' : 'Lanjut',
            icon: widget.isRequesting ? null : Icons.arrow_forward,
            onPressed: (_isValidInput && !widget.isRequesting)
                ? () {
                    FocusScope.of(context).unfocus();
                    widget.onSubmitted(_phoneController.text);
                  }
                : null,
          ),
        ],
      ),
    );
  }
}