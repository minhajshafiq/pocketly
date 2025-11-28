import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/core/widgets/animated_page_header.dart';
import 'package:pocketly/features/notifications/presentation/providers/notification_preferences_provider.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';

/// Écran des préférences de notifications
class NotificationPreferencesScreen extends ConsumerStatefulWidget {
  const NotificationPreferencesScreen({super.key});

  @override
  ConsumerState<NotificationPreferencesScreen> createState() =>
      _NotificationPreferencesScreenState();
}

class _NotificationPreferencesScreenState
    extends ConsumerState<NotificationPreferencesScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final preferencesAsync = ref.watch(notificationPreferencesProvider);

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
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
                top: 80 + AppDimensions.paddingM, // Header + padding
                left: AppDimensions.paddingM,
                right: AppDimensions.paddingM,
                bottom: AppDimensions.paddingM,
              ),
              child: preferencesAsync.when(
                data: (preferences) => preferences != null
                    ? _buildPreferencesList(context, l10n, isDark, preferences)
                    : _buildEmptyState(l10n, isDark),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, stack) => ErrorDisplay(
                  error: error is AppError
                      ? error
                      : UnknownError(
                          technicalMessage: error.toString(),
                          stackTrace: stack,
                        ),
                  onRetry: () {
                    ref.invalidate(notificationPreferencesProvider);
                  },
                ),
              ),
            ),

            // Header sticky animé
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AnimatedPageHeader(
                title: l10n.notificationsSettings,
                scrollController: _scrollController,
                showBackButton: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreferencesList(
    BuildContext context,
    AppLocalizations l10n,
    bool isDark,
    preferences,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // En-tête avec description
        AppCard(
          padding: EdgeInsets.all(AppDimensions.paddingL),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(AppDimensions.paddingM),
                decoration: BoxDecoration(
                  color: AppColors.info.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Platform.isIOS ? CupertinoIcons.bell : Icons.notifications_outlined,
                  color: AppColors.info,
                  size: 24,
                ),
              ),
              SizedBox(width: AppDimensions.paddingM),
              Expanded(
                child: Text(
                  l10n.enableNotificationsPrompt,
                  style: AppTypography.body.copyWith(
                    color: isDark
                        ? AppColors.textOnDark
                        : AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: AppDimensions.paddingL),

        // Types de notifications
        Text(
          l10n.notificationTypes,
          style: AppTypography.heading.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),

        SizedBox(height: AppDimensions.paddingM),

        // Liste des préférences
        AppCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              _buildPreferenceItem(
                context: context,
                l10n: l10n,
                isDark: isDark,
                icon: Icons.trending_up,
                iconColor: AppColors.error,
                title: l10n.budgetExceededNotif,
                description: l10n.budgetExceededNotifDesc,
                value: preferences.budgetExceededEnabled,
                onChanged: (value) {
                  ref.read(notificationPreferencesProvider.notifier).updatePreference(
                        budgetExceededEnabled: value,
                      );
                },
              ),
              _buildDivider(isDark),
              _buildPreferenceItem(
                context: context,
                l10n: l10n,
                isDark: isDark,
                icon: Icons.emoji_events_outlined,
                iconColor: AppColors.success,
                title: l10n.goalReachedNotif,
                description: l10n.goalReachedNotifDesc,
                value: preferences.goalReachedEnabled,
                onChanged: (value) {
                  ref.read(notificationPreferencesProvider.notifier).updatePreference(
                        goalReachedEnabled: value,
                      );
                },
              ),
              _buildDivider(isDark),
              _buildPreferenceItem(
                context: context,
                l10n: l10n,
                isDark: isDark,
                icon: Icons.calendar_today_outlined,
                iconColor: AppColors.warning,
                title: l10n.monthEndReminderNotif,
                description: l10n.monthEndReminderNotifDesc,
                value: preferences.monthEndReminderEnabled,
                onChanged: (value) {
                  ref.read(notificationPreferencesProvider.notifier).updatePreference(
                        monthEndReminderEnabled: value,
                      );
                },
              ),
              _buildDivider(isDark),
              _buildPreferenceItem(
                context: context,
                l10n: l10n,
                isDark: isDark,
                icon: Icons.bar_chart_outlined,
                iconColor: AppColors.info,
                title: l10n.weeklySummaryNotif,
                description: l10n.weeklySummaryNotifDesc,
                value: preferences.weeklySummaryEnabled,
                onChanged: (value) {
                  ref.read(notificationPreferencesProvider.notifier).updatePreference(
                        weeklySummaryEnabled: value,
                      );
                },
              ),
              _buildDivider(isDark),
              _buildPreferenceItem(
                context: context,
                l10n: l10n,
                isDark: isDark,
                icon: Icons.assessment_outlined,
                iconColor: AppColors.primary,
                title: l10n.monthlyReportNotif,
                description: l10n.monthlyReportNotifDesc,
                value: preferences.monthlyReportEnabled,
                onChanged: (value) {
                  ref.read(notificationPreferencesProvider.notifier).updatePreference(
                        monthlyReportEnabled: value,
                      );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPreferenceItem({
    required BuildContext context,
    required AppLocalizations l10n,
    required bool isDark,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.all(AppDimensions.paddingM),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(AppDimensions.paddingS),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppDimensions.radiusS),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
          ),
          SizedBox(width: AppDimensions.paddingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.body.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: AppDimensions.paddingXS),
                Text(
                  description,
                  style: AppTypography.small.copyWith(
                    color: isDark
                        ? AppColors.textSecondaryOnDark
                        : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: AppDimensions.paddingM),
          if (Platform.isIOS)
            CupertinoSwitch(
              value: value,
              onChanged: onChanged,
              activeColor: iconColor,
            )
          else
            Switch(
              value: value,
              onChanged: onChanged,
              activeColor: iconColor,
            ),
        ],
      ),
    );
  }

  Widget _buildDivider(bool isDark) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
      child: Divider(
        height: 1,
        thickness: 0.5,
        color: isDark
            ? AppColors.borderDark.withValues(alpha: 0.3)
            : AppColors.borderLight.withValues(alpha: 0.3),
      ),
    );
  }

  Widget _buildEmptyState(AppLocalizations l10n, bool isDark) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingXL),
        child: Text(
          l10n.errorLoadingProfile,
          style: AppTypography.body.copyWith(
            color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
