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

  /// Welcome greeting
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
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

  /// Transaction history screen title
  ///
  /// In en, this message translates to:
  /// **'Transaction History'**
  String get transactionHistory;

  /// Back button text
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

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

  /// Skip button text
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// Progress indicator for onboarding steps
  ///
  /// In en, this message translates to:
  /// **'Step {current} of {total}'**
  String onboardingStepProgress(int current, int total);

  /// Hero title for onboarding step 1
  ///
  /// In en, this message translates to:
  /// **'Own your money journey'**
  String get onboardingStep1Title;

  /// Description for onboarding step 1
  ///
  /// In en, this message translates to:
  /// **'Pocketly gives you a simple path to follow the 50/30/20 rule, track your expenses and grow your savings.'**
  String get onboardingStep1Description;

  /// Highlight title about budgeting
  ///
  /// In en, this message translates to:
  /// **'Budget like a pro'**
  String get onboardingHighlightBudgetTitle;

  /// Highlight description about budgeting
  ///
  /// In en, this message translates to:
  /// **'Group your essentials, wants and savings in one place with smart limits.'**
  String get onboardingHighlightBudgetDescription;

  /// Highlight title for insights
  ///
  /// In en, this message translates to:
  /// **'Instant insights'**
  String get onboardingHighlightInsightsTitle;

  /// Highlight description for insights
  ///
  /// In en, this message translates to:
  /// **'Understand where every euro goes with live charts and weekly recaps.'**
  String get onboardingHighlightInsightsDescription;

  /// Highlight title for automation
  ///
  /// In en, this message translates to:
  /// **'Automated guidance'**
  String get onboardingHighlightAutomationTitle;

  /// Highlight description for automation
  ///
  /// In en, this message translates to:
  /// **'Pocketly nudges you to stay on track and celebrates every milestone.'**
  String get onboardingHighlightAutomationDescription;

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

  /// No data message
  ///
  /// In en, this message translates to:
  /// **'No data'**
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

  /// Get started button text
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// Title for salary input step
  ///
  /// In en, this message translates to:
  /// **'Define your monthly salary'**
  String get onboardingSalaryTitle;

  /// Subtitle for salary input step
  ///
  /// In en, this message translates to:
  /// **'We apply the 50/30/20 method automatically so you know exactly how much to allocate.'**
  String get onboardingSalarySubtitle;

  /// Label for salary text field
  ///
  /// In en, this message translates to:
  /// **'Monthly net income'**
  String get onboardingSalaryFieldLabel;

  /// Placeholder for salary text field
  ///
  /// In en, this message translates to:
  /// **'e.g. 2500'**
  String get onboardingSalaryFieldHint;

  /// Helper text for salary input
  ///
  /// In en, this message translates to:
  /// **'You can update this later from your profile settings.'**
  String get onboardingSalaryHelper;

  /// Title for salary breakdown cards
  ///
  /// In en, this message translates to:
  /// **'Pocketly splits it for you'**
  String get onboardingSalaryBreakdownTitle;

  /// Error message when salary input is invalid
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid salary amount'**
  String get onboardingSalaryInputError;

  /// Generic continue button text
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get onboardingContinue;

  /// Title for onboarding step 3 notifications
  ///
  /// In en, this message translates to:
  /// **'Activate smart notifications'**
  String get onboardingNotificationsTitle;

  /// Subtitle for onboarding step 3
  ///
  /// In en, this message translates to:
  /// **'Choose the alerts that keep you on track and never miss an important moment.'**
  String get onboardingNotificationsSubtitle;

  /// Description for notifications step
  ///
  /// In en, this message translates to:
  /// **'Pocketly sends respectful notifications only when they matter: budget alerts, goal celebrations and weekly summaries.'**
  String get onboardingNotificationsDescription;

  /// Button text to finish onboarding
  ///
  /// In en, this message translates to:
  /// **'Go to dashboard'**
  String get onboardingFinish;

  /// Title displayed with confetti
  ///
  /// In en, this message translates to:
  /// **'You’re ready!'**
  String get onboardingCongratsTitle;

  /// Subtitle displayed with confetti
  ///
  /// In en, this message translates to:
  /// **'Your finances have a plan. Let’s keep the momentum going in Pocketly.'**
  String get onboardingCongratsSubtitle;

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

  /// Food category name
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get food;

  /// Housing category name
  ///
  /// In en, this message translates to:
  /// **'Housing'**
  String get housing;

  /// Transport category name
  ///
  /// In en, this message translates to:
  /// **'Transport'**
  String get transport;

  /// Health category name
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get health;

  /// Leisure category name
  ///
  /// In en, this message translates to:
  /// **'Leisure'**
  String get leisure;

  /// Shopping category name
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get shopping;

  /// Salary category name
  ///
  /// In en, this message translates to:
  /// **'Salary'**
  String get salary;

  /// Bonus category name
  ///
  /// In en, this message translates to:
  /// **'Bonus'**
  String get bonus;

  /// Investment category name
  ///
  /// In en, this message translates to:
  /// **'Investment'**
  String get investment;

  /// Settings screen title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Profile section title
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// Edit profile screen title
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// Full name label
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// Full name field hint
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get enterFullName;

  /// Message shown while uploading avatar
  ///
  /// In en, this message translates to:
  /// **'Uploading avatar...'**
  String get uploadingAvatar;

  /// Success message after updating profile
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get profileUpdated;

  /// Error message when profile update fails
  ///
  /// In en, this message translates to:
  /// **'Error updating profile'**
  String get errorUpdatingProfile;

  /// Appearance section title
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// Preferences section title
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// Account section title
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// Theme setting label
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// Language setting label
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Currency setting label
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency;

  /// Not available placeholder text
  ///
  /// In en, this message translates to:
  /// **'Not available'**
  String get notAvailable;

  /// Error message when profile fails to load
  ///
  /// In en, this message translates to:
  /// **'Error loading profile'**
  String get errorLoadingProfile;

  /// Language picker title
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// Currency picker title
  ///
  /// In en, this message translates to:
  /// **'Select Currency'**
  String get selectCurrency;

  /// Error message when logout fails
  ///
  /// In en, this message translates to:
  /// **'Failed to logout. Please try again.'**
  String get logoutError;

  /// Confirmation message before logout
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get logoutConfirmation;

  /// Current balance label
  ///
  /// In en, this message translates to:
  /// **'Current Balance'**
  String get currentBalance;

  /// Available balance label (total minus savings)
  ///
  /// In en, this message translates to:
  /// **'Available Balance'**
  String get availableBalance;

  /// Last 24 hours label
  ///
  /// In en, this message translates to:
  /// **'Last 24h'**
  String get last24Hours;

  /// Weekly expenses chart title
  ///
  /// In en, this message translates to:
  /// **'Spent this week'**
  String get weeklyExpenses;

  /// Recent transactions section title
  ///
  /// In en, this message translates to:
  /// **'Recent Transactions'**
  String get recentTransactions;

  /// Label for income card
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get incomeLabel;

  /// Label for expenses card
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get expensesLabel;

  /// See all button text
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// Empty state message for transactions
  ///
  /// In en, this message translates to:
  /// **'No transactions yet'**
  String get noTransactionsYet;

  /// Add transaction button text
  ///
  /// In en, this message translates to:
  /// **'Add Transaction'**
  String get addTransaction;

  /// Statistics button text
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// Statistics screen title
  ///
  /// In en, this message translates to:
  /// **'Your Statistics'**
  String get yourStatistics;

  /// Loading error message
  ///
  /// In en, this message translates to:
  /// **'Loading error'**
  String get loadingError;

  /// No transaction message
  ///
  /// In en, this message translates to:
  /// **'No transaction'**
  String get noTransaction;

  /// For this day message
  ///
  /// In en, this message translates to:
  /// **'for this day'**
  String get forThisDay;

  /// Available message
  ///
  /// In en, this message translates to:
  /// **'available'**
  String get available;

  /// Error message for balance loading
  ///
  /// In en, this message translates to:
  /// **'Failed to load balance'**
  String get failedToLoadBalance;

  /// Error message for expenses loading
  ///
  /// In en, this message translates to:
  /// **'Failed to load expenses'**
  String get failedToLoadExpenses;

  /// Error message for transactions loading
  ///
  /// In en, this message translates to:
  /// **'Failed to load transactions'**
  String get failedToLoadTransactions;

  /// Signin screen welcome title
  ///
  /// In en, this message translates to:
  /// **'Welcome\nback!'**
  String get signinWelcomeTitle;

  /// Signin screen welcome description
  ///
  /// In en, this message translates to:
  /// **'Sign in to your account'**
  String get signinWelcomeDescription;

  /// Email address field label
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get emailAddress;

  /// Forgot password link text
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// Sign in button text
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No account yet text
  ///
  /// In en, this message translates to:
  /// **'No account yet? '**
  String get noAccountYet;

  /// Sign up button text
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// Or text for divider
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// Google button text
  ///
  /// In en, this message translates to:
  /// **'Google'**
  String get google;

  /// Apple button text
  ///
  /// In en, this message translates to:
  /// **'Apple'**
  String get apple;

  /// Sign in success message
  ///
  /// In en, this message translates to:
  /// **'Successfully signed in!'**
  String get signInSuccess;

  /// Reset password screen title
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// Reset password form title
  ///
  /// In en, this message translates to:
  /// **'Create new password'**
  String get resetPasswordTitle;

  /// Reset password subtitle
  ///
  /// In en, this message translates to:
  /// **'Enter your new password to secure your account'**
  String get resetPasswordSubtitle;

  /// New password field label
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPassword;

  /// Confirm password field label
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// Password minimum length validation message
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 12 characters'**
  String get passwordMinLength;

  /// Passwords do not match message
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// Update password button text
  ///
  /// In en, this message translates to:
  /// **'Update Password'**
  String get updatePassword;

  /// Password update success message
  ///
  /// In en, this message translates to:
  /// **'Password updated successfully!'**
  String get passwordUpdatedSuccess;

  /// Redirect message after password update
  ///
  /// In en, this message translates to:
  /// **'Redirecting to sign in...'**
  String get redirectingToSignIn;

  /// Expired reset link error message
  ///
  /// In en, this message translates to:
  /// **'Password reset link has expired. Please request a new one.'**
  String get passwordResetLinkExpired;

  /// Forgot password screen title
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPasswordTitle;

  /// Forgot password subtitle
  ///
  /// In en, this message translates to:
  /// **'Enter your email address and we\'ll send you a link to reset your password'**
  String get forgotPasswordSubtitle;

  /// Send reset link button text
  ///
  /// In en, this message translates to:
  /// **'Send reset link'**
  String get sendResetLink;

  /// Reset email sent success message
  ///
  /// In en, this message translates to:
  /// **'Reset link sent!'**
  String get resetPasswordEmailSent;

  /// Reset email sent description
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent a password reset link to your email. Please check your inbox and follow the instructions.'**
  String get resetPasswordEmailSentDescription;

  /// Check your email title
  ///
  /// In en, this message translates to:
  /// **'Check your email'**
  String get checkYourEmail;

  /// Back to sign in link text
  ///
  /// In en, this message translates to:
  /// **'Back to sign in'**
  String get backToSignIn;

  /// Reset password email info message
  ///
  /// In en, this message translates to:
  /// **'If you don\'t receive the email within a few minutes, please check your spam folder.'**
  String get resetPasswordEmailInfo;

  /// Error dialog title
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get errorTitle;

  /// Unexpected error message
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred'**
  String get unexpectedError;

  /// Google sign in cancelled message
  ///
  /// In en, this message translates to:
  /// **'Google sign in cancelled or failed'**
  String get googleSignInCancelled;

  /// Apple sign in cancelled message
  ///
  /// In en, this message translates to:
  /// **'Apple sign in cancelled or failed'**
  String get appleSignInCancelled;

  /// Email validation required message
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get emailValidationRequired;

  /// Email validation invalid message
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get emailValidationInvalid;

  /// Password validation required message
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get passwordValidationRequired;

  /// Password validation min length message
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 12 characters'**
  String get passwordValidationMinLength;

  /// Rate limit error title
  ///
  /// In en, this message translates to:
  /// **'Too many login attempts'**
  String get tooManyAttempts;

  /// Rate limit error message with time remaining
  ///
  /// In en, this message translates to:
  /// **'Please try again in {minutes} {minutes, plural, =1{minute} other{minutes}}'**
  String rateLimitMessage(int minutes);

  /// Back button label
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get backButton;

  /// Signup screen welcome title
  ///
  /// In en, this message translates to:
  /// **'Create an\naccount'**
  String get signupWelcomeTitle;

  /// Signup screen welcome description
  ///
  /// In en, this message translates to:
  /// **'Join us and start your adventure'**
  String get signupWelcomeDescription;

  /// Already have account text
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get alreadyHaveAccount;

  /// Welcome modal title
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get welcomeModalTitle;

  /// Welcome modal message
  ///
  /// In en, this message translates to:
  /// **'Your 14-day Premium trial is activated'**
  String get welcomeModalMessage;

  /// Get started button text
  ///
  /// In en, this message translates to:
  /// **'Get Started >'**
  String get getStartedButton;

  /// Confirm password required message
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get confirmPasswordRequired;

  /// Error loading user message
  ///
  /// In en, this message translates to:
  /// **'Error loading user'**
  String get errorLoadingUser;

  /// OK button text
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get okButton;

  /// Short day name for Monday
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get monday;

  /// Short day name for Tuesday
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get tuesday;

  /// Short day name for Wednesday
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get wednesday;

  /// Short day name for Thursday
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get thursday;

  /// Short day name for Friday
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get friday;

  /// Short day name for Saturday
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get saturday;

  /// Short day name for Sunday
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get sunday;

  /// Status badge for active user account
  ///
  /// In en, this message translates to:
  /// **'Active Account'**
  String get activeAccount;

  /// Premium account status
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get statusPremium;

  /// Trial account status
  ///
  /// In en, this message translates to:
  /// **'Trial'**
  String get statusTrial;

  /// Free account status
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get statusFree;

  /// Today label
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// Yesterday label
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// Week label
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get week;

  /// Month label
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// Year label
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// This week label
  ///
  /// In en, this message translates to:
  /// **'This week'**
  String get thisWeek;

  /// This month label
  ///
  /// In en, this message translates to:
  /// **'This month'**
  String get thisMonth;

  /// This year label
  ///
  /// In en, this message translates to:
  /// **'This year'**
  String get thisYear;

  /// Transaction details screen title
  ///
  /// In en, this message translates to:
  /// **'Transaction Details'**
  String get transactionDetails;

  /// Total amount spent label
  ///
  /// In en, this message translates to:
  /// **'Total Spent'**
  String get totalSpent;

  /// Budget total label
  ///
  /// In en, this message translates to:
  /// **'Budget total'**
  String get budgetTotal;

  /// Remaining amount label
  ///
  /// In en, this message translates to:
  /// **'Remaining'**
  String get remaining;

  /// Total amount received label
  ///
  /// In en, this message translates to:
  /// **'Total Received'**
  String get totalReceived;

  /// Number of occurrences label
  ///
  /// In en, this message translates to:
  /// **'Occurrences'**
  String get occurrences;

  /// List of transaction occurrences title
  ///
  /// In en, this message translates to:
  /// **'Occurrence History'**
  String get occurrenceHistory;

  /// Since creation date label
  ///
  /// In en, this message translates to:
  /// **'Since creation'**
  String get sinceCreation;

  /// Recurring transaction label
  ///
  /// In en, this message translates to:
  /// **'Recurring Transaction'**
  String get recurringTransaction;

  /// One-time transaction label
  ///
  /// In en, this message translates to:
  /// **'One-time Transaction'**
  String get oneTimeTransaction;

  /// Premium feature title
  ///
  /// In en, this message translates to:
  /// **'Premium Feature'**
  String get premiumFeature;

  /// Premium feature description
  ///
  /// In en, this message translates to:
  /// **'This feature is available for Premium and Trial users'**
  String get premiumFeatureDescription;

  /// Premium benefits title
  ///
  /// In en, this message translates to:
  /// **'Premium Benefits'**
  String get premiumBenefits;

  /// Detailed statistics benefit
  ///
  /// In en, this message translates to:
  /// **'Detailed Statistics'**
  String get detailedStatistics;

  /// Advanced charts benefit
  ///
  /// In en, this message translates to:
  /// **'Advanced Charts'**
  String get advancedCharts;

  /// Financial insights benefit
  ///
  /// In en, this message translates to:
  /// **'Financial Insights'**
  String get financialInsights;

  /// Unlimited history benefit
  ///
  /// In en, this message translates to:
  /// **'Unlimited History'**
  String get unlimitedHistory;

  /// Start free trial button
  ///
  /// In en, this message translates to:
  /// **'Start 14-Day Free Trial'**
  String get startFreeTrial;

  /// Button text to upgrade to premium
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Premium'**
  String get upgradeToPremium;

  /// Trial activated success message
  ///
  /// In en, this message translates to:
  /// **'Trial successfully activated! Enjoy 14 days of Premium features.'**
  String get trialActivated;

  /// Error activating trial message
  ///
  /// In en, this message translates to:
  /// **'Error activating trial. Please try again.'**
  String get errorActivatingTrial;

  /// Coming soon message
  ///
  /// In en, this message translates to:
  /// **'Coming soon! In-app purchases will be available shortly.'**
  String get comingSoon;

  /// Pockets screen title
  ///
  /// In en, this message translates to:
  /// **'Pockets'**
  String get pockets;

  /// Pocket category needs
  ///
  /// In en, this message translates to:
  /// **'Needs'**
  String get pocketCategoryNeeds;

  /// Pocket category wants
  ///
  /// In en, this message translates to:
  /// **'Wants'**
  String get pocketCategoryWants;

  /// Pocket category savings
  ///
  /// In en, this message translates to:
  /// **'Savings'**
  String get pocketCategorySavings;

  /// Default pocket housing
  ///
  /// In en, this message translates to:
  /// **'Housing'**
  String get pocketHousing;

  /// Default pocket food
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get pocketFood;

  /// Default pocket transport
  ///
  /// In en, this message translates to:
  /// **'Transport'**
  String get pocketTransport;

  /// Default pocket entertainment
  ///
  /// In en, this message translates to:
  /// **'Entertainment'**
  String get pocketEntertainment;

  /// Default pocket shopping
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get pocketShopping;

  /// Default pocket emergency fund
  ///
  /// In en, this message translates to:
  /// **'Emergency Fund'**
  String get pocketEmergencyFund;

  /// Default pocket vacation
  ///
  /// In en, this message translates to:
  /// **'Vacation'**
  String get pocketVacation;

  /// Default pocket projects
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get pocketProjects;

  /// Savings goal type none
  ///
  /// In en, this message translates to:
  /// **'No Goal'**
  String get savingsGoalNone;

  /// Savings goal type fixed amount
  ///
  /// In en, this message translates to:
  /// **'Fixed Amount'**
  String get savingsGoalFixedAmount;

  /// Savings goal type target date
  ///
  /// In en, this message translates to:
  /// **'Target with Deadline'**
  String get savingsGoalTargetDate;

  /// Badge for budget exceeded
  ///
  /// In en, this message translates to:
  /// **'Over Budget'**
  String get badgeBudgetExceeded;

  /// Badge for goal reached
  ///
  /// In en, this message translates to:
  /// **'Goal Reached'**
  String get badgeGoalReached;

  /// Error pocket name required
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get errorPocketNameRequired;

  /// Error pocket name too long
  ///
  /// In en, this message translates to:
  /// **'Name is too long (max 100 characters)'**
  String get errorPocketNameTooLong;

  /// Error pocket icon required
  ///
  /// In en, this message translates to:
  /// **'Icon is required'**
  String get errorPocketIconRequired;

  /// Error pocket invalid color
  ///
  /// In en, this message translates to:
  /// **'Invalid color format'**
  String get errorPocketInvalidColor;

  /// Error pocket budget negative
  ///
  /// In en, this message translates to:
  /// **'Budget cannot be negative'**
  String get errorPocketBudgetNegative;

  /// Error pocket spent negative
  ///
  /// In en, this message translates to:
  /// **'Spent amount cannot be negative'**
  String get errorPocketSpentNegative;

  /// Error expense pocket cannot have savings
  ///
  /// In en, this message translates to:
  /// **'Expense pockets cannot have savings'**
  String get errorExpensePocketCannotHaveSavings;

  /// Error savings pocket cannot have budget
  ///
  /// In en, this message translates to:
  /// **'Savings pockets cannot have budget'**
  String get errorSavingsPocketCannotHaveBudget;

  /// Error pocket saved amount negative
  ///
  /// In en, this message translates to:
  /// **'Saved amount cannot be negative'**
  String get errorPocketSavedAmountNegative;

  /// Error pocket monthly savings negative
  ///
  /// In en, this message translates to:
  /// **'Monthly savings cannot be negative'**
  String get errorPocketMonthlySavingsNegative;

  /// Error savings goal amount required
  ///
  /// In en, this message translates to:
  /// **'Target amount is required'**
  String get errorSavingsGoalAmountRequired;

  /// Error savings goal date required
  ///
  /// In en, this message translates to:
  /// **'Target date is required'**
  String get errorSavingsGoalDateRequired;

  /// Error savings goal date past
  ///
  /// In en, this message translates to:
  /// **'Target date must be in the future'**
  String get errorSavingsGoalDatePast;

  /// Recurrence type none
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get recurrenceNone;

  /// Recurrence type daily
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get recurrenceDaily;

  /// Recurrence type weekly
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get recurrenceWeekly;

  /// Recurrence type biweekly
  ///
  /// In en, this message translates to:
  /// **'Biweekly'**
  String get recurrenceBiweekly;

  /// Recurrence type monthly
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get recurrenceMonthly;

  /// Recurrence type quarterly
  ///
  /// In en, this message translates to:
  /// **'Quarterly'**
  String get recurrenceQuarterly;

  /// Recurrence type yearly
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get recurrenceYearly;

  /// Premium subscription title
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get subscriptionPremiumTitle;

  /// Unlock premium features title
  ///
  /// In en, this message translates to:
  /// **'Unlock all\nPremium features'**
  String get subscriptionUnlockFeatures;

  /// Monthly subscription type
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get subscriptionMonthly;

  /// Yearly subscription type
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get subscriptionYearly;

  /// Per month text
  ///
  /// In en, this message translates to:
  /// **'/ month'**
  String get subscriptionPerMonth;

  /// Per year text
  ///
  /// In en, this message translates to:
  /// **'/ year'**
  String get subscriptionPerYear;

  /// Equivalent monthly price
  ///
  /// In en, this message translates to:
  /// **'Or {price} / month'**
  String subscriptionEquivalent(String price);

  /// Savings percentage
  ///
  /// In en, this message translates to:
  /// **'Save {percent}%'**
  String subscriptionSavePercent(int percent);

  /// Best value badge
  ///
  /// In en, this message translates to:
  /// **'Best value'**
  String get subscriptionBestValue;

  /// Start subscription button
  ///
  /// In en, this message translates to:
  /// **'Start now'**
  String get subscriptionStartNow;

  /// Restore purchases button
  ///
  /// In en, this message translates to:
  /// **'Restore purchases'**
  String get subscriptionRestore;

  /// Features list title
  ///
  /// In en, this message translates to:
  /// **'Everything you get:'**
  String get subscriptionFeaturesTitle;

  /// Advanced statistics feature
  ///
  /// In en, this message translates to:
  /// **'Advanced statistics'**
  String get subscriptionFeatureAdvancedStats;

  /// Advanced statistics feature description
  ///
  /// In en, this message translates to:
  /// **'Analyze your spending in depth'**
  String get subscriptionFeatureAdvancedStatsDesc;

  /// Unlimited pockets feature
  ///
  /// In en, this message translates to:
  /// **'Unlimited pockets'**
  String get subscriptionFeatureUnlimitedPockets;

  /// Unlimited pockets feature description
  ///
  /// In en, this message translates to:
  /// **'Create as many pockets as you want'**
  String get subscriptionFeatureUnlimitedPocketsDesc;

  /// Data export feature
  ///
  /// In en, this message translates to:
  /// **'Data export'**
  String get subscriptionFeatureDataExport;

  /// Data export feature description
  ///
  /// In en, this message translates to:
  /// **'Export your data in CSV or PDF'**
  String get subscriptionFeatureDataExportDesc;

  /// Priority support feature
  ///
  /// In en, this message translates to:
  /// **'Priority support'**
  String get subscriptionFeaturePrioritySupport;

  /// Priority support feature description
  ///
  /// In en, this message translates to:
  /// **'Fast and personalized assistance'**
  String get subscriptionFeaturePrioritySupportDesc;

  /// Cloud sync feature
  ///
  /// In en, this message translates to:
  /// **'Cloud sync'**
  String get subscriptionFeatureCloudSync;

  /// Cloud sync feature description
  ///
  /// In en, this message translates to:
  /// **'Access your data anywhere'**
  String get subscriptionFeatureCloudSyncDesc;

  /// Smart reminders feature
  ///
  /// In en, this message translates to:
  /// **'Smart reminders'**
  String get subscriptionFeatureSmartReminders;

  /// Smart reminders feature description
  ///
  /// In en, this message translates to:
  /// **'Never exceed your budget again'**
  String get subscriptionFeatureSmartRemindersDesc;

  /// Terms and conditions text
  ///
  /// In en, this message translates to:
  /// **'By continuing, you accept our Terms of Use\nand Privacy Policy'**
  String get subscriptionTermsAndConditions;

  /// Purchasing subscription loading message
  ///
  /// In en, this message translates to:
  /// **'Processing your purchase...'**
  String get subscriptionPurchasing;

  /// Restoring purchases loading message
  ///
  /// In en, this message translates to:
  /// **'Restoring purchases...'**
  String get subscriptionRestoring;

  /// Purchase success message
  ///
  /// In en, this message translates to:
  /// **'Subscription activated successfully! 🎉'**
  String get subscriptionPurchaseSuccess;

  /// Restore success message
  ///
  /// In en, this message translates to:
  /// **'Purchases restored successfully!'**
  String get subscriptionRestoreSuccess;

  /// Purchase error message
  ///
  /// In en, this message translates to:
  /// **'Error during purchase: {error}'**
  String subscriptionPurchaseError(String error);

  /// Restore error message
  ///
  /// In en, this message translates to:
  /// **'Error during restoration: {error}'**
  String subscriptionRestoreError(String error);

  /// Free trial section title
  ///
  /// In en, this message translates to:
  /// **'Start your Free Trial'**
  String get freeTrialTitle;

  /// Free trial duration
  ///
  /// In en, this message translates to:
  /// **'14 days free'**
  String get freeTrialDuration;

  /// Start free trial button
  ///
  /// In en, this message translates to:
  /// **'Start 14-Day Free Trial'**
  String get freeTrialStartButton;

  /// Free trial description
  ///
  /// In en, this message translates to:
  /// **'Try all Premium features\nfor 14 days, no payment required'**
  String get freeTrialDescription;

  /// Trial active status
  ///
  /// In en, this message translates to:
  /// **'Trial active'**
  String get freeTrialActive;

  /// Days left in trial
  ///
  /// In en, this message translates to:
  /// **'{days} days left'**
  String freeTrialDaysLeft(int days);

  /// Trial expired status
  ///
  /// In en, this message translates to:
  /// **'Trial expired'**
  String get freeTrialExpired;

  /// Activating trial loading message
  ///
  /// In en, this message translates to:
  /// **'Activating your free trial...'**
  String get freeTrialActivating;

  /// Trial activation success message
  ///
  /// In en, this message translates to:
  /// **'Free trial activated! Enjoy 14 days of Premium 🎉'**
  String get freeTrialActivationSuccess;

  /// Trial activation error message
  ///
  /// In en, this message translates to:
  /// **'Error activating trial: {error}'**
  String freeTrialActivationError(String error);

  /// Trial already used message
  ///
  /// In en, this message translates to:
  /// **'You have already used your free trial'**
  String get freeTrialAlreadyUsed;

  /// After trial label
  ///
  /// In en, this message translates to:
  /// **'After trial'**
  String get subscriptionAfterTrial;

  /// Continue with premium after trial
  ///
  /// In en, this message translates to:
  /// **'Continue with Premium'**
  String get subscriptionContinueWithPremium;

  /// All filter tab
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// Empty state message when no pockets
  ///
  /// In en, this message translates to:
  /// **'No pockets yet'**
  String get noPocketsYet;

  /// Empty state subtitle to create first pocket
  ///
  /// In en, this message translates to:
  /// **'Create your first pocket to get started'**
  String get createFirstPocket;

  /// Empty state message when no pockets in filtered category
  ///
  /// In en, this message translates to:
  /// **'No pockets in this category'**
  String get noPocketsInCategory;

  /// Button to create default pockets
  ///
  /// In en, this message translates to:
  /// **'Create default pockets'**
  String get createDefaultPockets;

  /// Title for adding logo to transaction
  ///
  /// In en, this message translates to:
  /// **'Add Transaction Logo'**
  String get addTransactionLogo;

  /// Message for logo source selection
  ///
  /// In en, this message translates to:
  /// **'Choose a logo source for your transaction'**
  String get chooseLogoSource;

  /// Option to choose from photo library
  ///
  /// In en, this message translates to:
  /// **'Photo Library'**
  String get photoLibrary;

  /// Option to search for brand logo
  ///
  /// In en, this message translates to:
  /// **'Search Brand Logo'**
  String get searchBrandLogo;

  /// Title for brand selection modal
  ///
  /// In en, this message translates to:
  /// **'Select a Brand'**
  String get selectBrand;

  /// No description provided for @information.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get information;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @image.
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get image;

  /// Expense label
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get expense;

  /// Income label
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get income;

  /// No description provided for @assigned.
  ///
  /// In en, this message translates to:
  /// **'Assigned'**
  String get assigned;

  /// No description provided for @deleteTransactionTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete transaction'**
  String get deleteTransactionTitle;

  /// No description provided for @deleteTransactionMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this transaction? This action is irreversible.'**
  String get deleteTransactionMessage;

  /// No description provided for @transactionDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Transaction deleted successfully'**
  String get transactionDeletedSuccess;

  /// No description provided for @transactionDeleteError.
  ///
  /// In en, this message translates to:
  /// **'Unable to delete transaction'**
  String get transactionDeleteError;

  /// No description provided for @recurrence.
  ///
  /// In en, this message translates to:
  /// **'Recurrence'**
  String get recurrence;

  /// No description provided for @deletePocketTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete pocket'**
  String get deletePocketTitle;

  /// No description provided for @deletePocketMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this pocket? This action is irreversible.'**
  String get deletePocketMessage;

  /// No description provided for @pocketDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Pocket deleted successfully'**
  String get pocketDeletedSuccess;

  /// No description provided for @pocketDeleteError.
  ///
  /// In en, this message translates to:
  /// **'Unable to delete pocket'**
  String get pocketDeleteError;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @notificationsCenter.
  ///
  /// In en, this message translates to:
  /// **'Notification Center'**
  String get notificationsCenter;

  /// No description provided for @notificationsSettings.
  ///
  /// In en, this message translates to:
  /// **'Notification Settings'**
  String get notificationsSettings;

  /// No description provided for @notificationType.
  ///
  /// In en, this message translates to:
  /// **'Notification Type'**
  String get notificationType;

  /// No description provided for @notificationTypes.
  ///
  /// In en, this message translates to:
  /// **'Notification Types'**
  String get notificationTypes;

  /// No description provided for @budgetExceededNotif.
  ///
  /// In en, this message translates to:
  /// **'Budget Exceeded'**
  String get budgetExceededNotif;

  /// No description provided for @budgetExceededNotifDesc.
  ///
  /// In en, this message translates to:
  /// **'Get alerted when a pocket budget is exceeded'**
  String get budgetExceededNotifDesc;

  /// No description provided for @goalReachedNotif.
  ///
  /// In en, this message translates to:
  /// **'Goal Reached'**
  String get goalReachedNotif;

  /// No description provided for @goalReachedNotifDesc.
  ///
  /// In en, this message translates to:
  /// **'Receive a notification when a savings goal is reached'**
  String get goalReachedNotifDesc;

  /// No description provided for @monthEndReminderNotif.
  ///
  /// In en, this message translates to:
  /// **'Month-End Reminder'**
  String get monthEndReminderNotif;

  /// No description provided for @monthEndReminderNotifDesc.
  ///
  /// In en, this message translates to:
  /// **'Receive a reminder at the end of the month'**
  String get monthEndReminderNotifDesc;

  /// No description provided for @weeklySummaryNotif.
  ///
  /// In en, this message translates to:
  /// **'Weekly Summary'**
  String get weeklySummaryNotif;

  /// No description provided for @weeklySummaryNotifDesc.
  ///
  /// In en, this message translates to:
  /// **'Receive a summary of your finances every week'**
  String get weeklySummaryNotifDesc;

  /// No description provided for @monthlyReportNotif.
  ///
  /// In en, this message translates to:
  /// **'Monthly Report'**
  String get monthlyReportNotif;

  /// No description provided for @monthlyReportNotifDesc.
  ///
  /// In en, this message translates to:
  /// **'Receive a detailed report every month'**
  String get monthlyReportNotifDesc;

  /// No description provided for @markAsRead.
  ///
  /// In en, this message translates to:
  /// **'Mark as read'**
  String get markAsRead;

  /// No description provided for @markAsUnread.
  ///
  /// In en, this message translates to:
  /// **'Mark as unread'**
  String get markAsUnread;

  /// No description provided for @markAllAsRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all as read'**
  String get markAllAsRead;

  /// No description provided for @deleteNotification.
  ///
  /// In en, this message translates to:
  /// **'Delete notification'**
  String get deleteNotification;

  /// No description provided for @deleteAllNotifications.
  ///
  /// In en, this message translates to:
  /// **'Delete all'**
  String get deleteAllNotifications;

  /// No description provided for @noNotifications.
  ///
  /// In en, this message translates to:
  /// **'No notifications'**
  String get noNotifications;

  /// No description provided for @noNotificationsMessage.
  ///
  /// In en, this message translates to:
  /// **'You have no notifications at the moment'**
  String get noNotificationsMessage;

  /// No description provided for @unreadNotifications.
  ///
  /// In en, this message translates to:
  /// **'Unread'**
  String get unreadNotifications;

  /// No description provided for @readNotifications.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get readNotifications;

  /// No description provided for @allNotifications.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get allNotifications;

  /// No description provided for @notificationRead.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get notificationRead;

  /// No description provided for @notificationUnread.
  ///
  /// In en, this message translates to:
  /// **'Unread'**
  String get notificationUnread;

  /// No description provided for @notificationDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Notification deleted'**
  String get notificationDeletedSuccess;

  /// No description provided for @notificationDeleteError.
  ///
  /// In en, this message translates to:
  /// **'Unable to delete notification'**
  String get notificationDeleteError;

  /// No description provided for @notificationsPreferences.
  ///
  /// In en, this message translates to:
  /// **'Notification Preferences'**
  String get notificationsPreferences;

  /// No description provided for @enableNotificationsPrompt.
  ///
  /// In en, this message translates to:
  /// **'Enable notifications to stay informed'**
  String get enableNotificationsPrompt;

  /// No description provided for @createPocket.
  ///
  /// In en, this message translates to:
  /// **'Create Pocket'**
  String get createPocket;

  /// No description provided for @addNeedsPocket.
  ///
  /// In en, this message translates to:
  /// **'Add Needs Pocket'**
  String get addNeedsPocket;

  /// No description provided for @addWantsPocket.
  ///
  /// In en, this message translates to:
  /// **'Add Wants Pocket'**
  String get addWantsPocket;

  /// No description provided for @addSavingsPocket.
  ///
  /// In en, this message translates to:
  /// **'Add Savings Pocket'**
  String get addSavingsPocket;

  /// No description provided for @selectPocketCategory.
  ///
  /// In en, this message translates to:
  /// **'Select a Category'**
  String get selectPocketCategory;

  /// No description provided for @selectPocketCategoryDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose the type of pocket you want to create according to the 50/30/20 rule'**
  String get selectPocketCategoryDescription;

  /// No description provided for @needsDescription.
  ///
  /// In en, this message translates to:
  /// **'Essential expenses like housing, food, and transportation'**
  String get needsDescription;

  /// No description provided for @wantsDescription.
  ///
  /// In en, this message translates to:
  /// **'Discretionary spending like entertainment, hobbies, and shopping'**
  String get wantsDescription;

  /// No description provided for @savingsDescription.
  ///
  /// In en, this message translates to:
  /// **'Money set aside for future goals, emergencies, and investments'**
  String get savingsDescription;

  /// No description provided for @pocketName.
  ///
  /// In en, this message translates to:
  /// **'Pocket Name'**
  String get pocketName;

  /// No description provided for @pocketNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., Groceries, Rent, Vacation'**
  String get pocketNameHint;

  /// No description provided for @savingsPocketNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., Emergency Fund, Vacation, New Car'**
  String get savingsPocketNameHint;

  /// No description provided for @monthlyBudget.
  ///
  /// In en, this message translates to:
  /// **'Monthly Budget'**
  String get monthlyBudget;

  /// No description provided for @monthlySavingsAmount.
  ///
  /// In en, this message translates to:
  /// **'Monthly Savings Amount'**
  String get monthlySavingsAmount;

  /// No description provided for @monthlySavingsHint.
  ///
  /// In en, this message translates to:
  /// **'Optional automatic monthly savings'**
  String get monthlySavingsHint;

  /// No description provided for @targetAmount.
  ///
  /// In en, this message translates to:
  /// **'Target Amount'**
  String get targetAmount;

  /// No description provided for @targetDate.
  ///
  /// In en, this message translates to:
  /// **'Target Date'**
  String get targetDate;

  /// No description provided for @selectTargetDate.
  ///
  /// In en, this message translates to:
  /// **'Select a target date'**
  String get selectTargetDate;

  /// No description provided for @savingsGoalType.
  ///
  /// In en, this message translates to:
  /// **'Savings Goal Type'**
  String get savingsGoalType;

  /// No description provided for @savingsGoalNoneDescription.
  ///
  /// In en, this message translates to:
  /// **'Simple savings without a specific goal'**
  String get savingsGoalNoneDescription;

  /// No description provided for @savingsGoalFixedAmountDescription.
  ///
  /// In en, this message translates to:
  /// **'Save until reaching a specific amount'**
  String get savingsGoalFixedAmountDescription;

  /// No description provided for @savingsGoalTargetDateDescription.
  ///
  /// In en, this message translates to:
  /// **'Reach a goal by a specific date'**
  String get savingsGoalTargetDateDescription;

  /// No description provided for @selectIcon.
  ///
  /// In en, this message translates to:
  /// **'Select an Icon'**
  String get selectIcon;

  /// No description provided for @selectColor.
  ///
  /// In en, this message translates to:
  /// **'Select a Color'**
  String get selectColor;

  /// No description provided for @errorBudgetRequired.
  ///
  /// In en, this message translates to:
  /// **'Budget is required'**
  String get errorBudgetRequired;

  /// No description provided for @errorCreatingPocket.
  ///
  /// In en, this message translates to:
  /// **'Error creating pocket'**
  String get errorCreatingPocket;

  /// Pocket details screen title
  ///
  /// In en, this message translates to:
  /// **'Pocket Details'**
  String get pocketDetails;

  /// Edit pocket screen title
  ///
  /// In en, this message translates to:
  /// **'Edit Pocket'**
  String get editPocket;

  /// Error message when pocket is not found
  ///
  /// In en, this message translates to:
  /// **'Pocket not found'**
  String get pocketNotFound;

  /// Pocket not found detailed message
  ///
  /// In en, this message translates to:
  /// **'This pocket does not exist or has been deleted'**
  String get pocketNotFoundMessage;

  /// Message when trying to edit default pocket name
  ///
  /// In en, this message translates to:
  /// **'Default pocket names cannot be modified'**
  String get defaultPocketNameCannotBeModified;

  /// Savings goal label
  ///
  /// In en, this message translates to:
  /// **'Savings Goal'**
  String get savingsGoal;

  /// Target amount field label
  ///
  /// In en, this message translates to:
  /// **'Target Amount'**
  String get targetAmountLabel;

  /// Invalid amount error message
  ///
  /// In en, this message translates to:
  /// **'Invalid amount'**
  String get invalidAmount;

  /// Category label
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// Non editable indicator
  ///
  /// In en, this message translates to:
  /// **'(Non editable)'**
  String get nonEditable;

  /// Saving in progress message
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get saving;

  /// Assign transactions button label
  ///
  /// In en, this message translates to:
  /// **'Assign Transactions'**
  String get assignTransactions;

  /// Assign transactions screen title with pocket name
  ///
  /// In en, this message translates to:
  /// **'Assign to {pocketName}'**
  String assignTransactionsTo(String pocketName);

  /// Search transaction field label and hint
  ///
  /// In en, this message translates to:
  /// **'Search for a transaction...'**
  String get searchTransaction;

  /// Empty state when no expenses available
  ///
  /// In en, this message translates to:
  /// **'No expenses available'**
  String get noExpensesAvailable;

  /// Empty state when search returns no results
  ///
  /// In en, this message translates to:
  /// **'No expenses found'**
  String get noExpensesFound;

  /// Message to create expense transactions first
  ///
  /// In en, this message translates to:
  /// **'Create expense transactions first'**
  String get createExpenseTransactionsFirst;

  /// Message when search returns no results
  ///
  /// In en, this message translates to:
  /// **'Try with other keywords'**
  String get tryOtherKeywords;

  /// Message when transaction is assigned to another pocket
  ///
  /// In en, this message translates to:
  /// **'Already assigned to another pocket'**
  String get alreadyAssignedToOtherPocket;

  /// Message when transaction is assigned to current pocket
  ///
  /// In en, this message translates to:
  /// **'Assigned to this pocket (uncheck to remove)'**
  String get assignedToThisPocket;

  /// Message showing transactions to assign and remove
  ///
  /// In en, this message translates to:
  /// **'{toAssign} to assign, {toRemove} to remove'**
  String transactionsToAssignAndRemove(int toAssign, int toRemove);

  /// Message showing transactions to assign
  ///
  /// In en, this message translates to:
  /// **'{count} transaction{count, plural, =1{} other{s}} to assign'**
  String transactionsToAssign(int count);

  /// Message showing transactions to remove
  ///
  /// In en, this message translates to:
  /// **'{count} transaction{count, plural, =1{} other{s}} to remove'**
  String transactionsToRemove(int count);

  /// Message when modifications are in progress
  ///
  /// In en, this message translates to:
  /// **'Modifying...'**
  String get modifyingInProgress;

  /// Button to validate modifications
  ///
  /// In en, this message translates to:
  /// **'Validate modifications'**
  String get validateModifications;

  /// Error message when transaction is not found
  ///
  /// In en, this message translates to:
  /// **'Transaction not found'**
  String get transactionNotFound;

  /// Success message when transactions are assigned and removed
  ///
  /// In en, this message translates to:
  /// **'{assigned} transaction{assigned, plural, =1{ assigned} other{s assigned}}, {removed} removed{removed, plural, =1{} other{s}}'**
  String transactionsAssignedAndRemoved(int assigned, int removed);

  /// Success message when transactions are assigned
  ///
  /// In en, this message translates to:
  /// **'{count} transaction{count, plural, =1{ assigned} other{s assigned}}'**
  String transactionsAssigned(int count);

  /// Success message when transactions are removed
  ///
  /// In en, this message translates to:
  /// **'{count} transaction{count, plural, =1{ removed} other{s removed}}'**
  String transactionsRemoved(int count);

  /// Active status label
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// Inactive status label
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactive;

  /// Default label
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get defaultLabel;

  /// Budget label
  ///
  /// In en, this message translates to:
  /// **'Budget'**
  String get budget;

  /// Spent label
  ///
  /// In en, this message translates to:
  /// **'Spent'**
  String get spent;

  /// Progress label
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progress;

  /// Savings label
  ///
  /// In en, this message translates to:
  /// **'Savings'**
  String get savings;

  /// Saved amount label
  ///
  /// In en, this message translates to:
  /// **'Saved Amount'**
  String get savedAmount;

  /// Goal label
  ///
  /// In en, this message translates to:
  /// **'Goal'**
  String get goal;

  /// Progression label
  ///
  /// In en, this message translates to:
  /// **'Progression'**
  String get progression;

  /// Option to add a category
  ///
  /// In en, this message translates to:
  /// **'Add Category'**
  String get addCategory;

  /// Label for More menu
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// Categories screen title
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// Section title for default categories
  ///
  /// In en, this message translates to:
  /// **'Default Categories'**
  String get defaultCategories;

  /// Section title for custom categories
  ///
  /// In en, this message translates to:
  /// **'Custom Categories'**
  String get customCategories;

  /// Custom label
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get custom;

  /// Default category label
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get defaultCategory;

  /// Create category button text
  ///
  /// In en, this message translates to:
  /// **'Create Category'**
  String get createCategory;

  /// Edit category screen title
  ///
  /// In en, this message translates to:
  /// **'Edit Category'**
  String get editCategory;

  /// Update category button text
  ///
  /// In en, this message translates to:
  /// **'Update Category'**
  String get updateCategory;

  /// Delete category button text
  ///
  /// In en, this message translates to:
  /// **'Delete Category'**
  String get deleteCategory;

  /// Category name field label
  ///
  /// In en, this message translates to:
  /// **'Category Name'**
  String get categoryName;

  /// Category name field hint
  ///
  /// In en, this message translates to:
  /// **'e.g., Groceries, Rent, Utilities'**
  String get categoryNameHint;

  /// Category type field label
  ///
  /// In en, this message translates to:
  /// **'Category Type'**
  String get categoryType;

  /// Expenses label
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get expenses;

  /// Incomes label
  ///
  /// In en, this message translates to:
  /// **'Incomes'**
  String get incomes;

  /// Expense category label
  ///
  /// In en, this message translates to:
  /// **'Expense Category'**
  String get expenseCategory;

  /// Income category label
  ///
  /// In en, this message translates to:
  /// **'Income Category'**
  String get incomeCategory;

  /// Expense category description
  ///
  /// In en, this message translates to:
  /// **'Track your spending and manage your budget'**
  String get expenseCategoryDescription;

  /// Income category description
  ///
  /// In en, this message translates to:
  /// **'Track your earnings and revenue sources'**
  String get incomeCategoryDescription;

  /// Empty state title when no categories found
  ///
  /// In en, this message translates to:
  /// **'No Categories Found'**
  String get noCategoriesFound;

  /// Empty state description when no categories found
  ///
  /// In en, this message translates to:
  /// **'Create your first custom category to get started'**
  String get noCategoriesFoundDescription;

  /// Premium required message
  ///
  /// In en, this message translates to:
  /// **'Premium Required'**
  String get premiumRequired;

  /// Premium required message for custom categories
  ///
  /// In en, this message translates to:
  /// **'Premium subscription required to create custom categories'**
  String get premiumRequiredForCustomCategories;

  /// Error message when category name is empty
  ///
  /// In en, this message translates to:
  /// **'Category name is required'**
  String get errorCategoryNameRequired;

  /// Error message when category name is too long
  ///
  /// In en, this message translates to:
  /// **'Category name must be less than 50 characters'**
  String get errorCategoryNameTooLong;

  /// Error message when category creation fails
  ///
  /// In en, this message translates to:
  /// **'Failed to create category'**
  String get errorCreatingCategory;

  /// Error message when category update fails
  ///
  /// In en, this message translates to:
  /// **'Failed to update category'**
  String get errorUpdatingCategory;

  /// Error message when category deletion fails
  ///
  /// In en, this message translates to:
  /// **'Failed to delete category'**
  String get errorDeletingCategory;

  /// Success message when category is created
  ///
  /// In en, this message translates to:
  /// **'Category created successfully'**
  String get categoryCreatedSuccess;

  /// Success message when category is updated
  ///
  /// In en, this message translates to:
  /// **'Category updated successfully'**
  String get categoryUpdatedSuccess;

  /// Success message when category is deleted
  ///
  /// In en, this message translates to:
  /// **'Category deleted successfully'**
  String get categoryDeletedSuccess;

  /// Confirmation message when deleting a category
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this category? This action cannot be undone.'**
  String get deleteCategoryConfirmation;

  /// Title when user has no custom categories (premium user)
  ///
  /// In en, this message translates to:
  /// **'No Custom Categories Yet'**
  String get noCustomCategoriesYet;

  /// Description when user has no custom categories (premium user)
  ///
  /// In en, this message translates to:
  /// **'Create your first custom category to better organize your finances'**
  String get noCustomCategoriesYetDescription;

  /// Title when user has no custom categories (free user)
  ///
  /// In en, this message translates to:
  /// **'Unlock Custom Categories'**
  String get noCustomCategoriesPremium;

  /// Description when user has no custom categories (free user)
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Premium to create unlimited custom categories'**
  String get noCustomCategoriesPremiumDescription;

  /// Button text to create first custom category
  ///
  /// In en, this message translates to:
  /// **'Create First Category'**
  String get createFirstCategory;

  /// Button text to delete account
  ///
  /// In en, this message translates to:
  /// **'Delete Account & Data'**
  String get deleteAccount;

  /// Title for delete account confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Delete Account?'**
  String get deleteAccountConfirmTitle;

  /// Message for delete account confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'This will permanently delete your account and ALL associated data:\n\n• All transactions\n• All custom categories\n• All pockets\n• All settings\n\nThis action CANNOT be undone.'**
  String get deleteAccountConfirmMessage;

  /// Confirm button text for delete account dialog
  ///
  /// In en, this message translates to:
  /// **'Yes, Delete Everything'**
  String get deleteAccountConfirmButton;

  /// Success message after account deletion
  ///
  /// In en, this message translates to:
  /// **'Account successfully deleted'**
  String get accountDeleted;

  /// Error message when account deletion fails
  ///
  /// In en, this message translates to:
  /// **'Failed to delete account'**
  String get errorDeletingAccount;

  /// Legal notice menu item
  ///
  /// In en, this message translates to:
  /// **'Legal Notice'**
  String get legalNotice;

  /// Privacy policy menu item
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// Terms of use menu item
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get termsOfUse;

  /// Legal section title
  ///
  /// In en, this message translates to:
  /// **'Legal'**
  String get legal;

  /// About section title
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// About the app button text
  ///
  /// In en, this message translates to:
  /// **'About the app'**
  String get aboutApp;

  /// About modal title
  ///
  /// In en, this message translates to:
  /// **'Pocketly'**
  String get aboutAppTitle;

  /// About app description
  ///
  /// In en, this message translates to:
  /// **'A simple and intuitive app to visualize your expenses by week and month, and save smartly with the 50/30/20 method.'**
  String get aboutAppDescription;

  /// About feature: weekly view
  ///
  /// In en, this message translates to:
  /// **'Quick weekly expense visualization'**
  String get aboutFeatureWeeklyView;

  /// About feature: monthly tracking
  ///
  /// In en, this message translates to:
  /// **'Detailed monthly tracking'**
  String get aboutFeatureMonthlyTracking;

  /// About feature: 50/30/20 method
  ///
  /// In en, this message translates to:
  /// **'Save with the 50/30/20 method'**
  String get aboutFeature503020;

  /// About creator message
  ///
  /// In en, this message translates to:
  /// **'Created with ❤️ by Minhaj'**
  String get aboutCreator;

  /// Visit website button
  ///
  /// In en, this message translates to:
  /// **'Visit website'**
  String get visitWebsite;

  /// Close button
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @errorEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get errorEmailRequired;

  /// No description provided for @errorPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get errorPasswordRequired;

  /// No description provided for @errorPasswordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get errorPasswordMinLength;

  /// No description provided for @errorInvalidAmount.
  ///
  /// In en, this message translates to:
  /// **'Invalid amount'**
  String get errorInvalidAmount;

  /// No description provided for @errorAmountNegative.
  ///
  /// In en, this message translates to:
  /// **'Amount cannot be negative'**
  String get errorAmountNegative;

  /// No description provided for @errorAmountPositive.
  ///
  /// In en, this message translates to:
  /// **'Amount must be positive'**
  String get errorAmountPositive;

  /// No description provided for @errorTransactionNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Transaction name is required'**
  String get errorTransactionNameRequired;

  /// No description provided for @errorUserNotAuthenticated.
  ///
  /// In en, this message translates to:
  /// **'User not authenticated'**
  String get errorUserNotAuthenticated;

  /// No description provided for @errorNetworkConnection.
  ///
  /// In en, this message translates to:
  /// **'Network connection error'**
  String get errorNetworkConnection;

  /// No description provided for @errorServerError.
  ///
  /// In en, this message translates to:
  /// **'Server error'**
  String get errorServerError;

  /// No description provided for @errorCacheOperation.
  ///
  /// In en, this message translates to:
  /// **'Cache operation error'**
  String get errorCacheOperation;

  /// No description provided for @errorCategoryNotFound.
  ///
  /// In en, this message translates to:
  /// **'Category not found'**
  String get errorCategoryNotFound;

  /// No description provided for @errorInvalidData.
  ///
  /// In en, this message translates to:
  /// **'Invalid data'**
  String get errorInvalidData;

  /// No description provided for @errorSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Save failed'**
  String get errorSaveFailed;

  /// No description provided for @errorLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Load failed'**
  String get errorLoadFailed;

  /// No description provided for @errorDeleteFailed.
  ///
  /// In en, this message translates to:
  /// **'Delete failed'**
  String get errorDeleteFailed;

  /// No description provided for @errorInitializationFailed.
  ///
  /// In en, this message translates to:
  /// **'Initialization failed'**
  String get errorInitializationFailed;
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
