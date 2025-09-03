import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nodelabscase/Components/CustomButtons/like_button.dart';
import 'package:nodelabscase/Components/CustomTabBar/custom_tab_bar.dart';
import 'package:nodelabscase/Components/CustomViews/blurred_background_view.dart';
import 'package:nodelabscase/Components/CustomViews/circular_indicator_view.dart';
import 'package:nodelabscase/Components/CustomViews/expandable_text_view.dart';
import 'package:provider/provider.dart';
import '../../Core/Theme/app_colors.dart';
import '../../Core/Theme/app_typography.dart';
import '../../ViewModel/movie_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  void _onTabChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    final movieVM = Provider.of<MovieViewModel>(context, listen: false);
    Future.microtask(() => movieVM.fetchMovies(page: 1));

    _pageController.addListener(() {
      final movieVM = Provider.of<MovieViewModel>(context, listen: false);
      final currentIndex = _pageController.page?.round() ?? 0;
      if ((currentIndex + 1) % 5 == 0) {
        movieVM.currentPage += 1;
        movieVM.fetchMovies(page: movieVM.currentPage);
      }
    });
  }


  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Consumer<MovieViewModel>(
        builder: (context, movieVM, child) {
          if (movieVM.isLoading && movieVM.movies.isEmpty) {
            return const CircularIndicatorView();
          }

          if (movieVM.movies.isEmpty) {
            return const Center(child: Text("Film bulunamadı"));
          }

          return Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.vertical,
                itemCount: movieVM.movies.length,
                itemBuilder: (context, index) {
                  final movie = movieVM.movies[index];
                  final posterUrl = movie.posterUrl.startsWith("http://")
                      ? movie.posterUrl.replaceFirst("http://", "https://")
                      : movie.posterUrl;

                  return Stack(
                    children: [
                      // TAG - BACKGROUND IMAGE
                      BlurredBackground(image: posterUrl),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // TAG - LIKE BUTTON
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                LikeButton(
                                  onPressed: () {
                                    if (kDebugMode) {
                                      print("DEBUG -> Like ${movie.title}");
                                    }
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),

                            // TAG - MOVIE TITLE & DESCRIPTION
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset("assets/images/circleN.svg"),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        movie.title,
                                        style: AppTypography.h3
                                            .copyWith(color: Colors.white),
                                      ),
                                      const SizedBox(height: 8),
                                      ExpandableText(
                                        text: movie.description,
                                        trimLines: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 100),

                          ],
                        ),
                      ),

                    ],
                  );
                },
              ),

              // TAG - CUSTOM TAB BAR
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomTabBar(
                      initialIndex: _selectedIndex,
                      onTabChanged: _onTabChanged,
                    ),
                  ],
                ),
              ),

              if (movieVM.isLoading)
                const Positioned(
                  bottom: 100,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}