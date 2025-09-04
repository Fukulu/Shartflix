import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nodelabscase/Components/CustomButtons/like_button.dart';
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

  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    final movieVM = Provider.of<MovieViewModel>(context, listen: false);
    Future.microtask(() async {
      await movieVM.fetchMovies(page: 1);
      await movieVM.fetchFavorites();
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
            return const Center(child: Text("No movies available"));
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

                  if ((index + 1) == movieVM.movies.length &&
                      movieVM.movies.length % 5 == 0 &&
                      !movieVM.isLoading) {
                    final nextPage = movieVM.currentPage + 1;
                    debugPrint("DEBUG -> Fetching Page $nextPage...");
                    movieVM.fetchMovies(page: nextPage);
                  }

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
                                  isSelected: movieVM.favoriteMovieIds.contains(movie.id),
                                  onPressed: () {
                                    movieVM.toggleFavorite(movie.id);
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        movie.title,
                                        style: AppTypography.h3.copyWith(color: Colors.white),
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

              if (movieVM.isLoading)
                const Positioned(
                  bottom: 100,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                ),

              if (movieVM.isFavoriteLoading)
                const CircularIndicatorView()

            ],
          );
        },
      ),
    );
  }
}