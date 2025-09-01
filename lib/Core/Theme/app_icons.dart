import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcons {
  static const String apple = "assets/icons/Apple.svg";
  static const String arrow = "assets/icons/Arrow.svg";
  static const String facebook = "assets/icons/Facebook.svg";
  static const String gem = "assets/icons/Gem.svg";
  static const String google = "assets/icons/Google.svg";
  static const String heart = "assets/icons/Heart.svg";
  static const String heartFill = "assets/icons/Heart-fill.svg";
  static const String hide = "assets/icons/Hide.svg";
  static const String home = "assets/icons/Home.svg";
  static const String homeFill = "assets/icons/Home-fill.svg";
  static const String lock = "assets/icons/Lock.svg";
  static const String mail = "assets/icons/Mail.svg";
  static const String plus = "assets/icons/Plus.svg";
  static const String profile = "assets/icons/Profile.svg";
  static const String profileFill = "assets/icons/Profile-fill.svg";
  static const String see = "assets/icons/See.svg";
  static const String user = "assets/icons/User.svg";
  static const String x = "assets/icons/X.svg";
}


// MARK - SVG ICON WIDGET
class AppSvg extends StatelessWidget {
  final String path;
  final double size;
  final Color? color;

  const AppSvg(
      this.path, {
        super.key,
        this.size = 24,
        this.color,
      });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      width: size,
      height: size,
      colorFilter: color != null
          ? ColorFilter.mode(color!, BlendMode.srcIn)
          : null,
    );
  }
}