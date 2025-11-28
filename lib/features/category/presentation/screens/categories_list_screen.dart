import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pocketly/core/widgets/animated_page_header.dart';
import 'package:pocketly/core/widgets/platform_safe_area.dart';
import 'package:pocketly/core/widgets/app_card.dart';
import 'package:pocketly/core/widgets/app_button.dart';
import 'package:pocketly/core/widgets/error_display.dart';
import 'package:pocketly/core/errors/app_error.dart';
import 'package:pocketly/core/errors/common_errors.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_typography.dart';
import 'package:pocketly/core/constants/app_icons.dart';
import 'package:pocketly/core/router/app_route_paths.dart';
import 'package:pocketly/features/category/domain/entities/category_entity.dart';
import 'package:pocketly/features/category/presentation/providers/category_provider.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:pocketly/features/user/user.dart';
import 'package:pocketly/features/subscription/domain/entities/subscription_status_entity.dart';
import 'package:pocketly/features/subscription/presentation/providers/subscription_providers.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

/// Bouton de type individuel avec animation fluide
/// Style harmonisé avec _PeriodButton et _FilterButton
class _TypeButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _TypeButton({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingM,
          vertical: AppDimensions.paddingS,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(28.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? AppColors.primary
                  : (isDark
                        ? AppColors.textSecondaryOnDark
                        : AppColors.textSecondary),
              size: AppDimensions.iconM,
            ),
            SizedBox(width: AppDimensions.paddingS),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              style: AppTypography.small.copyWith(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected
                    ? AppColors.primary
                    : (isDark
                          ? AppColors.textSecondaryOnDark
                          : AppColors.textSecondary),
              ),
              child: Text(
                label,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Écran de liste des catégories
/// Permet de visualiser toutes les catégories (par défaut et custom)
/// Les utilisateurs premium peuvent éditer leurs catégories custom
class CategoriesListScreen extends ConsumerStatefulWidget {
  const CategoriesListScreen({super.key});

  @override
  ConsumerState<CategoriesListScreen> createState() =>
      _CategoriesListScreenState();
}

class _CategoriesListScreenState extends ConsumerState<CategoriesListScreen> {
  final _scrollController = ScrollController();
  CategoryType _selectedType = CategoryType.expense;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Gère l'affichage du paywall et la synchronisation après achat
  Future<void> _handleUpgradePremium() async {
    try {
      final paywallResult = await RevenueCatUI.presentPaywall();

      if (paywallResult == PaywallResult.purchased ||
          paywallResult == PaywallResult.restored) {

        // Récupérer les infos actualisées
        final customerInfo = await Purchases.getCustomerInfo();
        final hasActiveSubscription = customerInfo.entitlements.active.isNotEmpty;

        if (hasActiveSubscription) {
          // Synchroniser avec Supabase
          await ref
              .read(subscriptionRepositoryProvider)
              .syncSubscriptionToBackend(
                _parseCustomerInfoToStatus(customerInfo),
              );
        }

        // Rafraîchir l'UI
        ref.invalidate(currentUserProvider);
        ref.invalidate(canAccessPremiumProvider);
      }
    } catch (e) {
      // Erreur silencieuse
    }
  }

  SubscriptionStatusEntity _parseCustomerInfoToStatus(CustomerInfo customerInfo) {
    final entitlements = customerInfo.entitlements.active;

    if (entitlements.isEmpty) {
      return const SubscriptionStatusEntity(
        status: SubscriptionStatus.free,
        isPremium: false,
      );
    }

    final entitlement = entitlements.values.first;

    return SubscriptionStatusEntity(
      status: SubscriptionStatus.premium,
      isPremium: true,
      expirationDate: entitlement.expirationDate != null
          ? DateTime.parse(entitlement.expirationDate!)
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isIOS = Platform.isIOS;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final canAccessPremium = ref.watch(canAccessPremiumProvider);
    final categoriesAsync = ref.watch(categoryProvider);

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      body: PlatformSafeArea(
        top: true,
        bottom: null, // Auto: true sur Android, false sur iOS
        padding: EdgeInsets.only(top: AppDimensions.paddingS),
        child: Stack(
          children: [
            // Contenu scrollable
            RefreshIndicator(
              onRefresh: () async {
                await ref
                    .read(categoryProvider.notifier)
                    .refreshCategories();
              },
              child: ListView(
                controller: _scrollController,
                padding: EdgeInsets.only(
                  top: 80 + AppDimensions.paddingM, // Header + padding
                  left: AppDimensions.paddingM,
                  right: AppDimensions.paddingM,
                  bottom: Platform.isAndroid
                      ? 100 +
                            AppDimensions
                                .paddingXL // Pour le FAB + boutons Android
                      : 100, // Pour le FAB
                ),
                children: [
                  // Type selector (Income/Expense)
                  _buildTypeSelector(l10n, isIOS, isDark),
                  SizedBox(height: AppDimensions.paddingL),

                  // Liste des catégories
                  categoriesAsync.when(
                    data: (categories) {
                      final filteredCategories = categories
                          .where((cat) => cat.type == _selectedType)
                          .toList();

                      if (filteredCategories.isEmpty) {
                        return _buildEmptyState(l10n, isDark);
                      }

                      // Séparer les catégories par défaut et custom
                      final defaultCategories = filteredCategories
                          .where((cat) => cat.isDefault)
                          .toList();
                      final customCategories = filteredCategories
                          .where((cat) => cat.isCustom)
                          .toList();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Catégories par défaut
                          if (defaultCategories.isNotEmpty) ...[
                            Text(
                              l10n.defaultCategories,
                              style: AppTypography.heading.copyWith(
                                color: isDark
                                    ? AppColors.textOnDark
                                    : AppColors.textPrimary,
                              ),
                            ).animate().fadeIn().slideY(begin: -0.2, end: 0),
                            SizedBox(height: AppDimensions.paddingM),
                            ...defaultCategories.asMap().entries.map((entry) {
                              final index = entry.key;
                              final category = entry.value;
                              return Padding(
                                padding: EdgeInsets.only(
                                  bottom: AppDimensions.paddingM,
                                ),
                                child: _buildCategoryCard(
                                  category: category,
                                  l10n: l10n,
                                  isDark: isDark,
                                  isIOS: isIOS,
                                  canEdit: false,
                                  index: index,
                                ),
                              );
                            }),
                            SizedBox(height: AppDimensions.paddingL),
                          ],

                          // Catégories custom
                          Row(
                                children: [
                                  Text(
                                    l10n.customCategories,
                                    style: AppTypography.heading.copyWith(
                                      color: isDark
                                          ? AppColors.textOnDark
                                          : AppColors.textPrimary,
                                    ),
                                  ),
                                  SizedBox(width: AppDimensions.paddingS),
                                  if (!canAccessPremium)
                                    Icon(
                                      AppIcons.premium,
                                      color: const Color(
                                        0xFFFFD700,
                                      ), // Gold color for premium
                                      size: AppDimensions.iconM,
                                    ),
                                  const Spacer(),
                                  if (customCategories.isNotEmpty)
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: AppDimensions.paddingM,
                                        vertical: AppDimensions.paddingXS,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.primary.withValues(
                                          alpha: 0.1,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          AppDimensions.radiusL,
                                        ),
                                      ),
                                      child: Text(
                                        '${customCategories.length}',
                                        style: AppTypography.caption.copyWith(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                ],
                              )
                              .animate()
                              .fadeIn(delay: 200.ms)
                              .slideY(begin: -0.2, end: 0),
                          SizedBox(height: AppDimensions.paddingM),

                          if (customCategories.isEmpty) ...[
                            // Message si aucune catégorie personnalisée
                            _buildEmptyCustomCategoriesCard(
                              l10n,
                              isDark,
                              canAccessPremium,
                            ),
                          ] else ...[
                            // Liste des catégories personnalisées
                            ...customCategories.asMap().entries.map((entry) {
                              final index =
                                  entry.key + defaultCategories.length;
                              final category = entry.value;
                              return Padding(
                                padding: EdgeInsets.only(
                                  bottom: AppDimensions.paddingM,
                                ),
                                child: _buildCategoryCard(
                                  category: category,
                                  l10n: l10n,
                                  isDark: isDark,
                                  isIOS: isIOS,
                                  canEdit: canAccessPremium,
                                  index: index,
                                ),
                              );
                            }),
                          ],
                        ],
                      );
                    },
                    loading: () => Center(
                      child: Padding(
                        padding: EdgeInsets.all(AppDimensions.paddingXL),
                        child: isIOS
                            ? const CupertinoActivityIndicator()
                            : const CircularProgressIndicator(),
                      ),
                    ),
                    error: (error, stack) => ErrorDisplay(
                      error: error is AppError
                          ? error
                          : UnknownError(technicalMessage: error.toString()),
                      onRetry: () {
                        ref
                            .read(categoryProvider.notifier)
                            .refreshCategories();
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Header sticky animé
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AnimatedPageHeader(
                title: l10n.categories,
                scrollController: _scrollController,
                showBackButton: true,
              ),
            ),

            // FAB pour créer une catégorie
            Positioned(
              bottom: AppDimensions.paddingL,
              right: AppDimensions.paddingM,
              child: _buildCreateButton(l10n, isDark, canAccessPremium),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeSelector(AppLocalizations l10n, bool isIOS, bool isDark) {
    final types = [CategoryType.expense, CategoryType.income];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingS,
        vertical: AppDimensions.paddingS,
      ),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.2)
                : Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: types.map((type) {
          final isSelected = _selectedType == type;
          final label = type == CategoryType.expense
              ? l10n.expenses
              : l10n.incomes;

          return Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingXS,
              ),
              child: _TypeButton(
                label: label,
                icon: type == CategoryType.expense
                    ? LucideIcons.trendingDown
                    : LucideIcons.trendingUp,
                isSelected: isSelected,
                onTap: () {
                  HapticFeedback.lightImpact();
                  setState(() {
                    _selectedType = type;
                  });
                },
              ),
            ),
          );
        }).toList(),
      ),
    ).animate().fadeIn().slideY(begin: -0.2, end: 0);
  }

  Widget _buildCategoryCard({
    required CategoryEntity category,
    required AppLocalizations l10n,
    required bool isDark,
    required bool isIOS,
    required bool canEdit,
    required int index,
  }) {
    final color = Color(int.parse(category.color.replaceFirst('#', '0xFF')));
    // Utiliser getPocketIcon car les catégories utilisent les mêmes codes d'icônes que les pockets
    final iconData = AppIcons.getPocketIcon(category.iconName);

    return AppCard(
      onTap: canEdit && category.isCustom
          ? () {
              HapticFeedback.lightImpact();
              context.push(
                AppRoutePaths.editCategoryPath(category.id.toString()),
                extra: category,
              );
            }
          : null,
      padding: EdgeInsets.all(AppDimensions.paddingL),
      child: Row(
        children: [
          // Icon container - style harmonisé avec l'image
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            ),
            child: Icon(iconData, color: color, size: AppDimensions.iconL),
          ),
          SizedBox(width: AppDimensions.paddingM),

          // Name and type
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.getName(l10n),
                  style: AppTypography.title.copyWith(
                    color: isDark
                        ? AppColors.textOnDark
                        : AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: AppDimensions.paddingXS),
                Row(
                  children: [
                    Icon(
                      category.isCustom
                          ? AppIcons.custom
                          : AppIcons.defaultIcon,
                      size: AppDimensions.iconXS,
                      color: isDark
                          ? AppColors.textSecondaryOnDark
                          : AppColors.textSecondary,
                    ),
                    SizedBox(width: AppDimensions.paddingXS),
                    Text(
                      category.isCustom ? l10n.custom : l10n.defaultCategory,
                      style: AppTypography.caption.copyWith(
                        color: isDark
                            ? AppColors.textSecondaryOnDark
                            : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Arrow icon (only for editable custom categories)
          if (canEdit && category.isCustom)
            Icon(
              AppIcons.arrowRight,
              color: isDark
                  ? AppColors.textSecondaryOnDark
                  : AppColors.textSecondary,
              size: AppDimensions.iconS,
            ),
        ],
      ),
    ).animate().fadeIn(delay: (index * 50).ms).slideX(begin: -0.2, end: 0);
  }

  Widget _buildEmptyState(AppLocalizations l10n, bool isDark) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingXL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              LucideIcons.folderX,
              size: AppDimensions.iconXXL * 2,
              color: isDark
                  ? AppColors.textSecondaryOnDark
                  : AppColors.textTertiary,
            ),
            SizedBox(height: AppDimensions.paddingM),
            Text(
              l10n.noCategoriesFound,
              style: AppTypography.title.copyWith(
                color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppDimensions.paddingS),
            Text(
              l10n.noCategoriesFoundDescription,
              style: AppTypography.body.copyWith(
                color: isDark
                    ? AppColors.textSecondaryOnDark
                    : AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyCustomCategoriesCard(
    AppLocalizations l10n,
    bool isDark,
    bool canAccessPremium,
  ) {
    return AppCard(
          backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surface,
          borderColor: isDark
              ? AppColors.borderDark.withValues(alpha: 0.5)
              : AppColors.borderLight.withValues(alpha: 0.5),
          padding: EdgeInsets.all(AppDimensions.paddingXL),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                LucideIcons.sparkles,
                size: AppDimensions.iconXXL,
                color: canAccessPremium
                    ? AppColors.primary
                    : const Color(0xFFFFD700), // Gold for premium
              ),
              SizedBox(height: AppDimensions.paddingM),
              Text(
                canAccessPremium
                    ? l10n.noCustomCategoriesYet
                    : l10n.noCustomCategoriesPremium,
                style: AppTypography.title.copyWith(
                  color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppDimensions.paddingS),
              Text(
                canAccessPremium
                    ? l10n.noCustomCategoriesYetDescription
                    : l10n.noCustomCategoriesPremiumDescription,
                style: AppTypography.body.copyWith(
                  color: isDark
                      ? AppColors.textSecondaryOnDark
                      : AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppDimensions.paddingL),
              AppButton(
                text: canAccessPremium
                    ? l10n.createFirstCategory
                    : l10n.upgradeToPremium,
                onPressed: () async {
                  HapticFeedback.lightImpact();
                  if (canAccessPremium) {
                    context.push(
                      AppRoutePaths.createCategory,
                      extra: _selectedType,
                    );
                  } else {
                    await _handleUpgradePremium();
                  }
                },
                icon: canAccessPremium ? LucideIcons.plus : AppIcons.premium,
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: 250.ms)
        .scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1));
  }

  Widget _buildCreateButton(
    AppLocalizations l10n,
    bool isDark,
    bool canAccessPremium,
  ) {
    if (Platform.isIOS) {
      return Semantics(
        label: canAccessPremium ? l10n.createCategory : l10n.premiumRequired,
        button: true,
        child: CupertinoButton(
          padding: EdgeInsets.all(AppDimensions.paddingM),
          borderRadius: BorderRadius.circular(28),
          color: AppColors.primary,
          onPressed: () async {
            HapticFeedback.lightImpact();
            if (canAccessPremium) {
              context.push(AppRoutePaths.createCategory, extra: _selectedType);
            } else {
              await _handleUpgradePremium();
            }
          },
          child: Icon(
            canAccessPremium ? CupertinoIcons.add : AppIcons.premium,
            color: AppColors.textOnDark,
          ),
        ),
      ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.5, end: 0);
    }

    return Semantics(
      label: canAccessPremium ? l10n.createCategory : l10n.premiumRequired,
      button: true,
      child: FloatingActionButton(
        onPressed: () async {
          HapticFeedback.lightImpact();
          if (canAccessPremium) {
            context.push(AppRoutePaths.createCategory, extra: _selectedType);
          } else {
            await _handleUpgradePremium();
          }
        },
        backgroundColor: AppColors.primary,
        elevation: AppDimensions.elevationButton,
        shape: const CircleBorder(),
        child: Icon(
          canAccessPremium ? AppIcons.add : AppIcons.premium,
          color: AppColors.textOnDark,
        ),
      ),
    ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.5, end: 0);
  }
}
