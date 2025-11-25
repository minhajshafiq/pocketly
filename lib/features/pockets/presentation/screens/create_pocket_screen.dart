import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pocketly/core/widgets/animated_page_header.dart';
import 'package:pocketly/core/widgets/platform_safe_area.dart';
import 'package:pocketly/core/widgets/app_card.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_typography.dart';
import 'package:pocketly/features/pockets/domain/entities/pocket_entity.dart';
import 'package:pocketly/features/pockets/presentation/screens/add_expense_pocket_screen.dart';
import 'package:pocketly/features/pockets/presentation/screens/add_savings_pocket_screen.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';

/// Écran de création d'un pocket
/// Permet de choisir la catégorie (needs/wants/savings) puis redirige vers le bon formulaire
class CreatePocketScreen extends ConsumerStatefulWidget {
  const CreatePocketScreen({super.key});

  @override
  ConsumerState<CreatePocketScreen> createState() =>
      _CreatePocketScreenState();
}

class _CreatePocketScreenState extends ConsumerState<CreatePocketScreen> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _navigateToForm(PocketCategory category) {
    if (category == PocketCategory.savings) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const AddSavingsPocketScreen(),
        ),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => AddExpensePocketScreen(category: category),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isIOS = Platform.isIOS;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      body: PlatformSafeArea(
        top: true,
        bottom: null, // Auto: true sur Android, false sur iOS
        padding: EdgeInsets.only(top: AppDimensions.paddingS),
        child: Stack(
          children: [
            // Contenu scrollable
            ListView(
              controller: _scrollController,
              padding: EdgeInsets.only(
                top: 80 + AppDimensions.paddingM, // Header + padding
                left: AppDimensions.paddingM,
                right: AppDimensions.paddingM,
                bottom: Platform.isAndroid 
                    ? AppDimensions.paddingXL * 2 // Plus d'espace pour les boutons Android
                    : AppDimensions.paddingXL,
              ),
            children: [
              // Header
              Text(
                l10n.selectPocketCategory,
                  style: AppTypography.heading.copyWith(
                    color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                ),
                ).animate().fadeIn().slideY(begin: -0.2, end: 0),
                SizedBox(height: AppDimensions.paddingS),
              Text(
                l10n.selectPocketCategoryDescription,
                  style: AppTypography.body.copyWith(
                    color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
                ),
                ).animate().fadeIn(delay: 100.ms).slideY(begin: -0.2, end: 0),
                SizedBox(height: AppDimensions.paddingXL),

              // Category cards
                    _buildCategoryCard(
                      context: context,
                      l10n: l10n,
                      isIOS: isIOS,
                  isDark: isDark,
                      category: PocketCategory.needs,
                      title: l10n.pocketCategoryNeeds,
                      description: l10n.needsDescription,
                      icon: Icons.restaurant,
                      color: const Color(0xFFF48A99),
                      percentage: '50%',
                ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.2, end: 0),
                SizedBox(height: AppDimensions.paddingM),
                    _buildCategoryCard(
                      context: context,
                      l10n: l10n,
                      isIOS: isIOS,
                  isDark: isDark,
                      category: PocketCategory.wants,
                      title: l10n.pocketCategoryWants,
                      description: l10n.wantsDescription,
                      icon: Icons.celebration,
                      color: const Color(0xFF78D078),
                      percentage: '30%',
                ).animate().fadeIn(delay: 300.ms).slideX(begin: -0.2, end: 0),
                SizedBox(height: AppDimensions.paddingM),
                    _buildCategoryCard(
                      context: context,
                      l10n: l10n,
                      isIOS: isIOS,
                  isDark: isDark,
                      category: PocketCategory.savings,
                      title: l10n.pocketCategorySavings,
                      description: l10n.savingsDescription,
                      icon: Icons.savings,
                      color: const Color(0xFF6BC6EA),
                      percentage: '20%',
                ).animate().fadeIn(delay: 400.ms).slideX(begin: -0.2, end: 0),
                  ],
            ),

            // Header sticky animé
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AnimatedPageHeader(
                title: l10n.createPocket,
                scrollController: _scrollController,
                showBackButton: true,
                ),
              ),
            ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard({
    required BuildContext context,
    required AppLocalizations l10n,
    required bool isIOS,
    required bool isDark,
    required PocketCategory category,
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required String percentage,
  }) {
    return AppCard(
      onTap: () {
        HapticFeedback.lightImpact();
        _navigateToForm(category);
      },
      backgroundColor: isDark
          ? color.withOpacity(0.15)
          : color.withOpacity(0.08),
      borderColor: color.withOpacity(isDark ? 0.4 : 0.3),
      padding: EdgeInsets.all(AppDimensions.paddingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
              // Icon container with gradient effect
                Container(
                padding: EdgeInsets.all(AppDimensions.paddingM),
                  decoration: BoxDecoration(
                    color: color,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                  size: AppDimensions.iconL,
                ),
              ),
              SizedBox(width: AppDimensions.paddingM),
                // Title and percentage
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                      style: AppTypography.title.copyWith(
                          color: color,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: AppDimensions.paddingXS),
                      Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimensions.paddingS,
                        vertical: AppDimensions.paddingXS,
                        ),
                        decoration: BoxDecoration(
                        color: color.withOpacity(isDark ? 0.3 : 0.2),
                        borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                        ),
                        child: Text(
                          percentage,
                        style: AppTypography.caption.copyWith(
                            color: color,
                          fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Arrow icon
                Icon(
                  isIOS
                      ? CupertinoIcons.chevron_right
                      : Icons.arrow_forward_ios,
                  color: color,
                size: AppDimensions.iconS,
                ),
              ],
            ),
          SizedBox(height: AppDimensions.paddingM),
            // Description
            Text(
              description,
            style: AppTypography.body.copyWith(
              color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
              height: 1.5,
              ),
            ),
          ],
      ),
    );
  }
}
