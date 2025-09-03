import 'package:flutter/material.dart';
import '../../Core/Theme/app_colors.dart';

class CircularIndicatorView extends StatefulWidget {
  const CircularIndicatorView({super.key});

  @override
  State<CircularIndicatorView> createState() => _CircularIndicatorViewState();
}

class _CircularIndicatorViewState extends State<CircularIndicatorView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppColors.white05,
      child: const Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
          strokeWidth: 3,
        ),
      ),
    );
  }
}
