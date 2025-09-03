import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nodelabscase/Components/CustomButtons/primary_large_button.dart';
import 'package:nodelabscase/Components/CustomButtons/social_media_button.dart';
import 'package:nodelabscase/Components/CustomTextField/custom_email_field.dart';
import 'package:nodelabscase/Components/CustomTextField/custom_password_field.dart';
import 'package:nodelabscase/Components/CustomViews/custom_background_view.dart';
import 'package:nodelabscase/Components/CustomViews/movie_banner_animation_view.dart';
import 'package:nodelabscase/Core/Theme/app_icons.dart';
import 'package:nodelabscase/Core/Theme/app_typography.dart';
import 'package:nodelabscase/View/Entrance/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackgroundView(
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
                const Text("Giriş Yap", style: AppTypography.h3),
                const SizedBox(height: 10,),
                const Text("Kullancı bilgilerinle giriş yap", style: AppTypography.bodyMediumRegular),

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
                        child: const Text("Şifre Unuttum", style: AppTypography.bodyMediumBold),
                      ),
                    ]
                  ),
                ),

                const SizedBox(height: 20,),

                // TAG - 5 - LOGIN BUTTON
                PrimaryLargeButton(
                    buttonText: "Giriş Yap",
                    onPressed: (){
                      if (kDebugMode) {
                        print("DEBUG -> Login Button Tapped!");
                      }
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
                    const Text("Bir hesabın yok mu? ", style: AppTypography.bodyMediumRegular),
                    TextButton(
                      onPressed: (){
                        Navigator.pushReplacement(
                          context,
                            MaterialPageRoute(builder: (context) => RegisterPage())
                        );
                      },
                      child: const Text("Kayıt Ol", style: AppTypography.bodyMediumBold),
                    )
                  ],
                )

              ],

            ),
          )
      ),
    );
  }
}
