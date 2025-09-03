import 'package:flutter/material.dart';
import 'package:nodelabscase/Core/Theme/app_theme.dart';
import 'package:nodelabscase/ViewModel/movie_view_model.dart';
import 'package:provider/provider.dart';
import 'View/Splash/splash_screen_page.dart';
import 'ViewModel/auth_view_model.dart';

void main() {

  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider<AuthViewModel>(
              create: (context) => AuthViewModel()
            ),
            ChangeNotifierProvider<MovieViewModel>(
              create: (context) => MovieViewModel()
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
