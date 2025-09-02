import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nodelabscase/Core/Theme/app_colors.dart';
import 'package:nodelabscase/Core/Theme/app_typography.dart';


class SecondaryLargeButton extends StatelessWidget {

  final String buttonText;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final bool isActive;

  const SecondaryLargeButton({
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
        onPressed: (){
          if (isActive) {
            onPressed();
          } else {
            if (kDebugMode) {
              print("DEBUG -> Button is disabled!");
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isActive ? AppColors.white10 : AppColors.white10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              color: isActive
                  ? AppColors.white20
                  : AppColors.white10,
              width: 1,
            ),
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
