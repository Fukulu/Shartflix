import 'package:flutter/material.dart';
import 'package:nodelabscase/Core/Theme/app_colors.dart';
import 'package:nodelabscase/Core/Theme/app_icons.dart';

class CustomNameField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;

  const CustomNameField({
    super.key,
    this.hintText = "Name Surname",
    required this.controller,
  });

  @override
  State<CustomNameField> createState() => _CustomNameFieldState();
}

class _CustomNameFieldState extends State<CustomNameField> {
  bool isFocused = false;
  String? errorText;

  void _validateName(String value) {
    setState(() {
      if (value.isEmpty) {
        errorText = null;
      } else if (value.trim().length < 2) {
        errorText = "Name must be at least 2 characters long";
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
                _validateName(widget.controller.text);
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
                      AppIcons.user,
                      size: 20,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: widget.controller,
                        onChanged: _validateName,
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
