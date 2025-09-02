import 'dart:ui';
import 'package:flutter/material.dart';

class XMarkButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double size;

  const XMarkButton({
    super.key,
    required this.onPressed,
    this.size = 36,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8), // arka plan %80
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.5), // border %50
                width: 1,
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
