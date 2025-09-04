import 'package:flutter/material.dart';
import 'package:nodelabscase/Core/Theme/app_typography.dart';

import '../../Core/Theme/app_colors.dart';

class ProfileHeader extends StatelessWidget {
  final String? photoUrl;
  final String name;
  final String userId;
  final VoidCallback onAddPhoto;

  const ProfileHeader({
    super.key,
    required this.photoUrl,
    required this.name,
    required this.userId,
    required this.onAddPhoto,
  });

  String _safeUrl(String url) =>
      url.startsWith("http://") ? url.replaceFirst("http://", "https://") : url;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      color: Colors.transparent,
      child: Row(
        children: [

          CircleAvatar(
            radius: 32,
            backgroundColor: Colors.grey.shade800,
            backgroundImage: (photoUrl != null && photoUrl!.isNotEmpty)
                ? NetworkImage(_safeUrl(photoUrl!))
                : null,
            child: (photoUrl == null || photoUrl!.isEmpty)
                ? const Icon(Icons.person, color: Colors.white, size: 32)
                : null,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTypography.bodyLargeSemiBold,
                ),
                const SizedBox(height: 4),
                Text(
                  "ID: $userId",
                  style: AppTypography.bodyMediumRegular
                      .copyWith(color: Colors.white60),
                ),
              ],
            ),
          ),

          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: AppColors.white10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
            ),
            onPressed: onAddPhoto,
            child: const Text(
              "Add Photo",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
