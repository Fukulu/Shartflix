import 'package:flutter/material.dart';
import 'package:nodelabscase/Core/Theme/app_colors.dart';
import 'package:nodelabscase/Core/Theme/app_icons.dart';

class BackChevronButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double width;
  final double height;

  const BackChevronButton({
    super.key,
    required this.onPressed,
    this.width = 44,
    this.height = 44,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: AppColors.white10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(
              color: AppColors.white20,
              width: 1,
            ),
          ),
        ),
        child: const AppSvg(
          AppIcons.arrow,
          size: 24,
          color: AppColors.white,
        ),
      ),
    );
  }
}

