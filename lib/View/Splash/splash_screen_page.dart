import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nodelabscase/Components/CustomViews/custom_background_view.dart';
import 'package:nodelabscase/Core/Theme/app_icons.dart';
import 'package:provider/provider.dart';

import '../../Core/Theme/app_typography.dart';
import '../../ViewModel/auth_view_model.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigateToHome();
    });
  }

  Future<void> _navigateToHome() async {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    try {
      await authViewModel.fetchUserProfile();
      await Future.delayed(const Duration(seconds: 3));

      if (!mounted) return;

      if (authViewModel.currentUser != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Center()), // HOME
        );
      } else {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Center()), // LOGIN
          );
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("DEBUG -> Something wrong in _navigateHome func: ${e.toString()}");
      }
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Center()), //LOGIN
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackgroundView(
        child: Center(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/images/shartflixIcon.svg"),
              const SizedBox(height: 5),
              const Text(
                "Shartflix",
                style: AppTypography.h2
              ),
            ],
          ),

        ),
      ),
    );
  }

}
