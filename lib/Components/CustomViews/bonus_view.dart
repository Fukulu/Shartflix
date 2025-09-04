import 'package:flutter/material.dart';
import '../../Core/Theme/app_typography.dart';
import '../../Core/Theme/app_colors.dart';

class BonusView extends StatelessWidget {
  const BonusView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.90;

    return Container(
      width: width,
      height: 175,
      decoration: BoxDecoration(
        color: AppColors.white05,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.white30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Your Bonuses", style: AppTypography.h5),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Image.asset("assets/images/bonus1.png"),
                    const Text(
                        "Premium\nAccount",
                        style: AppTypography.bodyMediumRegular,
                        textAlign: TextAlign.center
                    ),
                  ],
                ),
                Column(
                  children: [
                    Image.asset("assets/images/bonus2.png"),
                    const Text(
                      "More\nMatches",
                      style: AppTypography.bodyMediumRegular,
                      textAlign: TextAlign.center
                    ),
                  ],
                ),
                Column(
                  children: [
                    Image.asset("assets/images/bonus3.png"),
                    const Text(
                      "Become\nPopular",
                      style: AppTypography.bodyMediumRegular,
                      textAlign: TextAlign.center
                    ),
                  ],
                ),
                Column(
                  children: [
                    Image.asset("assets/images/bonus4.png"),
                    const Text(
                      "Get\nMore Likes",
                      style: AppTypography.bodyMediumRegular,
                      textAlign: TextAlign.center
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
