import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nodelabscase/Components/CustomViews/custom_background_view.dart';
import 'package:nodelabscase/View/Entrance/login_page.dart';
import 'package:nodelabscase/View/Home/tab_controller_page.dart';
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

    await authViewModel.init();
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    if (authViewModel.token != null && authViewModel.currentUser != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TabControllerPage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
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
