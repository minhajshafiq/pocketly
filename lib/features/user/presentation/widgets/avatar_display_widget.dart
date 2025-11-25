import 'package:flutter/material.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_typography.dart';

/// Widget pour afficher un avatar utilisateur.
///
/// Affiche une image réseau si l'URL est fournie, sinon affiche
/// les initiales de l'utilisateur avec un gradient coloré.
class AvatarDisplayWidget extends StatelessWidget {
  const AvatarDisplayWidget({
    super.key,
    required this.avatarUrl,
    required this.userName,
    this.size = 50,
    this.onTap,
  });

  final String? avatarUrl;
  final String userName;
  final double size;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.secondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: _buildAvatarContent(isDark),
      ),
    );
  }

  Widget _buildAvatarContent(bool isDark) {
    if (avatarUrl != null && avatarUrl!.isNotEmpty) {
      return ClipOval(
        child: Image.network(
          avatarUrl!,
          fit: BoxFit.cover,
          width: size,
          height: size,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return _buildLoadingIndicator();
          },
          errorBuilder: (context, error, stackTrace) {
            // En cas d'erreur, afficher les initiales
            return _buildInitialsAvatar();
          },
        ),
      );
    }

    return _buildInitialsAvatar();
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: SizedBox(
        width: size * 0.4,
        height: size * 0.4,
        child: const CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }

  Widget _buildInitialsAvatar() {
    final initials = _getInitials(userName);
    final fontSize = size * 0.4;

    return Center(
      child: Text(
        initials,
        style: AppTypography.title.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
        ),
      ),
    );
  }

  /// Extrait les initiales du nom d'utilisateur
  String _getInitials(String name) {
    final words = name.trim().split(' ');
    if (words.isEmpty) {
      return 'U';
    }

    if (words.length == 1) {
      return words[0].isNotEmpty ? words[0][0].toUpperCase() : 'U';
    }

    final firstInitial = words[0].isNotEmpty ? words[0][0] : '';
    final secondInitial = words[1].isNotEmpty ? words[1][0] : '';

    return (firstInitial + secondInitial).toUpperCase();
  }
}
