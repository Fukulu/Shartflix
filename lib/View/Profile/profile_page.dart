import 'package:flutter/material.dart';
import 'package:nodelabscase/Components/CustomButtons/limited_offer_button.dart';
import 'package:nodelabscase/Components/CustomViews/custom_background_view.dart';
import 'package:nodelabscase/Components/CustomViews/liked_cards_view.dart';
import 'package:nodelabscase/Components/CustomViews/profile_header.dart';
import 'package:nodelabscase/Core/Theme/app_typography.dart';
import 'package:nodelabscase/View/Profile/upload_photo_page.dart';
import 'package:provider/provider.dart';
import '../../Core/Theme/app_colors.dart';
import '../../ViewModel/auth_view_model.dart';
import '../../ViewModel/movie_view_model.dart';
import '../Entrance/login_page.dart';
import '../Offer/limited_offer_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: CustomBackgroundView(
        child: Consumer2<AuthViewModel, MovieViewModel>(
          builder: (context, authVM, movieVM, child) {
            final user = authVM.currentUser;
        
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
        
                  // TAG - HEADER
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row (
                        children: [
                          const Text("Profile", style: AppTypography.h4),
                          IconButton(
                              onPressed: () async {
                                await authVM.logout();
                                if (mounted) {
                                  movieVM.reset();
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (context) => const LoginPage()),
                                        (route) => false,
                                  );
                                }
                              },
                              icon: const Icon(
                                Icons.logout_rounded,
                                color: AppColors.white,)
                          )
                        ],
                      ),
                      LimitedOfferButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) => const LimitedOfferPage(),
                            );
                        }
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
        
                  // TAG - USER INFO
                  if (user != null)
                    ProfileHeader(
                      photoUrl: user.photoUrl,
                      name: user.name,
                      userId: user.id.substring(user.id.length - 6).toUpperCase(),
                      onAddPhoto: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const UploadPhotoPage()),
                        );
                      },
                    ),

                  const SizedBox(height: 15),

                  Container(width: double.infinity, height: 1, color: Colors.white24),
        
                  const SizedBox(height: 15),
        
                  // TAG - FAVORITE MOVIES TITLE
                  const Text("Favorites", style: AppTypography.h4),
        
                  // TAG - FAVORITE MOVIES LIST
                  Expanded(
                    child: RefreshIndicator(
                      color: AppColors.primary,
                      backgroundColor: AppColors.black,
                      onRefresh: () async {
                        final movieVM = Provider.of<MovieViewModel>(context, listen: false);
                        await movieVM.fetchFavorites();
                      },
                      child: movieVM.favoriteMovies.isEmpty
                          ? const Center(
                            child: Text("No favorite movies yet.",
                                style: AppTypography.bodyMediumRegular))
                          : GridView.builder(
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: movieVM.favoriteMovies.length,
                        itemBuilder: (context, index) {
                          final movie = movieVM.favoriteMovies[index];
                          return LikedCardView(
                            imageUrl: movie.posterUrl,
                            title: movie.title,
                            subtitle: movie.director,
                          );
                        },
                      ),
                    )
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
