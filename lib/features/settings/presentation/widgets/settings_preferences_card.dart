import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_icons.dart';
import 'package:pocketly/core/constants/app_typography.dart';
import 'package:pocketly/core/widgets/app_card.dart';
import 'package:pocketly/core/widgets/platform_safe_area.dart';
import 'package:go_router/go_router.dart';
import 'package:pocketly/core/router/app_route_paths.dart';
import 'package:pocketly/features/currency/currency.dart';
import 'package:pocketly/features/locale/locale.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/features/settings/presentation/widgets/settings_button_tile.dart';
import 'package:pocketly/features/themes/themes.dart';

/// Widget pour la carte des préférences (langue et devise)
class SettingsPreferencesCard extends ConsumerWidget {
  const SettingsPreferencesCard({super.key});

  bool get _isIOS => !kIsWeb && Platform.isIOS;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          // Notifications
          SettingsButtonTile(
            icon: AppIcons.notification,
            title: l10n.notifications,
            onTap: () => context.push(AppRoutePaths.notificationPreferences),
            iconBackgroundColor: AppColors.secondary,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
            child: Divider(
            height: 1,
              thickness: 0.5,
            color: isDark 
                ? AppColors.borderDark.withValues(alpha: 0.3)
                : AppColors.borderLight.withValues(alpha: 0.3),
            ),
          ),
          // Thème
          Consumer(
            builder: (context, ref, child) {
              final currentTheme = ref.watch(themeProvider);
              return SettingsButtonTile(
                icon: _getThemeIcon(currentTheme),
                title: l10n.theme,
                subtitle: currentTheme.displayName,
                onTap: () => _showThemePicker(context, ref, l10n, currentTheme),
                iconBackgroundColor: AppColors.secondary,
              );
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
            child: Divider(
            height: 1,
              thickness: 0.5,
            color: isDark 
                ? AppColors.borderDark.withValues(alpha: 0.3)
                : AppColors.borderLight.withValues(alpha: 0.3),
            ),
          ),
          // Langue
          Consumer(
            builder: (context, ref, child) {
              final localeAsync = ref.watch(currentAppLocaleProvider);
              return localeAsync.when(
                data: (locale) => SettingsButtonTile(
                  icon: AppIcons.language,
                  title: l10n.language,
                  subtitle: locale.nativeName,
                  onTap: () => _showLanguagePicker(context, ref, l10n, locale),
                  iconBackgroundColor: AppColors.secondary,
                ),
                loading: () => SettingsButtonTile(
                  icon: AppIcons.language,
                  title: l10n.language,
                  subtitle: 'English',
                  onTap: () => _showLanguagePicker(context, ref, l10n, SupportedLocales.english),
                  iconBackgroundColor: AppColors.secondary,
                ),
                error: (error, stack) => SettingsButtonTile(
                  icon: AppIcons.language,
                  title: l10n.language,
                  subtitle: 'English',
                  onTap: () => _showLanguagePicker(context, ref, l10n, SupportedLocales.english),
                  iconBackgroundColor: AppColors.secondary,
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
            child: Divider(
            height: 1,
              thickness: 0.5,
            color: isDark 
                ? AppColors.borderDark.withValues(alpha: 0.3)
                : AppColors.borderLight.withValues(alpha: 0.3),
            ),
          ),
          // Devise
          Consumer(
            builder: (context, ref, child) {
              final currencyAsync = ref.watch(currencyProvider);
              return currencyAsync.when(
                data: (currency) => SettingsButtonTile(
                  icon: AppIcons.currency,
                  title: l10n.currency,
                  subtitle: '${currency.flag} ${currency.name} (${currency.symbol})',
                  onTap: () => _showCurrencyPicker(context, ref, l10n, currency.code),
                  iconBackgroundColor: AppColors.secondary,
                ),
                loading: () => SettingsButtonTile(
                  icon: AppIcons.currency,
                  title: l10n.currency,
                  subtitle: '🇪🇺 Euro (€)',
                  onTap: () => _showCurrencyPicker(context, ref, l10n, 'EUR'),
                  iconBackgroundColor: AppColors.secondary,
                ),
                error: (error, stack) => SettingsButtonTile(
                  icon: AppIcons.currency,
                  title: l10n.currency,
                  subtitle: '🇪🇺 Euro (€)',
                  onTap: () => _showCurrencyPicker(context, ref, l10n, 'EUR'),
                  iconBackgroundColor: AppColors.secondary,
                ),
              );
            },
          ),
        ],
      ),
    );
  }


  void _showLanguagePicker(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
    AppLocaleEntity currentLocale,
  ) {
    final locales = SupportedLocales.all;

    if (_isIOS) {
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          title: Text(l10n.selectLanguage),
          actions: locales.map((locale) {
            return CupertinoActionSheetAction(
              onPressed: () {
                ref.read(currentLocaleProvider.notifier).setLocale(locale);
                Navigator.pop(context);
              },
              isDefaultAction: locale.languageCode == currentLocale.languageCode,
              child: Text(locale.nativeName),
            );
          }).toList(),
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            isDestructiveAction: true,
            child: Text(l10n.cancel),
          ),
        ),
      );
    } else {
      showModalBottomSheet(
        context: context,
        useRootNavigator: true, // Passe au-dessus de la bottom nav
        builder: (context) => PlatformSafeArea(
          bottom: true, // Respecte les boutons de navigation Android
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(AppDimensions.paddingL),
                child: Text(
                  l10n.selectLanguage,
                  style: AppTypography.title,
                ),
              ),
              ...locales.map((locale) {
                return ListTile(
                  title: Text(locale.nativeName),
                  subtitle: Text(locale.englishName),
                  trailing: locale.languageCode == currentLocale.languageCode
                      ? Icon(AppIcons.save, color: AppColors.primary)
                      : null,
                  onTap: () {
                    ref.read(currentLocaleProvider.notifier).setLocale(locale);
                    Navigator.pop(context);
                  },
                );
              }),
              SizedBox(height: AppDimensions.paddingM),
            ],
          ),
        ),
      );
    }
  }

  void _showCurrencyPicker(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
    String currentCurrency,
  ) {
    if (_isIOS) {
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          title: Text(l10n.selectCurrency),
          actions: SupportedCurrencies.all.map((currency) {
            return CupertinoActionSheetAction(
              onPressed: () {
                ref.read(currencyProvider.notifier).setCurrency(currency);
                Navigator.pop(context);
              },
              isDefaultAction: currency.code == currentCurrency,
              child: Text('${currency.flag} ${currency.name} (${currency.symbol})'),
            );
          }).toList(),
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            isDestructiveAction: true,
            child: Text(l10n.cancel),
          ),
        ),
      );
    } else {
      showModalBottomSheet(
        context: context,
        useRootNavigator: true, // Passe au-dessus de la bottom nav
        builder: (context) => PlatformSafeArea(
          bottom: true, // Respecte les boutons de navigation Android
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(AppDimensions.paddingL),
                child: Text(
                  l10n.selectCurrency,
                  style: AppTypography.title,
                ),
              ),
              Expanded(
                child: ListView(
                  children: SupportedCurrencies.all.map((currency) {
                    return ListTile(
                      leading: Text(
                        currency.flag,
                        style: const TextStyle(fontSize: 24),
                      ),
                      title: Text(currency.name),
                      subtitle: Text('${currency.code} - ${currency.symbol}'),
                      trailing: currency.code == currentCurrency
                          ? Icon(AppIcons.save, color: AppColors.primary)
                          : null,
                      onTap: () {
                        ref.read(currencyProvider.notifier).setCurrency(currency);
                        Navigator.pop(context);
                      },
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: AppDimensions.paddingM),
            ],
          ),
        ),
      );
    }
  }

  /// Obtient l'icône du thème
  IconData _getThemeIcon(ThemeEntity theme) {
    if (theme.isSystem) {
      return AppIcons.settings;
    } else if (theme.isLight) {
      return AppIcons.lightMode;
    } else {
      return AppIcons.darkMode;
    }
  }

  /// Affiche le sélecteur de thème
  void _showThemePicker(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
    ThemeEntity currentTheme,
  ) {
    final themes = [
      ThemeEntity.light(),
      ThemeEntity.dark(),
      ThemeEntity.system(),
    ];

    if (_isIOS) {
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          title: Text(l10n.theme),
          actions: themes.map((theme) {
            return CupertinoActionSheetAction(
              onPressed: () {
                ref.read(themeProvider.notifier).setTheme(theme);
                Navigator.pop(context);
              },
              isDefaultAction: theme.mode == currentTheme.mode,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _getThemeIcon(theme),
                    size: 20,
                    color: theme.mode == currentTheme.mode
                        ? AppColors.primary
                        : (Theme.of(context).brightness == Brightness.dark
                            ? AppColors.textSecondaryOnDark
                            : AppColors.textSecondary),
                  ),
                  SizedBox(width: AppDimensions.paddingS),
                  Text(theme.displayName),
                ],
              ),
            );
          }).toList(),
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            isDestructiveAction: true,
            child: Text(l10n.cancel),
          ),
        ),
      );
    } else {
      showModalBottomSheet(
        context: context,
        useRootNavigator: true, // Passe au-dessus de la bottom nav
        builder: (context) => PlatformSafeArea(
          bottom: true, // Respecte les boutons de navigation Android
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(AppDimensions.paddingL),
                child: Text(
                  l10n.theme,
                  style: AppTypography.title,
                ),
              ),
              ...themes.map((theme) {
                final isSelected = theme.mode == currentTheme.mode;
                return ListTile(
                  leading: Icon(
                    _getThemeIcon(theme),
                    color: isSelected ? AppColors.primary : AppColors.textSecondary,
                  ),
                  title: Text(theme.displayName),
                  trailing: isSelected
                      ? Icon(AppIcons.save, color: AppColors.primary)
                      : null,
                  onTap: () {
                    ref.read(themeProvider.notifier).setTheme(theme);
                    Navigator.pop(context);
                  },
                );
              }),
              SizedBox(height: AppDimensions.paddingM),
            ],
          ),
        ),
      );
    }
  }
}
