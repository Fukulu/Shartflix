import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nodelabscase/Core/Theme/app_colors.dart';

class CustomBackgroundView extends StatelessWidget {
  final Widget child;

  const CustomBackgroundView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        Container(
          decoration: const BoxDecoration(
            gradient: AppColors.bgGradient,
          ),
        ),

        Positioned(
          top: -50,
          left: -50,
          right: -50,
          child: Opacity(
            opacity: 0.8,
            child: Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFFF1B1B),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFFF1B1B),
                    blurRadius: 150,
                    spreadRadius: 100,
                  ),
                  BoxShadow(
                    color: Color(0xFF8D0000),
                    blurRadius: 200,
                    spreadRadius: 100,
                  ),
                ],
              ),
            ),
          ),
        ),

        child,
      ],
    );
  }
}
