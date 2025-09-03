import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nodelabscase/Core/Theme/app_colors.dart';
import 'package:nodelabscase/Core/Theme/app_typography.dart';


class PrimaryLargeButton extends StatelessWidget {

  final String buttonText;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final bool isActive;

  const PrimaryLargeButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.width = 354,
    this.height = 56.0,
    required this.isActive
  });

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isActive ? AppColors.primary : AppColors.primaryDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          buttonText,
          style: AppTypography.bodyLargeSemiBold.copyWith(
            color: isActive
                ? AppColors.white
                : AppColors.white.withOpacity(0.5),
          ),
        ),
      ),
    );

  }
}
