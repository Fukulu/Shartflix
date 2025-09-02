import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nodelabscase/Components/CustomButtons/custom_checkBox_button.dart';
import 'package:nodelabscase/Components/CustomButtons/like_button.dart';
import 'package:nodelabscase/Components/CustomButtons/primary_large_button.dart';
import 'package:nodelabscase/Components/CustomButtons/social_media_button.dart';
import 'package:nodelabscase/Components/CustomButtons/x_mark_button.dart';
import 'package:nodelabscase/Components/CustomTabBar/custom_tab_bar.dart';
import 'package:nodelabscase/Components/CustomTextField/custom_email_field.dart';
import 'package:nodelabscase/Components/CustomTextField/custom_password_field.dart';
import 'package:nodelabscase/Core/Theme/app_colors.dart';
import 'package:nodelabscase/Core/Theme/app_icons.dart';
import 'package:nodelabscase/Core/Theme/app_theme.dart';
import 'package:provider/provider.dart';

import 'Components/CustomButtons/back_chevron_button.dart';
import 'Components/CustomButtons/secondary_large_button.dart';
import 'View/Splash/splash_screen_page.dart';
import 'ViewModel/auth_view_model.dart';

void main() {

  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider<AuthViewModel>(
              create: (context) => AuthViewModel()
            )
          ],
      child: MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shartflix App',
      theme: AppTheme.theme,
      home: const SplashScreenPage(),
    );
  }
}
