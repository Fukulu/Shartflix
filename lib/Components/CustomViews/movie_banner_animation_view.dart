import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:nodelabscase/Core/Theme/app_colors.dart';

class MovieBannerWidget extends StatefulWidget {
  const MovieBannerWidget({super.key});

  @override
  State<MovieBannerWidget> createState() => _MovieBannerWidgetState();
}

class _MovieBannerWidgetState extends State<MovieBannerWidget>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(4, (index) {
      final controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: 3 + index),
      )..repeat(reverse: true);
      return controller;
    });
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: AnimatedBuilder(
            animation: _controllers[index],
            builder: (context, child) {
              final angle =
                  math.sin(_controllers[index].value * math.pi * 1.5) * 0.12;

              return Transform.rotate(
                angle: angle,
                origin: const Offset(90, 0),
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Container(
                      width: 2,
                      height: 70,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [AppColors.white20, AppColors.white05],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        "assets/images/movieBanner${index + 1}.png",
                        width: 70,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}