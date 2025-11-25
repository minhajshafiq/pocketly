import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/core/widgets/animated_page_header.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/features/user/user.dart';
import 'package:pocketly/features/settings/presentation/widgets/settings_section_header.dart';
import 'package:pocketly/features/settings/presentation/widgets/settings_preferences_card.dart';
import 'package:pocketly/features/settings/presentation/widgets/settings_logout_button.dart';
import 'package:pocketly/features/settings/presentation/widgets/settings_delete_account_button.dart';
import 'package:pocketly/features/settings/presentation/widgets/settings_legal_links.dart';
import 'package:pocketly/features/settings/presentation/widgets/settings_about_button.dart';
import 'package:pocketly/features/settings/presentation/widgets/settings_button_tile.dart';

/// Écran des paramètres de l'application
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final currentUserAsync = ref.watch(currentUserProvider);

    return Scaffold(
      body: PlatformSafeArea(
        top: true,
        bottom: false,
        padding: EdgeInsets.only(top: AppDimensions.paddingS),
        child: Stack(
          children: [
            // Contenu scrollable
            SingleChildScrollView(
              controller: _scrollController,
              padding: EdgeInsets.only(
                top: 80, // Espace pour le header
                left: AppDimensions.paddingL,
                right: AppDimensions.paddingL,
                bottom: AppDimensions.paddingL,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Section
                  SettingsSectionHeader(title: l10n.profile),
                  SizedBox(height: AppDimensions.paddingM),
                  currentUserAsync.when(
                    data: (user) => user != null
                        ? UserProfileCard(
                            user: user,
                            onEditTap: () => context.push(AppRoutePaths.editProfile),
                          )
                        : _buildProfileCardError(l10n),
                    loading: () => _buildProfileCardLoading(),
                    error: (error, stackTrace) => _buildProfileCardError(l10n),
                  ),

                  SizedBox(height: AppDimensions.paddingL),

                  // Preferences Section
                  SettingsSectionHeader(title: l10n.preferences),
                  SizedBox(height: AppDimensions.paddingM),
                  const SettingsPreferencesCard(),

                  SizedBox(height: AppDimensions.paddingL),

                  // Account Actions
                  SettingsSectionHeader(title: l10n.account),
                  SizedBox(height: AppDimensions.paddingM),
                  const SettingsLogoutButton(),

                  SizedBox(height: AppDimensions.paddingM),

                  // Delete Account (Danger Zone)
                  const SettingsDeleteAccountButton(),

                  SizedBox(height: AppDimensions.paddingL),

                  // Legal Section
                  SettingsSectionHeader(title: l10n.legal),
                  SizedBox(height: AppDimensions.paddingM),
                  const SettingsLegalLinks(),

                  SizedBox(height: AppDimensions.paddingL),

                  // About Section
                  SettingsSectionHeader(title: l10n.about),
                  SizedBox(height: AppDimensions.paddingM),
                  const SettingsAboutButton(),

                  SizedBox(height: AppDimensions.paddingL),

                  // Development/Test Section
                  SettingsSectionHeader(title: 'Développement'),
                  SizedBox(height: AppDimensions.paddingM),
                  _buildTestPaywallButton(context),
                ],
              ),
            ),

            // Header sticky animé
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AnimatedPageHeader(
                title: l10n.settings,
                scrollController: _scrollController,
                showBackButton: false, // Page principale, pas de bouton retour
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestPaywallButton(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.zero,
      child: SettingsButtonTile(
        icon: AppIcons.premium,
        title: 'Tester Paywall + Trial',
        onTap: () => context.push(AppRoutePaths.paywall),
        iconBackgroundColor: AppColors.secondary,
      ),
    );
  }

  Widget _buildProfileCardLoading() {
    return AppCard(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingL),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildProfileCardError(AppLocalizations l10n) {
    return AppCard(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingL),
        child: Text(
          l10n.errorLoadingProfile,
          style: AppTypography.body.copyWith(
            color: AppColors.error,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
