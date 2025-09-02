import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:nodelabscase/Core/Theme/app_colors.dart';
import 'package:nodelabscase/Core/Theme/app_icons.dart';

class LikeButton extends StatefulWidget {
  final double width;
  final double height;
  final VoidCallback onPressed; // dışarıdan fonksiyon

  const LikeButton({
    super.key,
    required this.onPressed,
    this.width = 52,
    this.height = 72,
  });

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool isLiked = false;

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: GestureDetector(
          onTap: toggleLike,
          child: Container(
            width: widget.width,
            height: widget.height,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2), // bg %20
              border: Border.all(
                color: Colors.white.withOpacity(0.6), // border %60
                width: 1,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeInOut,
                    ),
                    child: child,
                  );
                },
                child: isLiked
                    ? const AppSvg(
                  AppIcons.heartFill,
                  key: ValueKey("fill"),
                  size: 24,
                  color: AppColors.primary,
                )
                    : const AppSvg(
                  AppIcons.heart,
                  key: ValueKey("empty"),
                  size: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
