import 'package:flutter/material.dart';
import 'package:nodelabscase/Core/Theme/app_colors.dart';
import 'package:nodelabscase/Core/Theme/app_icons.dart';

class CustomEmailField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;

  const CustomEmailField({
    super.key,
    this.hintText = "E-Mail",
    required this.controller,
  });

  @override
  State<CustomEmailField> createState() => _CustomEmailFieldState();
}

class _CustomEmailFieldState extends State<CustomEmailField> {
  bool isFocused = false;
  String? errorText;

  bool _isValidEmail(String value) {
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(value);
  }

  void _validateEmail(String value) {
    setState(() {
      if (value.isEmpty) {
        errorText = null;
      } else if (!_isValidEmail(value)) {
        errorText = "Please enter a valid email address";
      } else {
        errorText = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FocusScope(
          child: Focus(
            onFocusChange: (focus) {
              setState(() {
                isFocused = focus;
              });
              if (!focus) {
                _validateEmail(widget.controller.text);
              }
            },
            child: SizedBox(
              width: 354,
              height: 56,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: errorText != null
                        ? AppColors.alertError
                        : isFocused
                        ? AppColors.primary
                        : Colors.white.withOpacity(0.2),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    const AppSvg(
                      AppIcons.mail,
                      size: 20,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: widget.controller,
                        onChanged: _validateEmail,
                        style: TextStyle(
                          color:
                          errorText != null ? AppColors.alertError : Colors.white,
                        ),
                        decoration: InputDecoration(
                          hintText: widget.hintText,
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                          ),
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 6),
          Text(
            errorText!,
            style: const TextStyle(
              color: AppColors.alertError,
              fontSize: 12,
            ),
          ),
        ]
      ],
    );
  }
}
