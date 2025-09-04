import 'package:flutter/material.dart';
import 'package:nodelabscase/Core/Theme/app_colors.dart';
import 'package:nodelabscase/Core/Theme/app_typography.dart';

class LikedCardView extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final double width;
  final double height;
  final double borderRadius;
  final VoidCallback? onTap;

  const LikedCardView({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    this.width = 169,
    this.height = 196,
    this.borderRadius = 16,
    this.onTap,
  });

  String _safeUrl(String url) =>
      url.startsWith('http://') ? url.replaceFirst('http://', 'https://') : url;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.network(
                  _safeUrl(imageUrl),
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: Colors.white.withOpacity(0.06),
                      child: const Center(
                        child: SizedBox(
                          width: 28,
                          height: 28,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stack) {
                    return Container(
                      color: Colors.white.withOpacity(0.06),
                      child: const Center(
                        child: Icon(Icons.broken_image_outlined,
                            color: Colors.white70, size: 32),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 12),

            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.bodyLargeSemiBold
            ),

            const SizedBox(height: 4),

            Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.bodyMediumRegular
            ),
          ],
        ),
      ),
    );
  }
}
