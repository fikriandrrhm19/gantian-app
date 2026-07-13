import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../../../components/primary_button.dart';
import '../../../controllers/auth_controller.dart';

class WelcomeForm extends StatefulWidget {
  final Function(String) onSubmitted;

  const WelcomeForm({
    super.key,
    required this.onSubmitted,
  });

  @override
  State<WelcomeForm> createState() => _WelcomeFormState();
}

class _WelcomeFormState extends State<WelcomeForm> {
  final TextEditingController _nameController = TextEditingController();
  bool _isFocused = false;
  bool _isValidName = false;

  bool _hasMinTwoWords = false;
  bool _hasMinThreeCharsPerWord = false;
  bool _isAlphaValid = true;

  String _errorMessage = "";
  bool _isMaxLimitError = false;
  Timer? _errorTimer;

  @override
  void dispose() {
    _nameController.dispose();
    _errorTimer?.cancel();
    super.dispose();
  }

  void _validateName(String value) {
    if (value.contains('  ')) {
      _nameController.text = value.replaceAll('  ', ' ');
      _nameController.selection = TextSelection.fromPosition(
        TextPosition(offset: _nameController.text.length),
      );
      return;
    }

    final String cleanValue = value.trim();
    final RegExp alphaRegex = RegExp(r"^[a-zA-Z\s']+$");

    if (value.length > 50) {
      _nameController.text = value.substring(0, 50);
      _nameController.selection = TextSelection.fromPosition(
        TextPosition(offset: _nameController.text.length),
      );
      
      setState(() {
        _isMaxLimitError = true;
        _errorMessage = "Nama lengkap tidak boleh lebih dari 50 karakter";
      });

      if (_errorTimer?.isActive ?? false) _errorTimer?.cancel();
      _errorTimer = Timer(const Duration(milliseconds: 1500), () {
        if (mounted) {
          setState(() {
            _isMaxLimitError = false;
            if (_nameController.text.trim().length == 50) {
              _errorMessage = "";
            }
          });
        }
      });
      return;
    }

    setState(() {
      _errorMessage = "";

      if (cleanValue.isEmpty) {
        _hasMinTwoWords = false;
        _hasMinThreeCharsPerWord = false;
        _isAlphaValid = true;
        _isValidName = false;
        return;
      }

      if (!alphaRegex.hasMatch(cleanValue)) {
        _isAlphaValid = false;
        _errorMessage = "Nama hanya boleh berisi huruf alfabet";
        _isValidName = false;
        return;
      } else {
        _isAlphaValid = true;
      }

      List<String> words = cleanValue.split(' ').where((w) => w.isNotEmpty).toList();

      _hasMinTwoWords = words.length >= 2;
      _hasMinThreeCharsPerWord = words.isNotEmpty && words.every((word) => word.length >= 3);

      _isValidName = _hasMinTwoWords && _hasMinThreeCharsPerWord && _isAlphaValid;
    });
  }

  String _maskPhoneNumber(String number) {
    if (number.length < 6) return number;
    final String start = number.substring(0, 3);
    final String end = number.substring(number.length - 3);
    return '+62 $start •••• $end';
  }

  Widget _buildValidationRule({required String text, required bool isValid, required bool hasInput}) {
    Color textColor = !hasInput 
        ? const Color(0xff64748B) 
        : (isValid ? const Color(0xff16A34A) : const Color(0xffDC2626));
    
    IconData icon = isValid ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Icon(icon, size: 16, color: textColor),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: textColor,
              fontFamily: 'Plus Jakarta Sans',
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool hasInput = _nameController.text.isNotEmpty;
    bool showRedBorder = _isMaxLimitError || 
        (_errorMessage.isNotEmpty && hasInput) || 
        (hasInput && (!_hasMinTwoWords || !_hasMinThreeCharsPerWord) && !_isFocused);
        
    final phoneNumber = context.watch<AuthController>().phoneNumber;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Selamat Datang!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: Color(0xff0F172A),
              height: 1.3,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'Yuk, isi nama lengkapmu untuk\ndipanggil saat antrean nanti.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Color(0xff475569),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 33),

          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Nomor HP',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xff475569),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: const Color(0xffF8FAFC),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xffE2E8F0), width: 1.5),
            ),
            child: Text(
              _maskPhoneNumber(phoneNumber),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xff64748B),
              ),
            ),
          ),
          const SizedBox(height: 20),

          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Nama Lengkap',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xff475569),
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: showRedBorder
                      ? const Color(0xffBA1A1A)
                      : (_isFocused ? const Color(0xff2563EB) : const Color(0xffE2E8F0)),
                  width: (_isFocused || showRedBorder) ? 2.0 : 1.5,
                ),
                boxShadow: (_isFocused || showRedBorder)
                    ? [
                        BoxShadow(
                          color: showRedBorder
                              ? const Color(0xffBA1A1A).withOpacity(0.08)
                              : const Color(0xff2563EB).withOpacity(0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        )
                      ]
                    : [],
              ),
              child: TextField(
                controller: _nameController,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                onChanged: _validateName,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Masukkan nama lengkap',
                  hintStyle: TextStyle(
                    color: Color(0xff6B7280),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff0F172A),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_errorMessage.isNotEmpty) ...[
                  Text(
                    _errorMessage,
                    style: const TextStyle(
                      color: Color(0xffBA1A1A),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Plus Jakarta Sans',
                    ),
                  ),
                  const SizedBox(height: 6),
                ],
                if (_isAlphaValid) ...[
                  _buildValidationRule(
                    text: 'Minimal terdiri dari 2 kata',
                    isValid: _hasMinTwoWords,
                    hasInput: hasInput,
                  ),
                  _buildValidationRule(
                    text: 'Setiap kata minimal terdiri dari 3 karakter',
                    isValid: _hasMinThreeCharsPerWord,
                    hasInput: hasInput,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 32),

          PrimaryButton(
            text: 'Masuk ke Gantian',
            onPressed: _isValidName
                ? () {
                    FocusScope.of(context).unfocus();
                    widget.onSubmitted(_nameController.text);
                  }
                : null,
          ),
        ],
      ),
    );
  }
}