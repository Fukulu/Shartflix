import 'package:flutter/material.dart';
import 'package:nodelabscase/Core/Theme/app_colors.dart';
import 'package:nodelabscase/Core/Theme/app_icons.dart';

class CustomPasswordField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;

  const CustomPasswordField({
    super.key,
    this.hintText = "Şifre",
    required this.controller,
  });

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool isObscure = true;
  bool isFocused = false;
  String? errorText;

  void _validatePassword(String value) {
    setState(() {
      if (value.isEmpty) {
        errorText = null; // boşken hata gösterme
      } else if (value.length < 6) {
        errorText = "Şifre en az 6 karakter olmalıdır";
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
                _validatePassword(widget.controller.text);
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
                      AppIcons.lock,
                      size: 20,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: widget.controller,
                        obscureText: isObscure,
                        onChanged: _validatePassword,
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
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                      child: AppSvg(
                        isObscure ? AppIcons.hide : AppIcons.see,
                        size: 20,
                        color: Colors.white,
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
