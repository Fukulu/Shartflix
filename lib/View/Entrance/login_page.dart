import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nodelabscase/Components/CustomButtons/primary_large_button.dart';
import 'package:nodelabscase/Components/CustomButtons/social_media_button.dart';
import 'package:nodelabscase/Components/CustomTextField/custom_email_field.dart';
import 'package:nodelabscase/Components/CustomTextField/custom_password_field.dart';
import 'package:nodelabscase/Components/CustomViews/circular_indicator_view.dart';
import 'package:nodelabscase/Components/CustomViews/custom_background_view.dart';
import 'package:nodelabscase/Components/CustomViews/movie_banner_animation_view.dart';
import 'package:nodelabscase/Core/Theme/app_icons.dart';
import 'package:nodelabscase/Core/Theme/app_typography.dart';
import 'package:nodelabscase/View/Entrance/register_page.dart';
import 'package:nodelabscase/View/Home/home_page.dart';
import 'package:nodelabscase/View/Home/tab_controller_page.dart';
import 'package:provider/provider.dart';

import '../../Components/CustomViews/custom_snackbar_view.dart';
import '../../ViewModel/auth_view_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // TAG - REGISTER BUTTON PRESSED
  Future<void> _onLoginPressed() async {
      final email = _emailController.text.trim();
      final password = _passwordController.text;

      if (email.isEmpty || password.isEmpty) {
        CustomSnackBar.show(context, "Please fill in all fields.");
        return;
      }

      setState(() {
        isLoading = true;
      });

      final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      await authViewModel.loginUser(email, password);

      setState(() {
        isLoading = false;
      });

      if (authViewModel.currentUser != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const TabControllerPage()),
        );
      } else {
        CustomSnackBar.show(context, "Please check your credentials and try again.");
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
            CustomBackgroundView(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const MovieBannerWidget(),

                    const SizedBox(height: 30,),

                    // TAG - 1 - APP ICON
                    SvgPicture.asset("assets/images/shartflixIcon.svg"),

                    const SizedBox(height: 10,),

                    // TAG - 2 - EXPLANATION TEXTS
                    const Text("Log In", style: AppTypography.h3),
                    const SizedBox(height: 10,),
                    const Text("Log In with your account", style: AppTypography.bodyMediumRegular),

                    const SizedBox(height: 30,),

                    // TAG - 3 - TEXT FIELDS
                    CustomEmailField(controller: _emailController),
                    const SizedBox(height: 20,),
                    CustomPasswordField(controller: _passwordController),

                    const SizedBox(height: 30,),

                    // TAG - 4 - FORGET TEXT BUTTON
                    SizedBox(
                      width: 354,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                if (kDebugMode) {
                                  print("DEBUG -> Forgot Password Tapped!");
                                }
                              },
                              child: const Text("Forgot Password", style: AppTypography.bodyMediumBold),
                            ),
                          ]
                      ),
                    ),

                    const SizedBox(height: 20,),

                    // TAG - 5 - LOGIN BUTTON
                    PrimaryLargeButton(
                        buttonText: "Log In",
                        onPressed: () async {
                          await _onLoginPressed();
                        },
                        isActive: true
                    ),

                    const SizedBox(height: 20,),

                    // TAG - 6 - SOCIAL MEDIA BUTTONS
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 20,
                      children: [
                        SocialMediaButton(
                            buttonIcon: AppIcons.google,
                            onPressed: (){
                              if (kDebugMode) {
                                print("DEBUG -> Google Button Tapped!");
                              }
                            }
                        ),
                        SocialMediaButton(
                            buttonIcon: AppIcons.apple,
                            onPressed: (){
                              if (kDebugMode) {
                                print("DEBUG -> Apple Button Tapped!");
                              }
                            }
                        ),
                        SocialMediaButton(
                            buttonIcon: AppIcons.facebook,
                            onPressed: (){
                              if (kDebugMode) {
                                print("DEBUG -> Facebook Button Tapped!");
                              }
                            }
                        ),
                      ],
                    ),

                    // TAG - 7 - SIGN UP TEXT BUTTON
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't you have an account? ", style: AppTypography.bodyMediumRegular),
                        TextButton(
                          onPressed: (){
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const RegisterPage())
                            );
                          },
                          child: const Text("Sign Up", style: AppTypography.bodyMediumBold),
                        )
                      ],
                    )

                  ],

                ),
              )
          ),

            if (isLoading) const CircularIndicatorView(),
          ]
      )

    );
  }
}
