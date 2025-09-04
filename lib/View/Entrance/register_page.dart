import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nodelabscase/Components/CustomButtons/custom_checkBox_button.dart';
import 'package:nodelabscase/Components/CustomButtons/primary_large_button.dart';
import 'package:nodelabscase/Components/CustomButtons/social_media_button.dart';
import 'package:nodelabscase/Components/CustomTextField/custom_email_field.dart';
import 'package:nodelabscase/Components/CustomTextField/custom_name_field.dart';
import 'package:nodelabscase/Components/CustomTextField/custom_password_field.dart';
import 'package:nodelabscase/Components/CustomViews/circular_indicator_view.dart';
import 'package:nodelabscase/Components/CustomViews/custom_background_view.dart';
import 'package:nodelabscase/Components/CustomViews/custom_snackbar_view.dart';
import 'package:nodelabscase/Core/Theme/app_icons.dart';
import 'package:nodelabscase/View/Entrance/login_page.dart';
import 'package:provider/provider.dart';
import '../../Core/Theme/app_typography.dart';
import '../../ViewModel/auth_view_model.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
  TextEditingController();

  bool accepted = false;
  bool isButtonActive = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_validateForm);
    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
    _repeatPasswordController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  // TAG - VALIDATE FORM
  void _validateForm() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final repeatPassword = _repeatPasswordController.text;

    final isNameValid = name.length >= 2;
    final isEmailValid =
    RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email); // basit email kontrolü
    final isPasswordValid = password.length >= 6;
    final isRepeatValid = repeatPassword == password && repeatPassword.isNotEmpty;

    final canRegister =
        isNameValid && isEmailValid && isPasswordValid && isRepeatValid && accepted;

    setState(() {
      isButtonActive = canRegister;
    });
  }

  // TAG - REGISTER BUTTON PRESSED
  Future<void> _onRegisterPressed() async {
    final password = _passwordController.text;
    final repeatPassword = _repeatPasswordController.text;
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty || repeatPassword.isEmpty) {
      CustomSnackBar.show(context, "Please fill in all fields.");
      return;
    }

    if (password != repeatPassword) {
      CustomSnackBar.show(context, "Given passwords do not match.");
      return;
    }

    if (!accepted) {
      CustomSnackBar.show(context, "Please accept the terms and conditions.");
      return;
    }

    if (kDebugMode) {
      print("DEBUG -> Register button tapped!");
    }

    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    try {
      setState(() {
        isLoading = true;
      });
      await authViewModel.registerUser(
        _emailController.text.trim(),
        _nameController.text.trim(),
        _passwordController.text,
      );

      if (authViewModel.currentUser != null) {
        setState(() {
          isLoading = false;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } else {
        setState(() {
          isLoading = false;
        });
        CustomSnackBar.show(context, "Registration failed. Please try again...");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      CustomSnackBar.show(context, "Something Wrong: $e");
    }

  }


  // MARK - SCAFFOLD UI STARTS
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
                  const SizedBox(height: 50),

                  // TAG - 1 - APP ICON
                  SvgPicture.asset("assets/images/shartflixIcon.svg"),
                  const SizedBox(height: 10),

                  // TAG - 2 - EXPLANATION TEXTS
                  const Text("Create Account", style: AppTypography.h3),
                  const SizedBox(height: 10),
                  const Text("Insert your details to create your account",
                      style: AppTypography.bodyMediumRegular),

                  const SizedBox(height: 30),

                  // TAG - 3 - TEXT FIELDS
                  CustomNameField(
                    controller: _nameController,
                  ),
                  const SizedBox(height: 20),
                  CustomEmailField(
                    controller: _emailController,
                  ),
                  const SizedBox(height: 20),
                  CustomPasswordField(
                    controller: _passwordController,
                  ),
                  const SizedBox(height: 20),
                  CustomPasswordField(
                    controller: _repeatPasswordController,
                    hintText: "Repeat Password",
                  ),

                  const SizedBox(height: 30),

                  // TAG - 4 - CHECKBOX
                  SizedBox(
                    width: 354,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomCheckboxButton(
                          initialValue: accepted,
                          onChanged: (value) {
                            setState(() {
                              accepted = value;
                              _validateForm();
                            });
                          },
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: RichText(
                            text: const TextSpan(
                              style: AppTypography.bodyMediumRegular,
                              children: [
                                TextSpan(text: "Terms of Use "),
                                TextSpan(
                                  text: "I read and accept",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                  ". Please continue after reading the agreement.",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // TAG - 5 - REGISTER BUTTON
                  PrimaryLargeButton(
                    buttonText: "Register",
                    onPressed: () async {
                      await _onRegisterPressed();
                    },
                    isActive: isButtonActive,
                  ),

                  const SizedBox(height: 20),

                  // TAG - 6 - SOCIAL MEDIA BUTTONS
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 20,
                    children: [
                      SocialMediaButton(
                          buttonIcon: AppIcons.google,
                          onPressed: () {
                            if (kDebugMode) {
                              print("DEBUG -> Google Button Tapped!");
                            }
                          }),
                      SocialMediaButton(
                          buttonIcon: AppIcons.apple,
                          onPressed: () {
                            if (kDebugMode) {
                              print("DEBUG -> Apple Button Tapped!");
                            }
                          }),
                      SocialMediaButton(
                          buttonIcon: AppIcons.facebook,
                          onPressed: () {
                            if (kDebugMode) {
                              print("DEBUG -> Facebook Button Tapped!");
                            }
                          }),
                    ],
                  ),

                  // TAG - 7 - SIGN IN TEXT BUTTON
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("I have an account. ",
                          style: AppTypography.bodyMediumRegular),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginPage()),
                          );
                        },
                        child: const Text("Log In",
                            style: AppTypography.bodyMediumBold),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),

          if (isLoading) const CircularIndicatorView(),
        ],

      ),
    );
  }
}
