import 'package:flutter/material.dart';
import '../../Core/Theme/app_colors.dart';
import '../../Core/Theme/app_typography.dart';

class OfferCard extends StatelessWidget {
  final String bonusText;
  final String oldValue;
  final String newValue;
  final String price;
  final String subtitle;
  final Color color;

  const OfferCard({
    super.key,
    required this.bonusText,
    required this.oldValue,
    required this.newValue,
    required this.price,
    required this.subtitle,
    this.color = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.white50),
        gradient: RadialGradient(
          center: Alignment.topLeft,
          colors: [
            color,
            AppColors.primary.withOpacity(0.8),
          ],
          radius: 1.8,
          focalRadius: 0.7
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 25),
              Text(
                oldValue,
                style: AppTypography.bodyMediumBold.copyWith(
                  decoration: TextDecoration.lineThrough,
                  decorationColor: Colors.white,
                  color: Colors.white70,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                newValue,
                style: AppTypography.h2.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 4),
              const Text("Coin", style: AppTypography.bodyMediumRegular),
              const SizedBox(height: 16),
              Container(
                height: 1,
                width: 145,
                color: Colors.white24,
              ),
              const SizedBox(height: 16),
              Text(price,
                  style: AppTypography.h4.copyWith(color: Colors.white)),
              const SizedBox(height: 4),
              Text(subtitle, style: AppTypography.bodyMediumRegular),
            ],
          ),

          // Bonus Badge
          Positioned(
            top: -15,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                      colors: [
                        color.withOpacity(0.9),
                        color.withOpacity(0.7),
                      ],
                      radius: 0.8,
                      focalRadius: 0.5
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.8),
                      blurRadius: 2,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Text(
                  bonusText,
                  style: AppTypography.bodyMediumBold.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
