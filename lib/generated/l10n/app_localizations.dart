import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Pocketly'**
  String get appTitle;

  /// Welcome message displayed to users
  ///
  /// In en, this message translates to:
  /// **'Welcome to Pocketly'**
  String get welcome;

  /// Login button text
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Logout button text
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// Email field label
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Password field label
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Transactions section title
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get transactions;

  /// Balance label
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get balance;

  /// Amount field label
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// Date field label
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// Description field label
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// Save button text
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Delete button text
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Edit button text
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// Add button text
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// Error message title
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// Success message title
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// Loading indicator text
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Message when no data is available
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get noData;

  /// Retry button text
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Welcome screen title
  ///
  /// In en, this message translates to:
  /// **'Welcome to Pocketly'**
  String get welcomeTitle;

  /// Welcome screen description
  ///
  /// In en, this message translates to:
  /// **'Your personal finance companion that helps you track expenses, manage budgets, and achieve your financial goals.'**
  String get welcomeDescription;

  /// Track spending feature title
  ///
  /// In en, this message translates to:
  /// **'Track Your Spending'**
  String get trackSpendingTitle;

  /// Track spending feature description
  ///
  /// In en, this message translates to:
  /// **'Get insights into your spending patterns with beautiful charts and detailed analytics to make informed financial decisions.'**
  String get trackSpendingDescription;

  /// Save smart feature title
  ///
  /// In en, this message translates to:
  /// **'Save Smart'**
  String get saveSmartTitle;

  /// Save smart feature description
  ///
  /// In en, this message translates to:
  /// **'Set savings goals, track your progress, and get personalized tips to help you save more money every month.'**
  String get saveSmartDescription;

  /// Security feature title
  ///
  /// In en, this message translates to:
  /// **'Secure & Private'**
  String get secureTitle;

  /// Security feature description
  ///
  /// In en, this message translates to:
  /// **'Your financial data is encrypted and stored securely. We never share your information with third parties.'**
  String get secureDescription;

  /// Get started button text
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// Title for notification permission dialog
  ///
  /// In en, this message translates to:
  /// **'Notification Permission'**
  String get notificationPermissionTitle;

  /// Message for notification permission dialog
  ///
  /// In en, this message translates to:
  /// **'We need your permission to send you notifications'**
  String get notificationPermissionMessage;

  /// Message when notification permission is denied
  ///
  /// In en, this message translates to:
  /// **'Notification permission denied'**
  String get notificationPermissionDenied;

  /// Message when notification is scheduled
  ///
  /// In en, this message translates to:
  /// **'Notification scheduled'**
  String get notificationScheduled;

  /// Message when notification is cancelled
  ///
  /// In en, this message translates to:
  /// **'Notification cancelled'**
  String get notificationCancelled;

  /// Button text to enable notifications
  ///
  /// In en, this message translates to:
  /// **'Enable Notifications'**
  String get enableNotifications;

  /// Title for notification settings screen
  ///
  /// In en, this message translates to:
  /// **'Notification Settings'**
  String get notificationSettings;

  /// Title for reminder notifications
  ///
  /// In en, this message translates to:
  /// **'Reminder'**
  String get reminderNotification;

  /// Title for transaction notifications
  ///
  /// In en, this message translates to:
  /// **'Transaction'**
  String get transactionNotification;

  /// Title for notification error messages
  ///
  /// In en, this message translates to:
  /// **'Notification Error'**
  String get notificationErrorTitle;

  /// Error message when notification permission is denied
  ///
  /// In en, this message translates to:
  /// **'Notification permission denied. Please enable notifications in your device settings.'**
  String get notificationPermissionError;

  /// Error message when notification scheduling fails
  ///
  /// In en, this message translates to:
  /// **'Failed to schedule notification. Please try again.'**
  String get notificationScheduleError;

  /// Error message when showing notification fails
  ///
  /// In en, this message translates to:
  /// **'Failed to show notification. Please try again.'**
  String get notificationShowError;

  /// Error message when canceling notification fails
  ///
  /// In en, this message translates to:
  /// **'Failed to cancel notification. Please try again.'**
  String get notificationCancelError;

  /// Error message when notification initialization fails
  ///
  /// In en, this message translates to:
  /// **'Failed to initialize notifications. Please restart the app.'**
  String get notificationInitializeError;

  /// Success notification title
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get notificationSuccess;

  /// Success notification message
  ///
  /// In en, this message translates to:
  /// **'Operation completed successfully'**
  String get notificationSuccessMessage;

  /// Error notification title
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get notificationError;

  /// Error notification message
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get notificationErrorMessage;

  /// Info notification title
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get notificationInfo;

  /// Info notification message
  ///
  /// In en, this message translates to:
  /// **'Important information'**
  String get notificationInfoMessage;

  /// Warning notification title
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get notificationWarning;

  /// Warning notification message
  ///
  /// In en, this message translates to:
  /// **'Attention required'**
  String get notificationWarningMessage;

  /// Action notification title
  ///
  /// In en, this message translates to:
  /// **'Action Required'**
  String get notificationAction;

  /// Action notification message
  ///
  /// In en, this message translates to:
  /// **'An action is required'**
  String get notificationActionMessage;

  /// Action button text
  ///
  /// In en, this message translates to:
  /// **'Action'**
  String get notificationActionButton;

  /// Loading notification title
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get notificationLoading;

  /// Loading notification message
  ///
  /// In en, this message translates to:
  /// **'Please wait...'**
  String get notificationLoadingMessage;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
