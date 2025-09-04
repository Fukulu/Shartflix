import 'package:flutter/material.dart';
import 'package:nodelabscase/Core/Theme/app_icons.dart';
import 'package:nodelabscase/Core/Theme/app_typography.dart';

import '../../Core/Theme/app_colors.dart';

class LimitedOfferButton extends StatelessWidget {

  final VoidCallback onPressed;
  final double width;
  final double height;

  const LimitedOfferButton({
    required this.onPressed,
    this.width = 180,
    this.height = 40.0,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppSvg(AppIcons.gem),
            SizedBox(width: 10),
            Text(
              "Limited Offer",
              style: AppTypography.bodyMediumBold
            ),
          ],
        ),
      ),
    );
  }
}
